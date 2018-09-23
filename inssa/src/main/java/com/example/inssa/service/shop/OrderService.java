package com.example.inssa.service.shop;

import java.util.List;
import java.util.Map;

import com.example.inssa.model.shop.dto.OrderDTO;

public interface OrderService {
	public List<OrderDTO> order_list(int order_idx, String member_id);
	public void order_insert(Map<String, Object> map);
	public OrderDTO shipping_list(int default_num, String member_id);
	public void shipping_insert(OrderDTO shipping_dto);
	public List<OrderDTO> alias_list(String member_id);
	public OrderDTO product_list(String product_code);
	public int shipping_default_num(String member_id);
	public int shipping_check(String member_id);
	public OrderDTO memberInfo(String member_id);
	public OrderDTO aliasFind(Map<String, Object> map, String member_id);
	public int order_idx_max();
	public Object memberPhone(String member_id);
	public void orderForm_insert(int order_idx, String product_code, String product_amount, String product_price, String product_color,	String member_id);
	public List<OrderDTO> order_form(int order_idx, String member_id);
	public List<OrderDTO> buy_list(String member_id);
	public List<OrderDTO> buy_detail_list(String member_id);
	public void buyDel(int idx);
	public List<OrderDTO> countIdx(String member_id);
}
