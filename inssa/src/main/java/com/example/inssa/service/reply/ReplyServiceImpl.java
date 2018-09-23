package com.example.inssa.service.reply;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.example.inssa.model.reply.dao.ReplyDAO;
import com.example.inssa.model.reply.dto.ReplyDTO;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Inject
	ReplyDAO replyDao;
	
	@Override
	public List<ReplyDTO> replyList(String pro_code, int board_idx) {
		// TODO Auto-generated method stub
		return replyDao.replyList(pro_code, board_idx);
	}

	@Override
	public void reply_insert(ReplyDTO dto) {
		// TODO Auto-generated method stub
		replyDao.reply_insert(dto);
	}

	@Override
	public void reply_delete(ReplyDTO dto) {
		// TODO Auto-generated method stub
		replyDao.reply_delete(dto);
	}

	@Override
	public void reply_update(ReplyDTO dto) {
		// TODO Auto-generated method stub
		replyDao.reply_update(dto);
	}

	@Override
	public String replyName(String replyer) {
		// TODO Auto-generated method stub
		return replyDao.replyName(replyer);
	}

	@Override
	public ReplyDTO reply_view(ReplyDTO dto) {
		// TODO Auto-generated method stub
		return replyDao.reply_view(dto);
	}

}
