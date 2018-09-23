package com.example.inssa.service.review;

import java.util.List;

import com.example.inssa.model.review.dto.ReviewDTO;

public interface ReviewService {
	public List<String> getAttach(int f_idx);
	public void deleteAttach(int f_idx);
	public void addAttach(ReviewDTO dto);
	public void updateAttach(ReviewDTO dto);
	public void review_insert(ReviewDTO dto) throws Exception;
	public ReviewDTO review_detail(int r_idx) throws Exception;
	public void update(ReviewDTO dto) throws Exception;
	public void delete(int r_idx) throws Exception;
	public List<ReviewDTO> review_list(int start, int end, String code) throws Exception;
	public void increaseViewcnt(int r_idx);
	public int reviewCount() throws Exception;
}
