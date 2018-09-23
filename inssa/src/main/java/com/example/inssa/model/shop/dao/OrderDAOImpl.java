package com.example.inssa.model.shop.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.inssa.model.shop.dto.OrderDTO;

@Repository
public class OrderDAOImpl implements OrderDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<OrderDTO> order_list(int order_idx, String member_id) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("order_idx", order_idx);
		map.put("member_id", member_id);
		return sqlSession.selectList("order.order_list", map);
	}

	@Override
	public void order_insert(Map<String, Object> map) {
		// TODO Auto-generated method stub
		sqlSession.insert("order.order_insert", map);
	}

	@Override
	public OrderDTO shipping_list(int default_num, String member_id) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("default_num", default_num);
		map.put("member_id", member_id);
		return sqlSession.selectOne("order.shipping_list", map);
	}

	@Override
	public void shipping_insert(OrderDTO shipping_dto) {
		// TODO Auto-generated method stub
		sqlSession.insert("order.shipping_insert", shipping_dto);
	}

	@Override
	public List<OrderDTO> alias_list(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("order.alias_list", member_id);
	}

	@Override
	public OrderDTO product_list(String product_code) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("order.product_list", product_code);
	}

	@Override
	public int shipping_default_num(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("order.shipping_default_num", member_id);
	}

	@Override
	public int shipping_check(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("order.shipping_check", member_id);
	}

	@Override
	public OrderDTO memberInfo(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("order.memberInfo", member_id);
	}

	@Override
	public OrderDTO aliasFind(Map<String, Object> map, String member_id) {
		// TODO Auto-generated method stub
		map.put("member_id", member_id);
		return sqlSession.selectOne("order.aliasFind", map);
	}

	@Override
	public int order_idx_max() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("order.order_idx_max");
	}

	@Override
	public Object memberPhone(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("order.memberPhone", member_id);
	}

	@Override
	public void orderForm_insert(int order_idx, String product_code, String product_amount, String product_price,
			String product_color, String member_id) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("order_idx", order_idx);
		map.put("product_code", product_code);
		map.put("product_amount", product_amount);
		map.put("product_price", product_price);
		map.put("product_color", product_color);
		map.put("member_id", member_id);
		
		sqlSession.insert("order.orderForm_insert", map);
	}

	@Override
	public List<OrderDTO> order_form(int order_idx, String member_id) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("order_idx", order_idx);
		map.put("member_id", member_id);
		
		return sqlSession.selectList("order.order_form", map);
	}

	@Override
	public List<OrderDTO> buy_list(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("order.buy_list", member_id);
	}

	@Override
	public List<OrderDTO> buy_detail_list(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("order.buy_detail_list", member_id);
	}

	@Override
	public void buyDel(int idx) {
		// TODO Auto-generated method stub
		sqlSession.update("order.buyDel", idx);
	}

	@Override
	public List<OrderDTO> countIdx(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("order.countIdx", member_id);
	}

}
