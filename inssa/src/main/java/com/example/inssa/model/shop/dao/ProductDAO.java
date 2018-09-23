package com.example.inssa.model.shop.dao;

import java.util.List;
import java.util.Map;

import com.example.inssa.model.shop.dto.ProductDTO;

public interface ProductDAO {
	public List<ProductDTO> product_list(Map<String, Object> map);
	public void product_insert(ProductDTO dto);
	public void product_update(ProductDTO dto);
	public void product_delete(int pro_idx);
	public ProductDTO product_view(String code);
	public int listCnt(String type, String sorting, String search_product);
	public List<ProductDTO> getCategory(String type);
	public List<ProductDTO> review_list(Map<String, Object> map);
	public List<ProductDTO> file_list(Map<String, Object> map);
	public int proBuyCheck(Map<String, Object> map);
	public List<ProductDTO> review_requiredInfo(Map<String, Object> map);
	public void review_insert(ProductDTO dto);
	public void addAttach(String name, ProductDTO dto);
	public int maxReviewIdx();
	public ProductDTO review_modify_list(Map<String, Object> map);
	public List<ProductDTO> file_modify_list(Map<String, Object> map);
	public void review_modify(ProductDTO dto);
	public int checkOriginalName(String name, int idx);
	public void deleteFile(String fileName);
	public void review_delete(Map<String, Object> map);
	public void deleteAttach(Map<String, Object> map);
	public int totalPage(String pro_code);
	public List<ProductDTO> qna_list(Map<String, Object> map);
	public int qnaListCnt(String pro_code);
	public ProductDTO qna_detail(Map<String, Object> map);
	public void increaseViewcnt(int board_idx);
	public void qna_modify(ProductDTO dto);
	public void qna_insert(ProductDTO dto);
	public int maxQnaIdx();
	public void qna_delete(Map<String, Object> map);
	public String subname(String subcate);
	public String catename(String cate);
	public String category(String pro_code);
	public List<ProductDTO> related_list(String type, String pro_code);
	public String productColor(String pro_code);
	public void deleteReply(Map<String, Object> map);
	public List<ProductDTO> qnaList(String member_id);
	public void review_memberDel(String member_id);
	public void qna_memberDel(String member_id);
	public List<ProductDTO> main_best(String type);
}
