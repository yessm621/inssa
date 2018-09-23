package com.example.inssa.service.reply;

import java.util.List;

import com.example.inssa.model.reply.dto.ReplyDTO;
import com.google.gson.JsonElement;

public interface ReplyService {
	public List<ReplyDTO> replyList(String pro_code, int board_idx);
	public void reply_insert(ReplyDTO dto);
	public void reply_delete(ReplyDTO dto);
	public void reply_update(ReplyDTO dto);
	public String replyName(String replyer);
	public ReplyDTO reply_view(ReplyDTO dto);
}
