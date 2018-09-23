package com.example.inssa.controller.reply;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.inssa.model.reply.dto.ReplyDTO;
import com.example.inssa.service.reply.ReplyService;
import com.google.gson.Gson;

@Controller
@RequestMapping("reply/*")
public class ReplyController {
	
	@Inject
	ReplyService replyService;
	
	@RequestMapping("reply_insert.do")
	public ModelAndView reply_insert(ReplyDTO dto, ModelAndView mav) {
		dto.setName(replyService.replyName(dto.getReplyer()));
		replyService.reply_insert(dto);
		
		mav.setViewName("redirect:/shop/product/qna_detail.do");
		mav.addObject("pro_code", dto.getProduct_code());
		mav.addObject("board_idx", dto.getBoard_idx());
		
		return mav;
	}
	
	@RequestMapping(value="replyList.do", method=RequestMethod.POST, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String replyList(String pro_code, int board_idx){
		Gson gson = new Gson();
		
		return gson.toJson(replyService.replyList(pro_code, board_idx));
	}
	
	@RequestMapping(value="reply_update.do", method=RequestMethod.POST, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String reply_update(ReplyDTO dto) {
		replyService.reply_update(dto);
		
		Gson gson = new Gson();
		
		return gson.toJson(replyService.reply_view(dto));
	}
	
	@RequestMapping(value="reply_delete.do", method=RequestMethod.POST, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String reply_delete(ReplyDTO dto) {
		replyService.reply_delete(dto);
		
		Gson gson = new Gson();
		
		return gson.toJson(replyService.reply_view(dto));
	}
}
