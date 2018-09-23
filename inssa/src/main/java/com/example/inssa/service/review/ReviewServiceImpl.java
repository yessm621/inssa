package com.example.inssa.service.review;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.example.inssa.model.review.dao.ReviewDAO;
import com.example.inssa.model.review.dto.ReviewDTO;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Inject
	ReviewDAO reviewDao;
	
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
		return reviewDao.review_list(start, end, code);
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
