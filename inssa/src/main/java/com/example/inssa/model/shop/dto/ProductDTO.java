package com.example.inssa.model.shop.dto;

import java.util.Date;

public class ProductDTO {
	private int idx;
	private String code;
	private String name;
	private int price;
	private int sale_price;
	private String color;
	private int cnt;
	private String thumb_img;
	private String detail_img;
	private String category;
	private int buy_cnt;
	private Date created_time;
	private Date modified_time;
	private int c_idx;
	private String high_name;
	private String high_code;
	private String middle_name;
	private String middle_code;
	private String c_category;
	//상품 리뷰 및 문의 관련 변수
	private int board_idx;
	private String member_id;
	private String member_name;
	private String product_color;
	private String title;
	private String content;
	private int view_cnt;
	private String board_show;
	private Date board_created_time;
	private Date board_modified_time;
	private int file_idx;
	private String original_name;
	private String modified_name;
	private String board_type;
	private String file_board_idx;
	private String[] files;
	private int[] files_idx;
	
	public int[] getFiles_idx() {
		return files_idx;
	}
	public void setFiles_idx(int[] files_idx) {
		this.files_idx = files_idx;
	}
	public String[] getFiles() {
		return files;
	}
	public void setFiles(String[] files) {
		this.files = files;
	}
	public String getProduct_color() {
		return product_color;
	}
	public void setProduct_color(String product_color) {
		this.product_color = product_color;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getThumb_img() {
		return thumb_img;
	}
	public void setThumb_img(String thumb_img) {
		this.thumb_img = thumb_img;
	}
	public String getDetail_img() {
		return detail_img;
	}
	public void setDetail_img(String detail_img) {
		this.detail_img = detail_img;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getBuy_cnt() {
		return buy_cnt;
	}
	public void setBuy_cnt(int buy_cnt) {
		this.buy_cnt = buy_cnt;
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
	public int getC_idx() {
		return c_idx;
	}
	public void setC_idx(int c_idx) {
		this.c_idx = c_idx;
	}
	public String getHigh_name() {
		return high_name;
	}
	public void setHigh_name(String high_name) {
		this.high_name = high_name;
	}
	public String getHigh_code() {
		return high_code;
	}
	public void setHigh_code(String high_code) {
		this.high_code = high_code;
	}
	public String getMiddle_name() {
		return middle_name;
	}
	public void setMiddle_name(String middle_name) {
		this.middle_name = middle_name;
	}
	public String getMiddle_code() {
		return middle_code;
	}
	public void setMiddle_code(String middle_code) {
		this.middle_code = middle_code;
	}
	public String getC_category() {
		return c_category;
	}
	public void setC_category(String c_category) {
		this.c_category = c_category;
	}
	public int getBoard_idx() {
		return board_idx;
	}
	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getView_cnt() {
		return view_cnt;
	}
	public void setView_cnt(int view_cnt) {
		this.view_cnt = view_cnt;
	}
	public String getBoard_show() {
		return board_show;
	}
	public void setBoard_show(String board_show) {
		this.board_show = board_show;
	}
	public Date getBoard_created_time() {
		return board_created_time;
	}
	public void setBoard_created_time(Date board_created_time) {
		this.board_created_time = board_created_time;
	}
	public Date getBoard_modified_time() {
		return board_modified_time;
	}
	public void setBoard_modified_time(Date board_modified_time) {
		this.board_modified_time = board_modified_time;
	}
	public int getFile_idx() {
		return file_idx;
	}
	public void setFile_idx(int file_idx) {
		this.file_idx = file_idx;
	}
	public String getOriginal_name() {
		return original_name;
	}
	public void setOriginal_name(String original_name) {
		this.original_name = original_name;
	}
	public String getModified_name() {
		return modified_name;
	}
	public void setModified_name(String modified_name) {
		this.modified_name = modified_name;
	}
	public String getBoard_type() {
		return board_type;
	}
	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}
	public String getFile_board_idx() {
		return file_board_idx;
	}
	public void setFile_board_idx(String file_board_idx) {
		this.file_board_idx = file_board_idx;
	}
	
	@Override
	public String toString() {
		return "ProductDTO [idx=" + idx + ", code=" + code + ", name=" + name + ", price=" + price + ", sale_price="
				+ sale_price + ", color=" + color + ", cnt=" + cnt + ", thumb_img=" + thumb_img + ", detail_img="
				+ detail_img + ", category=" + category + ", buy_cnt=" + buy_cnt + ", created_time=" + created_time
				+ ", modified_time=" + modified_time + ", c_idx=" + c_idx + ", high_name=" + high_name + ", high_code="
				+ high_code + ", middle_name=" + middle_name + ", middle_code=" + middle_code + ", c_category="
				+ c_category + ", board_idx=" + board_idx + ", member_id=" + member_id + ", member_name=" + member_name
				+ ", title=" + title + ", content=" + content + ", view_cnt=" + view_cnt + ", board_show=" + board_show
				+ ", board_created_time=" + board_created_time + ", board_modified_time=" + board_modified_time
				+ ", file_idx=" + file_idx + ", original_name=" + original_name + ", modified_name=" + modified_name
				+ ", board_type=" + board_type + ", file_board_idx=" + file_board_idx + "]";
	}
}
