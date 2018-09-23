package com.example.inssa.model.shop.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.inssa.model.shop.dto.ProductDTO;

@Repository
public class ProductDAOImpl implements ProductDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public List<ProductDTO> product_list(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("product.product_list", map);
	}

	@Override
	public void product_insert(ProductDTO dto) {
		// TODO Auto-generated method stub

	}

	@Override
	public void product_update(ProductDTO dto) {
		// TODO Auto-generated method stub

	}

	@Override
	public void product_delete(int pro_idx) {
		// TODO Auto-generated method stub

	}

	@Override
	public ProductDTO product_view(String code) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("product.product_view", code);
	}

	@Override
	public int listCnt(String type, String sorting, String search_product) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("type", type);
		map.put("sorting", sorting);
		map.put("search_product", search_product);
		return sqlSession.selectOne("product.listCnt", map);
	}

	@Override
	public List<ProductDTO> getCategory(String type) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("product.getCategory", type);
	}

	@Override
	public List<ProductDTO> review_list(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("product.review_list", map);
	}

	@Override
	public List<ProductDTO> file_list(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("product.file_list", map);
	}

	@Override
	public int proBuyCheck(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("product.proBuyCheck", map);
	}

	@Override
	public List<ProductDTO> review_requiredInfo(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("product.review_requiredInfo", map);
	}

	@Override
	public void review_insert(ProductDTO dto) {
		// TODO Auto-generated method stub
		sqlSession.insert("product.review_insert", dto);
	}

	@Override
	public void addAttach(String name, ProductDTO dto) {
		// TODO Auto-generated method stub
		dto.setOriginal_name(name);
		dto.setModified_name(name);
		sqlSession.insert("product.addAttach", dto);
	}

	@Override
	public int maxReviewIdx() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("product.maxReviewIdx");
	}

	@Override
	public ProductDTO review_modify_list(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("product.review_modify_list", map);
	}

	@Override
	public List<ProductDTO> file_modify_list(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("product.file_modify_list", map);
	}

	@Override
	public void review_modify(ProductDTO dto) {
		// TODO Auto-generated method stub
		sqlSession.update("product.review_modify", dto);
	}

	@Override
	public int checkOriginalName(String name, int idx) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("name", name);
		map.put("idx", idx);
		return sqlSession.selectOne("product.checkOriginalName", map);
	}

	@Override
	public void deleteFile(String fileName) {
		// TODO Auto-generated method stub
		sqlSession.delete("product.deleteFile", fileName);
	}

	@Override
	public void review_delete(Map<String, Object> map) {
		// TODO Auto-generated method stub
		//sqlSession.delete("product.review_delete", map);
		sqlSession.update("product.review_delete", map);
	}

	@Override
	public void deleteAttach(Map<String, Object> map) {
		// TODO Auto-generated method stub
		System.out.println("deleteAttach************************");
		System.out.println(map);
		sqlSession.delete("product.deleteAttach", map);
	}

	@Override
	public int totalPage(String pro_code) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("product.totalPage", pro_code);
	}

	@Override
	public List<ProductDTO> qna_list(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("product.qna_list", map);
	}

	@Override
	public int qnaListCnt(String pro_code) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("product.qnaListCnt", pro_code);
	}

	@Override
	public ProductDTO qna_detail(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("product.qna_detail", map);
	}

	@Override
	public void increaseViewcnt(int board_idx) {
		// TODO Auto-generated method stub
		sqlSession.update("product.increaseViewcnt", board_idx);
	}

	@Override
	public void qna_modify(ProductDTO dto) {
		// TODO Auto-generated method stub
		sqlSession.update("product.qna_modify", dto);
	}

	@Override
	public void qna_insert(ProductDTO dto) {
		// TODO Auto-generated method stub
		sqlSession.insert("product.qna_insert", dto);
	}

	@Override
	public int maxQnaIdx() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("product.maxQnaIdx");
	}

	@Override
	public void qna_delete(Map<String, Object> map) {
		// TODO Auto-generated method stub
		//sqlSession.delete("product.qna_delete", map);
		sqlSession.update("product.qna_delete", map);
	}

	@Override
	public String subname(String subcate) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("product.subname", subcate);
	}

	@Override
	public String catename(String cate) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("product.catename", cate);
	}

	@Override
	public String category(String pro_code) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("product.category", pro_code);
	}

	@Override
	public List<ProductDTO> related_list(String type, String pro_code) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("type", type);
		map.put("pro_code", pro_code);
		return sqlSession.selectList("product.related_list", map);
	}

	@Override
	public String productColor(String pro_code) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("product.productColor", pro_code);
	}

	@Override
	public void deleteReply(Map<String, Object> map) {
		// TODO Auto-generated method stub
		sqlSession.update("product.deleteReply", map);
	}

	@Override
	public List<ProductDTO> qnaList(String member_id) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("product.qnaList", member_id);
	}

	@Override
	public void review_memberDel(String member_id) {
		// TODO Auto-generated method stub
		sqlSession.update("product.review_memberDel", member_id);
	}

	@Override
	public void qna_memberDel(String member_id) {
		// TODO Auto-generated method stub
		sqlSession.update("product.qna_memberDel", member_id);
	}

	@Override
	public List<ProductDTO> main_best(String type) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("product.main_best", type);
	}

}
