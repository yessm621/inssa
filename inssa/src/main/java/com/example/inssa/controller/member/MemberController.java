package com.example.inssa.controller.member;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.inssa.model.member.dto.MemberDTO;
import com.example.inssa.service.member.MemberService;
import com.itextpdf.text.List;
import com.itextpdf.text.log.Logger;
import com.itextpdf.text.log.LoggerFactory;



@Controller
@RequestMapping("member/*")
public class MemberController {

	private static Logger log = LoggerFactory.getLogger(MemberController.class);
	@Inject
	MemberService memberService;
	
	//MEMBER  테이블에 아이디 중복 체크
	@RequestMapping(value="register_id_chk.do", method=RequestMethod.POST ,  produces="application/json")
	public @ResponseBody Integer register_id_chk(String member_id) throws Exception {
		
			Integer registChk = null;
			try  {
				Map<String, Object> paramMap = new HashMap<>();
				paramMap.put("member_id", member_id);
				
				registChk = memberService.isExistMemberId(paramMap);
			} catch (Exception e) {
				log.error("에러발생", e);
			}
		
			
			return registChk;
	}
	
	
	//MEMBER 테이블에 이메일 중복 체크
	@RequestMapping(value="register_email_chk.do", method=RequestMethod.POST ,  produces="application/json")
	public @ResponseBody Integer register_email_chk(String email) throws Exception {
		
			Integer registChk = null; 
			
			try {
				Map<String, Object> paramMap = new HashMap<>();
				paramMap.put("email", email);
				
				registChk = memberService.isExistMemberEmail(paramMap);
				
			} catch (Exception e) {
				log.error("에러발생", e);
			}
		
			
			return registChk;
	}
	
	@RequestMapping(value="register_classify.do", method=RequestMethod.GET)
	public void register_classify() {
	}
	
	@RequestMapping(value="callback.do", method=RequestMethod.GET)
	public void callback() {
		
	}
	

	
	//MEMBER_SOCIAL 테이블에 가입유무 체크
	@RequestMapping(value="sns_register_chk.do", method=RequestMethod.POST, produces="application/json")
	public @ResponseBody Integer sns_register_chk(String id, String type)  throws Exception{
		
			Integer registChk = null;
			
			try {
				Map<String, Object> paramMap = new HashMap<>();	
				paramMap.put("id", id);
				paramMap.put("type", type);
				
				registChk = memberService.isRegistChk(paramMap);
			} catch (Exception e) {
				log.error("에러발생", e);
			}
			
			return registChk;
	}
	
	
	//개인정보 화면에서 소셜연동 하기
		@RequestMapping(value="social_link.do", method=RequestMethod.POST, produces="application/json")
		public @ResponseBody Integer social_link(MemberDTO member, Boolean social_linked)  throws Exception{
			
				Integer registChk = null;
				
				try {

					registChk = memberService.social_link(member, social_linked);
				} catch (Exception e) {
					log.error("에러발생", e);
				}
				
				return registChk;
		}


	
	//회원가입 페이지로 이동
	@RequestMapping(value="registerForm.do")
	public ModelAndView sns_register(String id, String type, ModelAndView mav) throws Exception {
		
			mav.setViewName("member/registerForm");
			mav.addObject("social_id", id);
			mav.addObject("social_type", type);
			
			return mav;
	}
	
	
	//회원가입 처리
	@RequestMapping(value="signUp.do" , method=RequestMethod.POST)
	public ModelAndView signUp(MemberDTO member,ModelAndView mav ) throws Exception {
		
			Integer sighUpChk = null;
			
			try {
				sighUpChk = memberService.signUpMember(member);
				mav.setViewName("redirect:/");
			} catch (Exception e) {
				log.error("에러발생", e);
			}	
			return mav;
		}
	
	@RequestMapping(value="loginForm.do")
	public  void loginForm(HttpServletRequest req) {
		 String prev_url = req.getHeader("referer");
		 
		 req.getSession().setAttribute("prev_url", prev_url);
	}
	
	// sns 로그인 처리
	@RequestMapping(value="sns_login.do" , method=RequestMethod.GET, produces="application/json")
	public ModelAndView  sns_login(MemberDTO member, HttpServletRequest req, ModelAndView mav) throws Exception{
		
			Map<String, Object> returnMap = new HashMap<>();
			
			try {
				 memberService.sns_login(member,req);
				 
				 String prev_url =(String) req.getSession().getAttribute("prev_url");
				 if(prev_url != null) {
					 mav.setViewName("redirect:"+ prev_url);
				 } else {
					 mav.setViewName("redirect:/");
				 }
				
			} catch (Exception e) {
				log.error("에러발생", e);
			}
	
			return mav;
	}
	
	// 일반 로그인 처리
	@RequestMapping(value="login.do" , method=RequestMethod.POST, produces="application/json")
	public @ResponseBody Map<String, Object> login(MemberDTO member, HttpServletRequest req) throws Exception{
		
			Map<String, Object> returnMap = new HashMap<>();
			
			try {
				returnMap = memberService.login(member, req);
			String prev_url =(String) req.getSession().getAttribute("prev_url");
			returnMap.put("prev_url", prev_url);
			} catch (Exception e) {
				log.error("에러발생", e);
			}
	
			return returnMap;
	}
	
	//로그아웃 처리
	@RequestMapping(value="logout.do" , method=RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest req, ModelAndView mav) throws Exception{
		
			String member_id = "";
			try {
			         member_id = (String) req.getSession().getAttribute("member_id");
			         
			         if(member_id != null) {
			        	 req.getSession().removeAttribute("member_id");
			        	 mav.setViewName("redirect:/");
			         }
			} catch (Exception e) {
				log.error("에러발생", e);
			}
		return mav;
	}
	
	@Autowired
	private JavaMailSenderImpl mailSender;
	//메일 보내기
	@RequestMapping(value = "/sendMailAttach.do", method=RequestMethod.POST,  produces="application/json"  )
	public @ResponseBody Map<String, Object> sendMailAttach(String email_id , String type) {
		Map<String, Object> paramMap = new HashMap<>();
		String randomCode =  String.valueOf((int) ((Math.random()) * 10000)) ;  // 인증코드(랜덤숫자)
		Integer sendChk = 0;  // 보냈는지 체크하는 변수
		Integer emailExistChk = 0;  //이메일 있는지 확인
		try {
			
			//이메일 인증 타입이 아이디찾기, 비밀번호 찾기 일 경우
			if(type != null) {
				
				paramMap.put("email", email_id);
			    emailExistChk =	memberService.isExistMemberEmail(paramMap);
			    	//등록된 이메일이 없으면
			    	if(emailExistChk == 0) {
			    		//exist 에 0을 넣어주고 함수를 빠져나간다.
			    		paramMap.put("exist", emailExistChk);
			    		return paramMap;
			    	}
			} 
			
			//회원가입 또는 등록된 이메일이 있는 경우(아이디찾기, 비밀번호 찾기)
			paramMap.put("email_id", email_id);
			paramMap.put("randomCode", randomCode);
		    final MimeMessagePreparator preparator = new MimeMessagePreparator() {
		        @Override
		        public void prepare(MimeMessage mimeMessage) throws Exception {
		            final MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
		            String subject = "";
		            String text = "";
		            String from = "interiorproject@gmail.com";
		            String to =  email_id;
		            if(type != null) {
		            	if(type.equals("findId")) {
		            		subject = "아이디 찾기 인증번호입니다.";
		            	} else if(type.equals("findPwd")) {
		            		subject = "비밀번호 찾기 인증번호입니다.";
		            	}
		            } else {
		            	 subject = "요청하신 인증번호 입니다.";
		            }
		           
		            text = randomCode;
		            helper.setFrom(from);
		            helper.setTo(to);
		            helper.setSubject(subject);
		            helper.setText(text, true);
		            
		            /*파일 보낼때 쓰임
		            FileSystemResource file = new FileSystemResource(new File("E:/test.hwp"));
		            helper.addAttachment("test.hwp", file);
		            */
		            
		            /* 메일내 이미지 삽입
		            String contents = vo.getContents() + "<img src=\"cid:DUKE.gif\">";
		            helper.setText(contents, true);

		            FileSystemResource file = new FileSystemResource(new File("E:/DUKE.gif"));
		            helper.addInline("DUKE.gif", file);
		            */
		        }
		    };
		    
		    mailSender.send(preparator);
		    sendChk = 1;
		    paramMap.put("sendChk", sendChk);
		    paramMap.put("randomCode", randomCode);
		   
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	
	    return paramMap;
	}
	
	//이메일 인증 아이디 찾기
	@RequestMapping(value="findIdByEmail" , method=RequestMethod.POST, produces="application/json")
	public @ResponseBody Map<String, Object> findIdByEmail(String email) throws Exception {
			Map<String, Object> paramMap = new HashMap<>();
			try {
				paramMap.put("email", email);
				paramMap = memberService.findIdByEmail(paramMap);
			} catch (Exception e) {
				log.error("에러발생" , e);
			}
			
			return paramMap;
		}
	
	//이메일 인증 비밀번호 변경
	@RequestMapping(value="modifyPwdByEmail", method=RequestMethod.POST, produces="application/json")
	public @ResponseBody Integer modifyPwdByEmail(String email, String pwd) throws Exception {
			Map<String, Object> paramMap = new HashMap<>();
			Integer updatePwdChk = null;
			try {
					paramMap.put("email", email);
					paramMap.put("pwd", pwd);
					updatePwdChk = memberService.modifyPwdByEmail(paramMap);
			} catch (Exception e) {
				log.error("에러발생" , e);
			}
			return updatePwdChk;
	}
	
	//마이페이지 이동
	@RequestMapping(value="mypage", method=RequestMethod.GET) 
	public ModelAndView mypage(ModelAndView mav, HttpSession session) throws Exception{
		String memberId = "";
		try {
			memberId = (String) session.getAttribute("member_id");
			
			if(memberId == null) {
				mav.setViewName("redirect:loginForm.do");
			} else {
				mav.setViewName("member/mypage");
			}
		} catch(Exception e)  {
			log.error("에러발생" , e);
		}
		return mav; 
	}
	
	//멤버 마이페이지 개인정보
	@RequestMapping(value="getMemberInfo", method=RequestMethod.GET, produces="application/json")
	public @ResponseBody Map<String, Object> getMemberInfo(String member_id) {
			Map<String, Object> paramMap = null;
		try {
			paramMap = memberService.getMemberInfo(member_id);
		/*	paramMap.put("member", memberDTO);*/
		} catch (Exception e) {
			log.error("에러발생" , e);
		}
		
		return paramMap;
	}
	
	
	
	//멤버 계정 정보 수정
	@RequestMapping(value="modifyMemberInfo" , method=RequestMethod.POST)
	public ModelAndView modifyMemberInfo(MemberDTO member, HttpServletRequest req , ModelAndView mav) throws Exception{
			Integer modifyMemberChk = null;
		try {
			 modifyMemberChk = memberService.modifyMemberInfo(member);
			 mav.addObject("modifyMemberChk", modifyMemberChk);
			 mav.setViewName("member/mypage");
		} catch (Exception e) {
			log.error("에러발생" , e);
		}
			return mav;
		
	}
	
	//
	@RequestMapping(value="getMemberSocialInfo", method=RequestMethod.GET)
	public @ResponseBody ArrayList<Map<String, Object>> getMemberSocialInfo(String member_id) throws Exception{
		java.util.List<Map<String , Object>> memberSocialInfo = null;
			try {
				memberSocialInfo =memberService.getMemberSocialInfo(member_id);
			} catch (Exception e) {
				log.error("에러발생" , e);
			}
			return (ArrayList<Map<String, Object>>) memberSocialInfo;
	}
		
	@RequestMapping("emailChk.do")
	public ModelAndView emailChk(ModelAndView mav) {
		mav.setViewName("member/emailChk");
		return mav;
	}
	
	@RequestMapping("memberDel.do")
	public String memberDel(HttpSession session) {
		String member_id = (String)session.getAttribute("member_id");
		
		memberService.memberDel(member_id);
		
		return "redirect:/member/mypage";
	}
	
	@RequestMapping("loginFind.do")
	public ModelAndView loginFind(ModelAndView mav) {
		mav.setViewName("member/loginFind");
		return mav;
	}
	
	@RequestMapping("passwdFind.do")
	public ModelAndView passwdFind(ModelAndView mav) {
		mav.setViewName("member/passwdFind");
		return mav;
	}
	
}
