package com.example.inssa.service.member;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.example.inssa.model.member.dto.MemberDTO;

public interface MemberService {
	public void signUp(MemberDTO dto) throws Exception;
	public String doubleCheckId(String userid)  throws Exception;
	public int getSocialNumber()  throws Exception;
	public int isExistId(String member_id)  throws Exception;
	public int isRegistChk(Map<String, Object> paramMap)  throws Exception;
	public int isExistMemberId(Map<String, Object> paramMap)  throws Exception;
	public int isExistMemberEmail(Map<String, Object> paramMap)  throws Exception;
	public int signUpMember(MemberDTO member)  throws Exception;
	public Map<String, Object> login(MemberDTO member, HttpServletRequest req) throws Exception;
	public void sns_login(MemberDTO member, HttpServletRequest req) throws Exception;
	public Map<String, Object> findIdByEmail(Map<String, Object> paramMap) throws Exception;
	public Integer modifyPwdByEmail(Map<String, Object> paramMap) throws Exception;
	public Map<String, Object> getMemberInfo(String member_id) throws Exception;
	public Integer modifyMemberInfo(MemberDTO member) throws Exception;
	public List<Map<String, Object>> getMemberSocialInfo(String member_id) throws Exception;
	public Integer social_link(MemberDTO member, Boolean social_linked) throws Exception;
	public void memberDel(String member_id);
}
