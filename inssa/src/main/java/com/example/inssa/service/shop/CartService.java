package com.example.inssa.service.shop;

import java.util.List;
import java.util.Map;

import com.example.inssa.model.shop.dto.CartDTO;

public interface CartService {
	public List<CartDTO> cart_list(String userid);
	public void cart_insert(String var1, String var2, String var3, String userid);
	public void cart_delete(int idx, String userid);
	public void cart_update(CartDTO dto);
	public void cart_all_delete(String userid);
	public int getProductMoney(String userid);
	public String option_list(String pro_code);
	public void option_change(Map<String, Object> map);
	public int cartCnt(String member_id);
}
