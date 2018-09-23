package com.example.inssa.controller.shop;

import java.util.ArrayList;
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

import com.example.inssa.model.shop.dto.OrderDTO;
import com.example.inssa.service.shop.OrderService;
import com.google.gson.Gson;

@Controller
@RequestMapping("shop/order/*")
public class OrderController {

	@Inject
	OrderService orderService;
	
	@RequestMapping("order_list.do")
	public String order_list(String[] arr, HttpSession session, Model model) {
		String member_id = (String)session.getAttribute("member_id");
		if(member_id != null) {
			String[] type1 = new String[arr.length];
			String[] type2 = new String[arr.length];
			String[] type3 = new String[arr.length];
			int count1 = 0;
			int count2 = 0;
			int count3 = 0;
			for(int i=0; i<arr.length; i++) {
				arr[i] = arr[i].replaceAll("\\[", "");
				arr[i] = arr[i].replaceAll("\\]", "");
				arr[i] = arr[i].replaceAll("\\{", "");
				arr[i] = arr[i].replaceAll("\\}", "");
				arr[i] = arr[i].replaceAll("\"", "");
				if(arr[i].indexOf("code") >= 0) {
					type1[count1] = arr[i].split(":")[1];
					count1++;
				}else if(arr[i].indexOf("color") >= 0) {
					type2[count2] = arr[i].split(":")[1];
					count2++;
				}else if(arr[i].indexOf("cnt") >= 0) {
					type3[count3] = arr[i].split(":")[1];
					count3++;
				}
			}
			
			OrderDTO dto = null;
			List<OrderDTO> list = new ArrayList<>();
			int money = 0;
			for(int i=0; i<count1; i++) {
				dto = orderService.product_list(type1[i]);
				dto.setProduct_color(type2[i]);
				dto.setProduct_amount(type3[i]);
				list.add(dto);
				
				money += Integer.parseInt(type3[i]) * dto.getSale_price();
			}
			int fee = money >= 50000 ? 0 : 2500;
			int total_money = money + fee;
			
			//아이디 당 배송지정보가 하나라도 있는지 확인
			int check = orderService.shipping_check(member_id);
			OrderDTO default_shipping = null;
			if(check > 0) {
				int default_num = orderService.shipping_default_num(member_id);//기본배송지 IDX
				default_shipping = orderService.shipping_list(default_num, member_id);
			}else {
				default_shipping = orderService.memberInfo(member_id);
				//alias 지정
				String addr = default_shipping.getShipping_addr();
				int addr_index = addr.indexOf("구 ");
				addr = addr.substring(0, addr_index+1);
				String alias = default_shipping.getRecipient()+"("+addr+")";
				default_shipping.setAlias(alias);
				
				orderService.shipping_insert(default_shipping);
			}
			
			List<OrderDTO> alias_list = orderService.alias_list(member_id);
			
			model.addAttribute("list", list);
			model.addAttribute("list_count", list.size());
			model.addAttribute("money", money);
			model.addAttribute("fee", fee);
			model.addAttribute("total_money", total_money);
			model.addAttribute("default_shipping", default_shipping);
			model.addAttribute("alias_list", alias_list);
			
			return "order/orderForm";
		}else {
			return "redirect:/member/loginForm.do";
		}		
		
	}
	
	@RequestMapping(value="aliasFind.do", method=RequestMethod.POST, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String aliasFind(int shipping_idx, String alias, HttpSession session) {
		String member_id = (String)session.getAttribute("member_id");
		Map<String, Object> map = new HashMap<>();
		map.put("shipping_idx", shipping_idx);
		map.put("alias", alias);
		
		OrderDTO dto = orderService.aliasFind(map, member_id);
		
		Gson gson = new Gson();
		return gson.toJson(dto);
	}
	
	@RequestMapping(value="shipping_insert.do", method=RequestMethod.POST, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public void shipping_insert(String recipient, String phone1, String phone2, String phone3, 
			String shipping_postcode, String shipping_addr, String shipping_detail_addr, HttpSession session) {
		String member_id = (String)session.getAttribute("member_id");
		int addr_index = shipping_addr.indexOf("구 ");
		String addr_temp = shipping_addr.substring(0, addr_index+1);
		String alias = recipient + "(" + addr_temp + ")";
		String phone = phone1 + phone2 + phone3;
		
		OrderDTO shipping_dto = new OrderDTO();
		shipping_dto.setMember_id(member_id);
		shipping_dto.setAlias(alias);
		shipping_dto.setRecipient(recipient);
		shipping_dto.setPhone(phone);
		shipping_dto.setShipping_postcode(shipping_postcode);
		shipping_dto.setShipping_addr(shipping_addr);
		shipping_dto.setShipping_detail_addr(shipping_detail_addr);
		
		orderService.shipping_insert(shipping_dto);
	}
	
	@RequestMapping("order_insert.do")
	@ResponseBody
	public String order_insert(String alias_check, String payment_method, String payment_name, String payment_bank, String payment_price,
			String product_code, String product_amount, String product_color, String product_price, String recipient, 
			String shipping_postcode, String shipping_addr, String shipping_detail_addr, HttpSession session) {
		String member_id = (String)session.getAttribute("member_id");
		payment_price = payment_price.replaceAll(",", "");
		payment_price = payment_price.replaceAll("원", "");
		
		Map<String, Object> map = new HashMap<>();
		map.put("member_id", member_id);
		map.put("payment_method", payment_method);
		map.put("payment_price", Integer.parseInt(payment_price));
		map.put("recipient", recipient);
		map.put("shipping_postcode", shipping_postcode);
		map.put("shipping_addr", shipping_addr);
		map.put("shipping_detail_addr", shipping_detail_addr);
		if(payment_method.equals("ACCOUNT")) {
			map.put("payment_name", payment_name);
			map.put("payment_bank", payment_bank);
			map.put("payment_phone", "");
			map.put("status", "입금대기");
		}else if(payment_method.equals("PHONE")){
			map.put("payment_name", "");
			map.put("payment_bank", "");
			map.put("payment_phone", orderService.memberPhone(member_id));
			map.put("status", "입금완료");
		}
		
		orderService.order_insert(map);
		
		int order_idx = orderService.order_idx_max();

		product_code = product_code.substring(1, product_code.length());
		product_amount = product_amount.substring(1, product_amount.length());
		product_color = product_color.replaceAll("옵션 [|] ", "");
		product_color = product_color.substring(1, product_color.length());
		product_price = product_price.substring(1, product_price.length());
		
		String[] pro_code_list = product_code.split("_");
		String[] pro_amount_list = product_amount.split("_");
		String[] pro_color_list = product_color.split("_");
		String[] pro_price_list = product_price.split("_");
		
		for(int i=0; i<pro_code_list.length; i++) {
			orderService.orderForm_insert(order_idx, pro_code_list[i], pro_amount_list[i], pro_price_list[i], pro_color_list[i], member_id);
		}
		
		Gson gson = new Gson();
		
		return gson.toJson(order_idx);
	}
	
	@RequestMapping("orderComplete.do")
	public ModelAndView orderComplete(int order_idx, ModelAndView mav, HttpSession session) {
		String member_id = (String)session.getAttribute("member_id");
		List<OrderDTO> order_list = orderService.order_list(order_idx, member_id);
		List<OrderDTO> order_form = orderService.order_form(order_idx, member_id);
		mav.setViewName("order/orderComplete");
		mav.addObject("order_list", order_list);
		mav.addObject("order_form", order_form);
		mav.addObject("order_idx", order_idx);
		mav.addObject("count", order_form.size());
		
		return mav;
	}
	
	@RequestMapping("buyList")
	public ModelAndView buyList(ModelAndView mav, HttpSession session) {
		String member_id = (String)session.getAttribute("member_id");
		if(member_id != null) {
			mav.setViewName("order/buyList");
			mav.addObject("buy_list", orderService.buy_list(member_id));
			mav.addObject("buy_detail_list", orderService.buy_detail_list(member_id));
			mav.addObject("countIdx", orderService.countIdx(member_id));
		}else {
			mav.setViewName("redirect:/member/loginForm.do");
		}
		
		return mav;
	}
	
	@RequestMapping("buyDel.do")
	public String buyDel(int idx) {	
		orderService.buyDel(idx);
		
		return "redirect:/shop/order/buyList";
	}
}
