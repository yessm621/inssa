package com.example.inssa.controller.shop;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.inssa.model.shop.dto.ProductDTO;
import com.example.inssa.service.shop.ProductService;
import com.google.gson.Gson;
import com.google.gson.JsonArray;

@Controller
@RequestMapping("shop/product/*")
public class ProductController {

	@Inject
	ProductService productService;
	
	@RequestMapping("product.do")
	public ModelAndView product(@RequestParam(defaultValue="GS")String cate, @RequestParam(defaultValue="")String subcate,
			@RequestParam(defaultValue="all")String sorting, @RequestParam(defaultValue="")String search_product, ModelAndView mav, 
			Model model, HttpServletRequest req, @RequestParam(defaultValue="1")int currentPage) {
		List<ProductDTO> list = productService.product_list(cate, subcate, sorting, search_product, model, req);

		mav.setViewName("shop/product");
		mav.addObject("list", list);
		mav.addObject("count", list.size());
		mav.addObject("cate", cate);
		mav.addObject("sorting", sorting);
		mav.addObject("search_product", search_product);
		
		return mav;
	}
	
	@RequestMapping("product_detail.do")
	public ModelAndView product_detail(String pro_code, ModelAndView mav, Model model, HttpServletRequest req, @RequestParam(defaultValue="1")int currentPage) {
		ProductDTO list = productService.product_view(pro_code);
		
		String[] option = list.getColor().split("#");
		ArrayList<String> option2 = new ArrayList<String>(Arrays.asList(option));
		
		int price = list.getPrice();
		int sale_price = list.getSale_price();
		int sale_percent = (int) ((double) sale_price / (double)price * 100.0);
		sale_percent = 100 - sale_percent;
		
		String category = productService.category(pro_code);
		String cate = category.split("_")[0];
		String subcate = category.split("_")[1];
		
		//제품정보
		mav.setViewName("shop/product_detail");
		mav.addObject("list", productService.product_view(pro_code));
		mav.addObject("option2", option2);
		mav.addObject("option_size", option.length);
		mav.addObject("sale_percent", sale_percent);
		
		//상단진행네비
		mav.addObject("cate", cate);
		mav.addObject("catename", productService.catename(cate));
		mav.addObject("subcate", subcate);
		mav.addObject("subname", productService.subname(subcate));
		mav.addObject("pro_code", pro_code);
		
		//관련제품(같은카테고리의 인기상품)
		String type = cate + "_" + subcate;
		mav.addObject("related_list", productService.related_list(type, pro_code));
		
		//상품후기
		List<ProductDTO> review_list = productService.review_list(pro_code, model, req);
		mav.addObject("review_list", review_list);
		mav.addObject("review_count", review_list.size());
		
		//상품문의
		List<ProductDTO> qna_list = productService.qna_list(pro_code, model, req);
		mav.addObject("qna_list", qna_list);
		mav.addObject("qna_count", qna_list.size());
		
		return mav;
	}
	
	@RequestMapping(value="productColor.do", method=RequestMethod.POST, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String productColor(String pro_code) {
		String pro_option = productService.productColor(pro_code);
		pro_option = pro_option.split("#")[0];
		Gson gson = new Gson();
		
		return gson.toJson(pro_option);
	}
	
	@RequestMapping("file_list.do")
	@ResponseBody
	public String file_list(String pro_code, int pro_idx) {
		Map<String, Object> map = new HashMap<>();
		map.put("board_type", "R");
		map.put("pro_code", pro_code);
		map.put("board_idx", pro_idx);
		
		List<ProductDTO> list = productService.file_list(map);
		Gson gson = new Gson();
		
		return gson.toJson(list);
	}
	
	@RequestMapping("pro_review_write.do")
	public ModelAndView pro_review_write(String pro_code, HttpSession session, ModelAndView mav, RedirectAttributes redirectAttr) {
		String member_id = (String)session.getAttribute("member_id");
		if(member_id != null) {
			Map<String, Object> map = new HashMap<>();
			map.put("pro_code", pro_code);
			map.put("member_id", member_id);
			int proBuyCheck = productService.proBuyCheck(map);
			if(proBuyCheck == 0) {
				mav.setViewName("redirect:/shop/product/product_detail.do");
				mav.addObject("pro_code", pro_code);
				redirectAttr.addFlashAttribute("message", "useAfterBuy");
			}else {
				mav.setViewName("shop/product_review_write");
				mav.addObject("pro_code", pro_code);
				mav.addObject("review_requiredInfo", productService.review_requiredInfo(map));
			}
			return mav;
		}else {
			return new ModelAndView("redirect:/member/loginForm.do", "", null);
		}
	}
	
	@RequestMapping("review_insert.do")
	public ModelAndView review_insert(ProductDTO dto, HttpSession session, ModelAndView mav) {
		String member_id = (String)session.getAttribute("member_id");
		dto.setMember_id(member_id);
		productService.review_insert(dto);
		mav.setViewName("redirect:/shop/product/product_detail.do");
		mav.addObject("pro_code", dto.getCode());
		
		return mav;
	}
	
	@RequestMapping("review_modify_list.do")
	public ModelAndView review_modify_list(String board_idx, String pro_code, ModelAndView mav) {
		mav.setViewName("shop/product_review_modify");
		Map<String, Object> map = new HashMap<>();
		map.put("board_idx", board_idx);
		map.put("pro_code", pro_code);
		mav.addObject("review_list", productService.review_modify_list(map));
		map.put("board_type", "R");
		mav.addObject("file_list", productService.file_modify_list(map));
		
		return mav;
	}
	
	@RequestMapping("getAttach.do")
	@ResponseBody
	public String getAttach(String pro_code, String board_idx, String board_type) {
		Map<String, Object> map = new HashMap<>();
		map.put("board_idx", board_idx);
		map.put("pro_code", pro_code);
		map.put("board_type", board_type);
		Gson gson = new Gson();
		
		return gson.toJson(productService.file_modify_list(map));
	}
	
	//상품 리뷰 및 파일 수정
	@RequestMapping("review_modify.do")
	public ModelAndView review_modify(ProductDTO dto, HttpSession session, ModelAndView mav) {
		String member_id = (String)session.getAttribute("member_id");
		String member_name = (String)session.getAttribute("member_name");
		dto.setMember_id(member_id);
		dto.setMember_name(member_name);
		
		productService.review_modify(dto);

		mav.setViewName("redirect:/shop/product/product_detail.do");
		mav.addObject("pro_code", dto.getCode());
		
		return mav;
	}
	
	@RequestMapping("review_delete.do")
	public ModelAndView review_delete(String board_idx, String pro_code, String board_type, ModelAndView mav) {
		productService.review_delete(board_idx, pro_code, board_type);
		
		mav.setViewName("redirect:/shop/product/product_detail.do");
		mav.addObject("pro_code", pro_code);
		
		return mav;
	}
	
	//문의 디테일
	@RequestMapping("qna_detail.do")
	public ModelAndView qna_detail(String pro_code, int board_idx, ModelAndView mav, HttpSession session) {
		Map<String, Object> map = new HashMap<>();
		map.put("pro_code", pro_code);
		map.put("board_idx", board_idx);
		
		productService.increaseViewcnt(board_idx, session);
		
		mav.setViewName("shop/qna_detail");
		mav.addObject("qna_detail_list", productService.qna_detail(map));
		map.put("board_type", "Q");
		mav.addObject("file_list", productService.file_list(map));
		
		return mav;
	}
	
	@RequestMapping("qna_modify.do")
	public ModelAndView qna_modify(ProductDTO dto, String pro_code, ModelAndView mav) {
		dto.setCode(pro_code);
		dto.setIdx(dto.getBoard_idx());
		productService.qna_modify(dto);
		
		mav.setViewName("redirect:/shop/product/product_detail.do");
		mav.addObject("pro_code", dto.getCode());
		
		return mav;
	}
	
	@RequestMapping("pro_qna_write.do")
	public ModelAndView pro_qna_write(String pro_code, HttpSession session, ModelAndView mav, RedirectAttributes redirectAttr) {
		String member_id = (String)session.getAttribute("member_id");
		if(member_id != null) {			
			mav.setViewName("shop/product_qna_write");
			mav.addObject("pro_code", pro_code);
			
			return mav;
		}else {
			return new ModelAndView("redirect:/member/loginForm.do", "", null);
		}
	}
	
	@RequestMapping("qna_insert.do")
	public ModelAndView qna_insert(ProductDTO dto, HttpSession session, ModelAndView mav) {
		String member_id = (String)session.getAttribute("member_id");
		dto.setMember_id(member_id);
		productService.qna_insert(dto);
		mav.setViewName("redirect:/shop/product/product_detail.do");
		mav.addObject("pro_code", dto.getCode());
		
		return mav;
	}
	
	@RequestMapping("qna_delete.do")
	public ModelAndView qna_delete(String board_idx, String pro_code, String board_type, ModelAndView mav) {
		
		productService.qna_delete(board_idx, pro_code, board_type);
		
		mav.setViewName("redirect:/shop/product/product_detail.do");
		mav.addObject("pro_code", pro_code);
		
		return mav;
	}
	
	@RequestMapping("reviewQna")
	public ModelAndView reviewQna(ModelAndView mav, HttpSession session) {
		String member_id = (String)session.getAttribute("member_id");
		mav.setViewName("shop/reviewQna");
		List<ProductDTO> qnaList = productService.qnaList(member_id);
		mav.addObject("qnaList", qnaList);
		mav.addObject("qnaList_count", qnaList.size());
		
		return mav;
	}
}
