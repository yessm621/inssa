package com.example.inssa.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;

public class UploadFileUtils {
	private static final Logger logger = LoggerFactory.getLogger(UploadFileUtils.class);
	
	public static String uploadFile(String uploadPath, String originalName, byte[] fileData) throws Exception {
		//uuid 발급
		UUID uid = UUID.randomUUID();
		String savedName = uid.toString()+"_"+originalName;
		
		//업로드할 디렉토리 생성
		makeDir(uploadPath);
		File target = new File(uploadPath, savedName);
		//임시 디렉토리에 업로드된 파일을 지정된 디렉토리에 복사
		FileCopyUtils.copy(fileData, target);
		//파일의 확장자 검사
		//a.jpg / aaa.bbb.ccc.jpg
		String formatName = originalName.substring(originalName.lastIndexOf(".")+1);
		//System.out.println("originalName:"+originalName);
		//System.out.println("formatName:"+formatName);
		String uploadedFileName = null;
		//이미지 파일은 썸네일 사용
		//System.out.println(MediaUtils.getMediaType(formatName));
		if(MediaUtils.getMediaType(formatName) != null) {
			//썸네일 생성
			uploadedFileName = makeThumbnail(uploadPath, savedName);
		}else {
			//아이콘 생성
			uploadedFileName = null;
		}
		//System.out.println("uploadedFileName:"+uploadedFileName);
		return uploadedFileName;
	}
	
	private static String makeThumbnail(String uploadPath, String fileName) throws Exception {
		//이미지를 읽기위한 버퍼, 원본 이미지
		BufferedImage sourceImg = ImageIO.read(new File(uploadPath, fileName));
		//100픽셀 단위의 썸네일 생성
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 100);
		//썸네일의 이름
		String thumbnailName = uploadPath+File.separator+"s_"+fileName;
		File newFile = new File(thumbnailName);
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		//썸네일 생성
		ImageIO.write(destImg, formatName.toUpperCase(), newFile);
		//썸네일의 이름을 리턴함
		return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar, '/');
	}
	
	private static void makeDir(String uploadPath) {
		File dirPath = new File(uploadPath);
		if(!dirPath.exists()) {
			dirPath.mkdir(); //디렉토리 생성
		}
	}
}