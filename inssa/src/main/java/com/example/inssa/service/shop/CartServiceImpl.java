package com.example.inssa.service.shop;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.example.inssa.model.shop.dao.CartDAO;
import com.example.inssa.model.shop.dto.CartDTO;

@Service
public class CartServiceImpl implements CartService {

	@Inject
	CartDAO cartDao;
	
	@Override
	public List<CartDTO> cart_list(String userid) {
		// TODO Auto-generated method stub
		return cartDao.cart_list(userid);
	}

	@Override
	public void cart_insert(String var1, String var2, String var3, String userid) {
		// TODO Auto-generated method stub
		var1 = var1.split(":")[1];
		var2 = var2.split(":")[1];
		var3 = var3.split(":")[1];
		
		int check = cartDao.cart_check(var1, var2, var3, userid);
		System.out.println("check:"+check);
		if(check > 0) {
			cartDao.cart_add_modify(var1, var2, var3, userid);
		}else {
			cartDao.cart_insert(var1, var2, var3, userid);
		}
		
		
	}

	@Override
	public void cart_delete(int idx, String userid) {
		// TODO Auto-generated method stub
		cartDao.cart_delete(idx, userid);
	}

	@Override
	public void cart_update(CartDTO dto) {
		// TODO Auto-generated method stub
		cartDao.cart_update(dto);
	}

	@Override
	public void cart_all_delete(String userid) {
		// TODO Auto-generated method stub
		cartDao.cart_all_delete(userid);
	}

	@Override
	public int getProductMoney(String userid) {
		// TODO Auto-generated method stub
		return cartDao.getProductMoney(userid);
	}

	@Override
	public String option_list(String pro_code) {
		// TODO Auto-generated method stub
		return cartDao.option_list(pro_code);
	}

	@Override
	public void option_change(Map<String, Object> map) {
		// TODO Auto-generated method stub
		cartDao.option_change(map);
	}

	@Override
	public int cartCnt(String member_id) {
		// TODO Auto-generated method stub
		return cartDao.cartCnt(member_id);
	}

}
