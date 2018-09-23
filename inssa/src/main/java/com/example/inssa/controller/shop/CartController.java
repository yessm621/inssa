package com.example.inssa.controller.shop;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.inssa.model.shop.dto.CartDTO;
import com.example.inssa.service.shop.CartService;
import com.example.inssa.service.shop.ProductService;
import com.google.gson.Gson;

@Controller
@RequestMapping("shop/cart/*")
public class CartController {

	@Inject
	CartService cartService;
	
	// 상품상세페이지에 선택한 제품 insert
	@RequestMapping(value="cart_insert.do", method= {RequestMethod.POST, RequestMethod.GET})
	@ResponseBody
	public String cart_insert(HttpServletRequest req, HttpSession session, Model model) {
		
		System.out.println("*****************************");
		System.out.println(req.getParameter("formData"));
		
		String userid = (String) session.getAttribute("member_id");
		if(userid != null) {	
			String data = req.getParameter("formData");
			
			data = data.replaceAll("\\[", "");
			data = data.replaceAll("\\]", "");
			
	        String[] data_split = data.split("}");
			String[] d_split;

	        for(String d : data_split) {
	        	d = d.replaceAll(",\\{", "");
	        	d = d.replaceAll("\\{", "");
	        	d = d.replaceAll("\"", "");
	        	d_split = d.split(",");
	        	
	        	cartService.cart_insert(d_split[0], d_split[1], d_split[2], userid);
	        }
	        return "null";
		}else {
			model.addAttribute("message", "nologin");
			return "redirect:/member/loginForm.do";
		}
	}
	
	// 상품 상세 페이지 팝업
	@RequestMapping("cart_popup.do")
	public String cart_popup() {
		return "shop/cart_popup";
	}
	
	// 장바구니 리스트
	@RequestMapping("cart_list.do")
	public String cart_list(HttpSession session, Model model) {
		String userid = (String) session.getAttribute("member_id");
		if(userid != null) {
			List<CartDTO> list = cartService.cart_list(userid);
			
			int money = cartService.getProductMoney(userid);
			int fee = money > 50000 ? 0 : 2500;
			
			model.addAttribute("list", list);
			model.addAttribute("count", list.size());
			model.addAttribute("money", money);
			model.addAttribute("fee", fee);
			model.addAttribute("total_money", money+fee);
			
			return "shop/cart_list";
		}else {
			return "redirect:/member/loginForm.do";
		}
	}
	
	// 장바구니 상품별 수량 및 가격 변경
	@RequestMapping(value="amount_change.do", method=RequestMethod.POST, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String amount_change(int cart_idx, int amount, CartDTO dto, HttpSession session, Model model) {
		String userid = (String) session.getAttribute("member_id");
		if(userid != null) {
			dto.setIdx(cart_idx);
			dto.setAmount(amount);
			
			cartService.cart_update(dto);
			
			int money = cartService.getProductMoney(userid);
			int fee = money > 50000 ? 0 : 2500;
			
			Map<String, Object> map = new HashMap<>();
			map.put("amount", dto.getAmount());
			map.put("money", money);
			map.put("fee", fee);
			map.put("total_money", money+fee);
			
			Gson gson = new Gson();
			return gson.toJson(map);
		}else {
			model.addAttribute("message", "nologin");
			return "member/loginForm";
		}
	}
	
	@RequestMapping("option_change.do")
	@ResponseBody
	public String option_change(String cart_idx, String option, HttpSession session) {
		Map<String, Object> map = new HashMap<>();
		map.put("cart_idx", cart_idx);
		map.put("option", option);
		cartService.option_change(map);
		
		return "null";
	}
	
	// 총 금액 및 배송료 계산
	@RequestMapping("price_change.do")
	@ResponseBody
	public String price_change(HttpSession session, Model model) {
		String userid = (String) session.getAttribute("member_id");
		if(userid != null) {
			int money = cartService.getProductMoney(userid);
			
			Gson gson = new Gson();
			return gson.toJson(money);
		}else {
			model.addAttribute("message", "nologin");
			return "member/loginForm";
		}
	}
	
	// 장바구니 비우기
	@RequestMapping("cart_all_delete.do")
	public String cart_all_delete(HttpSession session, Model model) {
		String userid = (String) session.getAttribute("member_id");
		
		if(userid != null) {
			cartService.cart_all_delete(userid);
			
			return "redirect:/shop/cart/cart_list.do";
		}else {
			model.addAttribute("message", "nologin");
			return "member/loginForm";
		}
	}
	
	// 선택한 상품 삭제
	@RequestMapping("cart_delete.do")
	@ResponseBody
	public String cart_delete(HttpSession session, int cart_idx, Model model) {
		String userid = (String)session.getAttribute("member_id");
		if(userid != null) {
			cartService.cart_delete(cart_idx, userid);
			
			return "null";
		}else {
			model.addAttribute("message", "nologin");
			return "member/loginForm";
		}
	}
	
	@RequestMapping(value="option_list.do", method=RequestMethod.POST, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String option_list(String pro_code) {
		String option = cartService.option_list(pro_code);
		String[] option_list = option.split("#");
		
		Gson json = new Gson();
		return json.toJson(option_list);
	}
	
	@RequestMapping(value="cartCnt.do", method=RequestMethod.POST)
	@ResponseBody
	public String cartCnt(String member_id) {
		int cartCnt = cartService.cartCnt(member_id);
		
		Gson json = new Gson();
		
		return json.toJson(cartCnt);
	}
}
