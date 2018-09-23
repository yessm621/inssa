package com.example.inssa;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.inssa.model.shop.dto.ProductDTO;
import com.example.inssa.service.shop.ProductService;
import com.google.gson.Gson;

@Controller
public class HomeController {
	
	@Inject
	ProductService productService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(@RequestParam(defaultValue="GS")String type, Model model) {
		model.addAttribute("main_best", productService.main_best(type));
		
		return "home";
	}
	
	@RequestMapping(value = "/", method = RequestMethod.POST, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String main(@RequestParam(defaultValue="GS")String type) {
		List<ProductDTO> best = productService.main_best(type);

		Gson gson = new Gson();
		
		return gson.toJson(best);
	}
	
}
