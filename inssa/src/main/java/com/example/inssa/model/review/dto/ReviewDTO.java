package com.example.inssa.model.review.dto;

import java.util.Arrays;
import java.util.Date;

public class ReviewDTO {
	private int r_idx;
	private String member_id;
	private String title;
	private String content;
	private String product_code;
	private int view_cnt;
	private Date r_created_time;
	private Date r_modified_time;
	private String board_show;
	private int f_idx;
	private String original_name;
	private String modified_name;
	private String board_type;
	private int board_idx;
	private Date f_created_time;
	private Date f_modified_time;
	private String[] files;
	
	public String getBoard_show() {
		return board_show;
	}
	public void setBoard_show(String board_show) {
		this.board_show = board_show;
	}
	public String[] getFiles() {
		return files;
	}
	public void setFiles(String[] files) {
		this.files = files;
	}
	public int getR_idx() {
		return r_idx;
	}
	public void setR_idx(int r_idx) {
		this.r_idx = r_idx;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
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
	public String getProduct_code() {
		return product_code;
	}
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
	public int getView_cnt() {
		return view_cnt;
	}
	public void setView_cnt(int view_cnt) {
		this.view_cnt = view_cnt;
	}
	public Date getR_created_time() {
		return r_created_time;
	}
	public void setR_created_time(Date r_created_time) {
		this.r_created_time = r_created_time;
	}
	public Date getR_modified_time() {
		return r_modified_time;
	}
	public void setR_modified_time(Date r_modified_time) {
		this.r_modified_time = r_modified_time;
	}
	public int getF_idx() {
		return f_idx;
	}
	public void setF_idx(int f_idx) {
		this.f_idx = f_idx;
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
	public int getBoard_idx() {
		return board_idx;
	}
	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}
	public Date getF_created_time() {
		return f_created_time;
	}
	public void setF_created_time(Date f_created_time) {
		this.f_created_time = f_created_time;
	}
	public Date getF_modified_time() {
		return f_modified_time;
	}
	public void setF_modified_time(Date f_modified_time) {
		this.f_modified_time = f_modified_time;
	}
	
	@Override
	public String toString() {
		return "ReviewDTO [r_idx=" + r_idx + ", member_id=" + member_id + ", title=" + title + ", content=" + content
				+ ", product_code=" + product_code + ", view_cnt=" + view_cnt + ", r_created_time=" + r_created_time
				+ ", r_modified_time=" + r_modified_time + ", board_show=" + board_show + ", f_idx=" + f_idx
				+ ", original_name=" + original_name + ", modified_name=" + modified_name + ", board_type=" + board_type
				+ ", board_idx=" + board_idx + ", f_created_time=" + f_created_time + ", f_modified_time="
				+ f_modified_time + ", files=" + Arrays.toString(files) + "]";
	}
}
