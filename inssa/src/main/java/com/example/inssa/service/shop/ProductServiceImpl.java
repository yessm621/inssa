package com.example.inssa.service.shop;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.example.inssa.model.shop.dao.ProductDAO;
import com.example.inssa.model.shop.dto.ProductDTO;

@Service
public class ProductServiceImpl implements ProductService {

	@Inject
	ProductDAO productDao;
	
	@Override
	public List<ProductDTO> product_list(String cate, String subcate, String sorting, String search_product, Model model, HttpServletRequest req) {
		// TODO Auto-generated method stub
		int currentPage = 1;
		int listSize = 12;
		int blockSize = 5;
		String type = cate + "_" + subcate;
		
		if(req.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(req.getParameter("currentPage"));
		}
		
		int listCnt = productDao.listCnt(type, sorting, search_product);
		int totalPage = listCnt / listSize;
		if((listCnt % listSize) != 0) {
			totalPage++;
		}
		
		int startRow = (listSize * (currentPage - 1)) + 1;
		int endRow = listSize * currentPage;
		
		int startBlock = ((currentPage - 1) / blockSize) * blockSize + 1;
		int endBlock = startBlock + blockSize - 1;
		
		if(endBlock > totalPage) {
			endBlock = totalPage;
		}
		
		List<ProductDTO> category = productDao.getCategory(cate);
		
		model.addAttribute("listCnt", listCnt);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("startRow", startRow);
		model.addAttribute("endRow", endRow);
		model.addAttribute("startBlock", startBlock);
		model.addAttribute("endBlock", endBlock);
		model.addAttribute("category", category);
		model.addAttribute("subcate", subcate);
		
		Map<String, Object> map = new HashMap<>();
		map.put("type", type);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		map.put("sorting", sorting);
		map.put("search_product", search_product);
		
		return productDao.product_list(map);
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
		return productDao.product_view(code);
	}

	@Override
	public List<ProductDTO> review_list(String pro_code, Model model, HttpServletRequest req) {
		// TODO Auto-generated method stub
		int currentPage = 1;
		int listSize = 10;
		int blockSize = 5;
		
		if(req.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(req.getParameter("currentPage"));
		}
		
		int listCnt = productDao.totalPage(pro_code);
		int totalPage = listCnt / listSize;
		if((listCnt % listSize) != 0) {
			totalPage++;
		}
		
		int startRow = listSize * (currentPage - 1) + 1;
		int endRow = listSize * currentPage;
		
		int startBlock = ((currentPage - 1) / blockSize) * blockSize + 1;
		int endBlock = startBlock + blockSize - 1;
		
		if(endBlock > totalPage) {
			endBlock = totalPage;
		}
		
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("listSize", listSize);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("listCnt", listCnt);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("startRow", startRow);
		model.addAttribute("endRow", endRow);
		model.addAttribute("startBlock", startBlock);
		model.addAttribute("endBlock", endBlock);

		Map<String, Object> map = new HashMap<>();
		map.put("pro_code", pro_code);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		return productDao.review_list(map);
	}

	@Override
	public List<ProductDTO> file_list(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return productDao.file_list(map);
	}

	@Override
	public int proBuyCheck(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return productDao.proBuyCheck(map);
	}

	@Override
	public List<ProductDTO> review_requiredInfo(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return productDao.review_requiredInfo(map);
	}

	@Override
	public void review_insert(ProductDTO dto) {
		// TODO Auto-generated method stub
		productDao.review_insert(dto);
		
		int board_idx = productDao.maxReviewIdx();
		dto.setBoard_idx(board_idx);
		dto.setBoard_type("R");
		String[] files = dto.getFiles();
		if(files == null) return;//첨부파일이 없으면 리턴
		for(String name : files) {
			productDao.addAttach(name, dto);
		}
	}

	@Override
	public ProductDTO review_modify_list(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return productDao.review_modify_list(map);
	}

	@Override
	public List<ProductDTO> file_modify_list(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return productDao.file_modify_list(map);
	}

	@Override
	public void review_modify(ProductDTO dto) {
		// TODO Auto-generated method stub
		productDao.review_modify(dto);
		String[] files = dto.getFiles();
		if(files == null) return;
		for(String name: files) {
			int checkOriginalName = productDao.checkOriginalName(name, dto.getIdx());
			if(checkOriginalName == 0) {
				dto.setBoard_idx(dto.getIdx());
				dto.setBoard_type("R");
				productDao.addAttach(name, dto);
			}
		}
	}

	@Override
	public void deleteFile(String fileName) {
		// TODO Auto-generated method stub
		productDao.deleteFile(fileName);
	}

	@Override
	public void review_delete(String board_idx, String pro_code, String board_type) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("board_idx", board_idx);
		map.put("pro_code", pro_code);
		map.put("board_type", board_type);
		productDao.review_delete(map);
		productDao.deleteAttach(map);
	}

	@Override
	public List<ProductDTO> qna_list(String pro_code, Model model, HttpServletRequest req) {
		// TODO Auto-generated method stub
		int currentPage = 1;
		int listSize = 10;
		int blockSize = 5;
		
		if(req.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(req.getParameter("currentPage"));
		}
		
		int qnaListCnt = productDao.qnaListCnt(pro_code);
		int totalPage = qnaListCnt / listSize;
		if((qnaListCnt % listSize) != 0) {
			totalPage++;
		}
		
		int startRow = listSize * (currentPage - 1) + 1;
		int endRow = listSize * currentPage;
		
		int startBlock = ((currentPage - 1) / blockSize) * blockSize + 1;
		int endBlock = startBlock + blockSize - 1;
		
		if(endBlock > totalPage) {
			endBlock = totalPage;
		}
		
		model.addAttribute("q_currentPage", currentPage);
		model.addAttribute("q_listSize", listSize);
		model.addAttribute("q_blockSize", blockSize);
		model.addAttribute("q_qnaListCnt", qnaListCnt);
		model.addAttribute("q_totalPage", totalPage);
		model.addAttribute("q_startRow", startRow);
		model.addAttribute("q_endRow", endRow);
		model.addAttribute("q_startBlock", startBlock);
		model.addAttribute("q_endBlock", endBlock);
		
		Map<String, Object> map = new HashMap<>();
		map.put("pro_code", pro_code);
		map.put("startRow", startRow);
		map.put("endRow", endRow);
		
		return productDao.qna_list(map);
	}

	@Override
	public ProductDTO qna_detail(Map<String, Object> map) {
		// TODO Auto-generated method stub
		
		
		return productDao.qna_detail(map);
	}

	@Override
	public void increaseViewcnt(int board_idx, HttpSession session) {
		// TODO Auto-generated method stub
		long update_time = 0;
		//세션에 저장된 게시물의 조회시간 검색
		if(session.getAttribute("update_time_"+board_idx) != null) {
			update_time = (long)session.getAttribute("update_time_"+board_idx);
		}
		//현재 시간
		long current_time = System.currentTimeMillis();
		//일정 시간이 경과된 후 조회수 증가 처리
		if(current_time - update_time > 60*1000) {
			productDao.increaseViewcnt(board_idx);
			session.setAttribute("update_time_"+board_idx, current_time);
		}
	}

	@Override
	public void qna_modify(ProductDTO dto) {
		// TODO Auto-generated method stub
		productDao.qna_modify(dto);
		
		String[] files = dto.getFiles();
		if(files == null) return;
		for(String name: files) {
			int checkOriginalName = productDao.checkOriginalName(name, dto.getIdx());
			if(checkOriginalName == 0) {
				dto.setBoard_idx(dto.getIdx());
				dto.setBoard_type("Q");
				productDao.addAttach(name, dto);
			}
		}
	}

	@Override
	public void qna_insert(ProductDTO dto) {
		// TODO Auto-generated method stub
		productDao.qna_insert(dto);
		
		int board_idx = productDao.maxQnaIdx();
		dto.setBoard_idx(board_idx);
		dto.setBoard_type("Q");
		String[] files = dto.getFiles();
		if(files == null) return;//첨부파일이 없으면 리턴
		for(String name : files) {
			productDao.addAttach(name, dto);
		}
	}

	@Override
	public void qna_delete(String board_idx, String pro_code, String board_type) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<>();
		map.put("board_idx", board_idx);
		map.put("pro_code", pro_code);
		map.put("board_type", board_type);
		productDao.qna_delete(map);
		productDao.deleteAttach(map);
		productDao.deleteReply(map);
	}

	@Override
	public String subname(String subcate) {
		// TODO Auto-generated method stub
		return productDao.subname(subcate);
	}

	@Override
	public String catename(String cate) {
		// TODO Auto-generated method stub
		return productDao.catename(cate);
	}

	@Override
	public String category(String pro_code) {
		// TODO Auto-generated method stub
		return productDao.category(pro_code);
	}

	@Override
	public List<ProductDTO> related_list(String type, String pro_code) {
		// TODO Auto-generated method stub
		return productDao.related_list(type, pro_code);
	}

	@Override
	public String productColor(String pro_code) {
		// TODO Auto-generated method stub
		return productDao.productColor(pro_code);
	}

	@Override
	public List<ProductDTO> qnaList(String member_id) {
		// TODO Auto-generated method stub
		return productDao.qnaList(member_id);
	}

	@Override
	public List<ProductDTO> main_best(String type) {
		// TODO Auto-generated method stub
		return productDao.main_best(type);
	}

}
