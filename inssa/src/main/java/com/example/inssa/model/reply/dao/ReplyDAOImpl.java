package com.example.inssa.model.reply.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.inssa.model.reply.dto.ReplyDTO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {

	@Inject
	SqlSession sqlSession; 
	@Override
	public List<ReplyDTO> replyList(String pro_code, int board_idx) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("pro_code", pro_code);
		map.put("board_idx", board_idx);
		
		return sqlSession.selectList("reply.replyList", map);
	}

	@Override
	public void reply_insert(ReplyDTO dto) {
		// TODO Auto-generated method stub
		sqlSession.insert("reply.reply_insert", dto);
	}

	@Override
	public void reply_delete(ReplyDTO dto) {
		// TODO Auto-generated method stub
		sqlSession.update("reply.reply_delete", dto);
	}

	@Override
	public void reply_update(ReplyDTO dto) {
		// TODO Auto-generated method stub
		sqlSession.update("reply.reply_update", dto);
	}

	@Override
	public String replyName(String replyer) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("reply.replyName", replyer);
	}

	@Override
	public ReplyDTO reply_view(ReplyDTO dto) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("reply.reply_view", dto);
	}

}
