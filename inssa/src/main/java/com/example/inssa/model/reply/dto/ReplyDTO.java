package com.example.inssa.model.reply.dto;

import java.util.Date;

public class ReplyDTO {
	private int reply_idx;
	private int board_idx;
	private String product_code;
	private String replytext;
	private String replyer;
	private String name;
	private String show_type;
	private Date created_time;
	private Date modified_time;
	
	public String getShow_type() {
		return show_type;
	}
	public void setShow_type(String show_type) {
		this.show_type = show_type;
	}
	public String getProduct_code() {
		return product_code;
	}
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
	public int getReply_idx() {
		return reply_idx;
	}
	public void setReply_idx(int reply_idx) {
		this.reply_idx = reply_idx;
	}
	public int getBoard_idx() {
		return board_idx;
	}
	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}
	public String getReplytext() {
		return replytext;
	}
	public void setReplytext(String replytext) {
		this.replytext = replytext;
	}
	public String getReplyer() {
		return replyer;
	}
	public void setReplyer(String replyer) {
		this.replyer = replyer;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	
	@Override
	public String toString() {
		return "ReplyDTO [reply_idx=" + reply_idx + ", board_idx=" + board_idx + ", product_code=" + product_code
				+ ", replytext=" + replytext + ", replyer=" + replyer + ", name=" + name + ", show_type=" + show_type
				+ ", created_time=" + created_time + ", modified_time=" + modified_time + "]";
	}
}
