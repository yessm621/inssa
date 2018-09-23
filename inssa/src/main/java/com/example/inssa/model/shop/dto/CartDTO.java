package com.example.inssa.model.shop.dto;

public class CartDTO {
	private int idx;
	private String pcode;
	private String pname;
	private int price;
	private int sale_price;
	private String thumb_img;
	private String pro_option;
	private String category;
	private String member_id;
	private String member_name;
	private int amount;
	private int money;
	private String order_method;
	
	public String getOrder_method() {
		return order_method;
	}
	public void setOrder_method(String order_method) {
		this.order_method = order_method;
	}
	public String getPro_option() {
		return pro_option;
	}
	public void setPro_option(String pro_option) {
		this.pro_option = pro_option;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getPcode() {
		return pcode;
	}
	public void setPcode(String pcode) {
		this.pcode = pcode;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
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
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
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
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getMoney() {
		return money;
	}
	public void setMoney(int money) {
		this.money = money;
	}
	
	@Override
	public String toString() {
		return "CartDTO [idx=" + idx + ", pcode=" + pcode + ", pname=" + pname + ", price=" + price + ", sale_price="
				+ sale_price + ", thumb_img=" + thumb_img + ", pro_option=" + pro_option + ", category=" + category
				+ ", member_id=" + member_id + ", member_name=" + member_name + ", amount=" + amount + ", money="
				+ money + ", order_method=" + order_method + "]";
	}
}
