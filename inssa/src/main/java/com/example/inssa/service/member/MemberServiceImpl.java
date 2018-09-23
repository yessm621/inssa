package com.example.inssa.service.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.inssa.model.member.dao.MemberDAO;
import com.example.inssa.model.member.dto.MemberDTO;
import com.example.inssa.model.shop.dao.ProductDAO;

@Service
public  class MemberServiceImpl implements MemberService {

	@Inject
	MemberDAO memberDao;
	
	@Inject
	ProductDAO productDao;
	
	@Override
	public void signUp(MemberDTO dto) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public String doubleCheckId(String userid) throws Exception  {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getSocialNumber() throws Exception  {
		// TODO Auto-generated method stub
		return memberDao.getSocialNumber();
	}

	@Override
	public int isExistId(String member_id) throws Exception  {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int isRegistChk(Map<String, Object> paramMap)  throws Exception {
		return memberDao.isRegitstChk(paramMap);
	}

	@Override
	public int isExistMemberId(Map<String, Object> paramMap) throws Exception {
		return memberDao.isExistMemberId(paramMap);
	}

	@Override
	public int isExistMemberEmail(Map<String, Object> paramMap) throws Exception  {
		return memberDao.isExistMemberEmail(paramMap);
	}

	@Transactional
	@Override
	public int signUpMember(MemberDTO member) throws Exception {
		
		int signUpMemberChk = memberDao.insertMember(member);
		
		if(member.getSocial_id() != null) {
			
			int sighUpSocialMemberChk = memberDao.insertSocialMember(member);
		}
		return signUpMemberChk;
	}

	@Override
	public Map<String, Object> login(MemberDTO member, HttpServletRequest req) throws Exception {
		Map<String, Object> returnMap = new HashMap<>();
		String loginMsg = "";
		Integer success = null;
		Integer idChk = null;
		Integer pwdChk = null;
		idChk = memberDao.confirmId(member);
		if(idChk != 0) {
			pwdChk = memberDao.confirmPwd(member);
			if(pwdChk == 0) {
				success = 0;
				loginMsg = "check your password";
			} else {
				req.getSession().setAttribute("member_id", member.getMember_id());
				success = 1;
				loginMsg =  "login success";
			}
		} else {
			success = 0;
			loginMsg = "check your id";
		}
		
		returnMap.put("success", success);
		returnMap.put("loginMsg", loginMsg);
		
		return returnMap;
	}

	@Override
	public void sns_login(MemberDTO member, HttpServletRequest req) throws Exception {

		String id = memberDao.getLoginId(member);
		req.getSession().setAttribute("member_id", id);
		
	}

	@Override
	public Map<String, Object> findIdByEmail(Map<String, Object> paramMap) throws Exception {
		return memberDao.findIdByEmail(paramMap);
	}

	@Override
	public Integer modifyPwdByEmail(Map<String, Object> paramMap) throws Exception {
		return memberDao.modifyPwdByEmail(paramMap);
	}

	@Override
	public Map<String, Object> getMemberInfo(String member_id) throws Exception {
		return memberDao.getMemberInfo(member_id);
	}

	@Override
	public Integer modifyMemberInfo(MemberDTO member) throws Exception {
		return memberDao.modifyMemberInfo(member);
	}

	@Override
	public List<Map<String, Object>> getMemberSocialInfo(String member_id) throws Exception {
		return memberDao.getMemberSocialInfo(member_id);
	}

	@Override
	public Integer social_link(MemberDTO member, Boolean social_linked) throws Exception {
		
		Integer socialUpdateChk = null;
		if(social_linked) {
			socialUpdateChk = memberDao.social_unlink(member);
		} else {
			socialUpdateChk = memberDao.social_link(member);
		}
		return socialUpdateChk;
	}

	@Override
	public void memberDel(String member_id) {
		// TODO Auto-generated method stub
		memberDao.memberDel(member_id);
		productDao.review_memberDel(member_id);
		productDao.qna_memberDel(member_id);
	}

}
