package com.example.inssa.controller.review;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.inssa.model.review.dto.ReviewDTO;
import com.example.inssa.service.review.ReviewService;
import com.google.gson.Gson;

@Controller
@RequestMapping("review/*")
public class ReviewController {

	@Inject
	ReviewService reviewService;
	
	@RequestMapping(value="review_list.do", method=RequestMethod.POST, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String review_list(String code) {
		System.out.println("code:"+code);
		int start = 1;
		int end = 10;
		try {
			List<ReviewDTO> list = reviewService.review_list(start, end, code);
			
			System.out.println(list);
			
			Gson gson = new Gson();
			return gson.toJson(list);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return null;
	}
}
