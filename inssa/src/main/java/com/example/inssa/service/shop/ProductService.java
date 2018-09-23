package com.example.inssa.service.shop;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;

import com.example.inssa.model.shop.dto.ProductDTO;

public interface ProductService {
	public List<ProductDTO> product_list(String cate, String subcate, String sorting, String search_product, Model model, HttpServletRequest req);
	public void product_insert(ProductDTO dto);
	public void product_update(ProductDTO dto);
	public void product_delete(int pro_idx);
	public ProductDTO product_view(String pro_code);
	public List<ProductDTO> review_list(String pro_code, Model model, HttpServletRequest req);
	public List<ProductDTO> file_list(Map<String, Object> map);
	public int proBuyCheck(Map<String, Object> map);
	public List<ProductDTO> review_requiredInfo(Map<String, Object> map);
	public void review_insert(ProductDTO dto);
	public ProductDTO review_modify_list(Map<String, Object> map);
	public List<ProductDTO> file_modify_list(Map<String, Object> map);
	public void review_modify(ProductDTO dto);
	public void deleteFile(String fileName);
	public void review_delete(String board_idx, String pro_code, String board_type);
	public List<ProductDTO> qna_list(String pro_code, Model model, HttpServletRequest req);
	public ProductDTO qna_detail(Map<String, Object> map);
	public void increaseViewcnt(int board_idx, HttpSession session);
	public void qna_modify(ProductDTO dto);
	public void qna_insert(ProductDTO dto);
	public void qna_delete(String board_idx, String pro_code, String board_type);
	public String subname(String subcate);
	public String catename(String cate);
	public String category(String pro_code);
	public List<ProductDTO> related_list(String type, String pro_code);
	public String productColor(String pro_code);
	public List<ProductDTO> qnaList(String member_id);
	public List<ProductDTO> main_best(String type);
}
