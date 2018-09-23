package com.example.inssa.model.shop.dto;

import java.util.Date;

public class OrderDTO {
	private int idx;
	private String member_id;
	private String member_name;
	private String member_postcode;
	private String member_addr;
	private String member_detail_addr;
	private String member_phone;
	private int order_idx;
	private String product_code;
	private String product_name;
	private String product_amount;
	private String product_color;
	private int product_price;//상품할인금액
	private int price;//상품금액
	private int sale_price;//상품할인금액
	private String thumb_img;
	private String status;
	private String payment_method;
	private String payment_name;
	private String payment_account;
	private String payment_bank;
	private String payment_phone;
	private int payment_price;//총결제금액
	private String recipient;
	private String shipping_idx;
	private String shipping_postcode;
	private String shipping_addr;
	private String shipping_detail_addr;
	private String phone;
	private Date created_time;
	private Date modified_time;
	private String alias;
	private String del;
	private int count_idx;
	
	
	public int getCount_idx() {
		return count_idx;
	}
	public void setCount_idx(int count_idx) {
		this.count_idx = count_idx;
	}
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	public int getOrder_idx() {
		return order_idx;
	}
	public void setOrder_idx(int order_idx) {
		this.order_idx = order_idx;
	}
	public String getPayment_bank() {
		return payment_bank;
	}
	public void setPayment_bank(String payment_bank) {
		this.payment_bank = payment_bank;
	}
	public String getPayment_phone() {
		return payment_phone;
	}
	public void setPayment_phone(String payment_phone) {
		this.payment_phone = payment_phone;
	}
	public int getPayment_price() {
		return payment_price;
	}
	public void setPayment_price(int payment_price) {
		this.payment_price = payment_price;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getMember_postcode() {
		return member_postcode;
	}
	public void setMember_postcode(String member_postcode) {
		this.member_postcode = member_postcode;
	}
	public String getMember_addr() {
		return member_addr;
	}
	public void setMember_addr(String member_addr) {
		this.member_addr = member_addr;
	}
	public String getMember_detail_addr() {
		return member_detail_addr;
	}
	public void setMember_detail_addr(String member_detail_addr) {
		this.member_detail_addr = member_detail_addr;
	}
	public String getMember_phone() {
		return member_phone;
	}
	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}
	public String getProduct_code() {
		return product_code;
	}
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getProduct_amount() {
		return product_amount;
	}
	public void setProduct_amount(String product_amount) {
		this.product_amount = product_amount;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getSale_price() {
		return sale_price;
	}
	public void setSale_price(int sale_price) {
		this.sale_price = sale_price;
	}
	public String getThumb_img() {
		return thumb_img;
	}
	public void setThumb_img(String thumb_img) {
		this.thumb_img = thumb_img;
	}
	public int getProduct_price() {
		return product_price;
	}
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	public String getProduct_color() {
		return product_color;
	}
	public void setProduct_color(String product_color) {
		this.product_color = product_color;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getPayment_method() {
		return payment_method;
	}
	public void setPayment_method(String payment_method) {
		this.payment_method = payment_method;
	}
	public String getPayment_name() {
		return payment_name;
	}
	public void setPayment_name(String payment_name) {
		this.payment_name = payment_name;
	}
	public String getPayment_account() {
		return payment_account;
	}
	public void setPayment_account(String payment_account) {
		this.payment_account = payment_account;
	}
	public String getRecipient() {
		return recipient;
	}
	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}
	public String getShipping_idx() {
		return shipping_idx;
	}
	public void setShipping_idx(String shipping_idx) {
		this.shipping_idx = shipping_idx;
	}
	public String getShipping_postcode() {
		return shipping_postcode;
	}
	public void setShipping_postcode(String shipping_postcode) {
		this.shipping_postcode = shipping_postcode;
	}
	public String getShipping_addr() {
		return shipping_addr;
	}
	public void setShipping_addr(String shipping_addr) {
		this.shipping_addr = shipping_addr;
	}
	public String getShipping_detail_addr() {
		return shipping_detail_addr;
	}
	public void setShipping_detail_addr(String shipping_detail_addr) {
		this.shipping_detail_addr = shipping_detail_addr;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public Date getCreated_time() {
		return created_time;
	}
	public void setCreated_time(Date created_time) {
		this.created_time = created_time;
	}
	public Date getModified_time() {
		return modified_time;
	}
	public void setModified_time(Date modified_time) {
		this.modified_time = modified_time;
	}
	public String getAlias() {
		return alias;
	}
	public void setAlias(String alias) {
		this.alias = alias;
	}
	
	@Override
	public String toString() {
		return "OrderDTO [idx=" + idx + ", member_id=" + member_id + ", member_name=" + member_name
				+ ", member_postcode=" + member_postcode + ", member_addr=" + member_addr + ", member_detail_addr="
				+ member_detail_addr + ", member_phone=" + member_phone + ", order_idx=" + order_idx + ", product_code="
				+ product_code + ", product_name=" + product_name + ", product_amount=" + product_amount
				+ ", product_color=" + product_color + ", product_price=" + product_price + ", price=" + price
				+ ", sale_price=" + sale_price + ", thumb_img=" + thumb_img + ", status=" + status + ", payment_method="
				+ payment_method + ", payment_name=" + payment_name + ", payment_account=" + payment_account
				+ ", payment_bank=" + payment_bank + ", payment_phone=" + payment_phone + ", payment_price="
				+ payment_price + ", recipient=" + recipient + ", shipping_idx=" + shipping_idx + ", shipping_postcode="
				+ shipping_postcode + ", shipping_addr=" + shipping_addr + ", shipping_detail_addr="
				+ shipping_detail_addr + ", phone=" + phone + ", created_time=" + created_time + ", modified_time="
				+ modified_time + ", alias=" + alias + ", del=" + del + ", count_idx=" + count_idx + "]";
	}
}
