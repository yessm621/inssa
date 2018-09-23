package com.example.inssa.model.shop.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.inssa.model.shop.dto.CartDTO;

@Repository
public class CartDAOImpl implements CartDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<CartDTO> cart_list(String userid) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("cart.cart_list", userid);
	}

	@Override
	public void cart_insert(String var1, String var2, String var3, String userid) {
		// TODO Auto-generated method stub
		
		Map<String, Object> map = new HashMap<>();
		map.put("var1", var1);
		map.put("var2", var2);
		map.put("var3", var3);
		map.put("userid", userid);
		
		sqlSession.insert("cart.cart_insert", map);
	}

	@Override
	public void cart_delete(int idx, String userid) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("idx", idx);
		map.put("userid", userid);
		sqlSession.delete("cart.cart_delete", map);
	}

	@Override
	public void cart_update(CartDTO dto) {
		// TODO Auto-generated method stub
		sqlSession.update("cart.cart_update", dto);
	}

	@Override
	public void cart_all_delete(String userid) {
		// TODO Auto-generated method stub
		sqlSession.delete("cart.cart_all_delete", userid);
	}

	@Override
	public int cart_check(String var1, String var2, String var3, String userid) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("var1", var1);
		map.put("var2", var2);
		map.put("var3", var3);
		map.put("userid", userid);
		
		return sqlSession.selectOne("cart.cart_check", map);
	}

	@Override
	public void cart_add_modify(String var1, String var2, String var3, String userid) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("var1", var1);
		map.put("var2", var2);
		map.put("var3", var3);
		map.put("userid", userid);
		
		sqlSession.update("cart.cart_add_modify", map);
	}

	@Override
	public int getProductMoney(String userid) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("cart.getProductMoney", userid);
	}

	@Override
	public String option_list(String pro_code) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("cart.option_list", pro_code);
	}

	@Override
	public void option_change(Map<String, Object> map) {
		// TODO Auto-generated method stub
		sqlSession.update("cart.option_change", map);
	}

	@Override
	public int cartCnt(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("cart.cartCnt", member_id);
	}

}
