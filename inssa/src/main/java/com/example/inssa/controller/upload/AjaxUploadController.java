package com.example.inssa.controller.upload;

import java.io.File;
import java.io.FileInputStream;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.inssa.service.shop.ProductService;
import com.example.inssa.util.MediaUtils;
import com.example.inssa.util.UploadFileUtils;


@Controller
public class AjaxUploadController {
	
	private static final Logger logger = LoggerFactory.getLogger(AjaxUploadController.class);
	
	@Inject
	ProductService productService;
	
	//servlet-context.xml에 선언된 값
	@Resource(name="uploadPath")
	String uploadPath;	

	@RequestMapping(value="/upload/uploadAjax", method=RequestMethod.POST, produces="text/plain;charset=utf-8")
	@ResponseBody
	public ResponseEntity<String> uploadAjax(MultipartFile file) throws Exception {
		/*logger.info("originalName:"+file.getOriginalFilename());
		logger.info("size:"+file.getSize());
		logger.info("contentType:"+file.getContentType());*/
		String contentType = file.getContentType(); 
		if(contentType.indexOf("image") >= 0) {
			return new ResponseEntity<String>(UploadFileUtils.uploadFile(uploadPath, file.getOriginalFilename(), file.getBytes()), HttpStatus.OK);
		}else {
			return new ResponseEntity<String>("", HttpStatus.OK);
		}		
	}
	
	@ResponseBody
	@RequestMapping("/upload/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		FileInputStream in = null;
		ResponseEntity<byte[]> entity = null;
		try {
			//파일의 확장자 검사
			//test.jpg	 a.b.c.d.jpg
			String formatName = fileName.substring(fileName.lastIndexOf(".")+1);//확장자=>jpg
			MediaType mType = MediaUtils.getMediaType(formatName);
			//헤더를 생성
			HttpHeaders headers = new HttpHeaders();
			in = new FileInputStream(uploadPath+fileName);
			if(mType != null) {//이미지 파일인 경우
				headers.setContentType(mType);
			}else {//이미지 파일이 아닌 경우
				fileName = fileName.substring(fileName.indexOf("_")+1);//uuid를 제외한 파일 이름
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);//컨텐트 타입
				//파일이름에 한글이 들어간 경우
				//스트링.getBytes("언어셋") 스트링을 바이트 배열로 변환
				//new String (바이트배열, "언어셋") 문자열의 인코딩 변경
				fileName = new String(fileName.getBytes("utf-8"), "iso-8859-1");
				headers.add("Content-Disposition", "attachment; filename=\""+fileName+"\"");//첨부파일 정보
			}
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.OK);
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}finally {
			if(in != null) in.close();
		}
		
		return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="/upload/deleteFile", method=RequestMethod.POST)
	public ResponseEntity<String> deleteFile(String fileName){
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		MediaType mType = MediaUtils.getMediaType(formatName);
		if(mType != null) {//이미지 파일의 경우
			String front = fileName.substring(0, 1);
			String end = fileName.substring(3);
			new File(uploadPath+(front+end).replace('/', File.separatorChar)).delete();//이미지일땐 그냥 파일 먼저 삭제한 후
		}
		new File(uploadPath+fileName.replace('/', File.separatorChar)).delete();//파일 삭제(이미지는 썸네일 파일 삭제)
		//레코드 삭제
		productService.deleteFile(fileName);
		
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
}
