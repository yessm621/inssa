package com.example.inssa.service.shop;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.example.inssa.model.shop.dao.CartDAO;
import com.example.inssa.model.shop.dao.OrderDAO;
import com.example.inssa.model.shop.dto.OrderDTO;

@Service
public class OrderServiceImpl implements OrderService {

	@Inject
	OrderDAO orderDao;
	
	@Inject
	CartDAO cartDao;
	
	@Override
	public List<OrderDTO> order_list(int order_idx, String member_id) {
		// TODO Auto-generated method stub
		return orderDao.order_list(order_idx, member_id);
	}

	@Override
	public void order_insert(Map<String, Object> map) {
		// TODO Auto-generated method stub
		orderDao.order_insert(map);
	}

	@Override
	public OrderDTO shipping_list(int default_num, String member_id) {
		// TODO Auto-generated method stub
		return orderDao.shipping_list(default_num, member_id);
	}

	@Override
	public void shipping_insert(OrderDTO shipping_dto) {
		// TODO Auto-generated method stub
		orderDao.shipping_insert(shipping_dto);
	}

	@Override
	public List<OrderDTO> alias_list(String member_id) {
		// TODO Auto-generated method stub
		return orderDao.alias_list(member_id);
	}

	@Override
	public OrderDTO product_list(String product_code) {
		// TODO Auto-generated method stub
		return orderDao.product_list(product_code);
	}

	@Override
	public int shipping_default_num(String member_id) {
		// TODO Auto-generated method stub
		return orderDao.shipping_default_num(member_id);
	}

	@Override
	public int shipping_check(String member_id) {
		// TODO Auto-generated method stub
		return orderDao.shipping_check(member_id);
	}

	@Override
	public OrderDTO memberInfo(String member_id) {
		// TODO Auto-generated method stub
		return orderDao.memberInfo(member_id);
	}

	@Override
	public OrderDTO aliasFind(Map<String, Object> map, String member_id) {
		// TODO Auto-generated method stub
		return orderDao.aliasFind(map, member_id);
	}

	@Override
	public int order_idx_max() {
		// TODO Auto-generated method stub
		return orderDao.order_idx_max();
	}

	@Override
	public Object memberPhone(String member_id) {
		// TODO Auto-generated method stub
		return orderDao.memberPhone(member_id);
	}

	@Override
	public void orderForm_insert(int order_idx, String product_code, String product_amount, String product_price,
			String product_color, String member_id) {
		// TODO Auto-generated method stub
		orderDao.orderForm_insert(order_idx, product_code, product_amount, product_price, product_color, member_id);
		
		cartDao.cart_all_delete(member_id);
	}

	@Override
	public List<OrderDTO> order_form(int order_idx, String member_id) {
		// TODO Auto-generated method stub
		return orderDao.order_form(order_idx, member_id);
	}

	@Override
	public List<OrderDTO> buy_list(String member_id) {
		// TODO Auto-generated method stub
		return orderDao.buy_list(member_id);
	}

	@Override
	public List<OrderDTO> buy_detail_list(String member_id) {
		// TODO Auto-generated method stub
		return orderDao.buy_detail_list(member_id);
	}

	@Override
	public void buyDel(int idx) {
		// TODO Auto-generated method stub
		orderDao.buyDel(idx);
	}

	@Override
	public List<OrderDTO> countIdx(String member_id) {
		// TODO Auto-generated method stub
		return orderDao.countIdx(member_id);
	}

}
