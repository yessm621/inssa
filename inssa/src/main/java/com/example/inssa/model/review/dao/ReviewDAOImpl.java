package com.example.inssa.model.review.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.inssa.model.review.dto.ReviewDTO;

@Repository
public class ReviewDAOImpl implements ReviewDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<String> getAttach(int f_idx) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteAttach(int f_idx) {
		// TODO Auto-generated method stub

	}

	@Override
	public void addAttach(ReviewDTO dto) {
		// TODO Auto-generated method stub

	}

	@Override
	public void updateAttach(ReviewDTO dto) {
		// TODO Auto-generated method stub

	}

	@Override
	public void review_insert(ReviewDTO dto) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public ReviewDTO review_detail(int r_idx) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void update(ReviewDTO dto) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(int r_idx) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public List<ReviewDTO> review_list(int start, int end, String code) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		map.put("code", code);
		
		return sqlSession.selectList("review.review_list", map);
	}

	@Override
	public void increaseViewcnt(int r_idx) {
		// TODO Auto-generated method stub

	}

	@Override
	public int reviewCount() throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

}
