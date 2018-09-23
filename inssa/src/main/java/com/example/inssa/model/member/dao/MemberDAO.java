package com.example.inssa.model.member.dao;

import java.util.List;
import java.util.Map;

import com.example.inssa.model.member.dto.MemberDTO;

public interface MemberDAO {
	public void signUp(MemberDTO dto) throws Exception;
	public String doubleCheckId(String userid)  throws Exception;
	public Integer getSocialNumber()  throws Exception;
	public Integer isRegitstChk(Map<String, Object> paramMap)  throws Exception;
	public Integer isExistMemberId(Map<String, Object> paramMap)  throws Exception;
	public Integer isExistMemberEmail(Map<String, Object> paramMap)  throws Exception;
	public Integer insertMember(MemberDTO member)  throws Exception;
	public Integer insertSocialMember(MemberDTO member)  throws Exception;
	public Integer confirmId(MemberDTO member)   throws Exception;
	public Integer confirmPwd(MemberDTO member) throws Exception;
	public String getLoginId(MemberDTO member) throws Exception;
	public Map<String, Object> findIdByEmail(Map<String, Object> paramMap) throws Exception;
	public Integer modifyPwdByEmail(Map<String, Object> paramMap) throws Exception;
	public Map<String, Object> getMemberInfo(String member_id) throws Exception;
	public Integer modifyMemberInfo(MemberDTO member) throws Exception ;
	public List<Map<String, Object>> getMemberSocialInfo(String member_id) throws Exception;
	public Integer social_link(MemberDTO member)  throws Exception;
	public Integer social_unlink(MemberDTO member) throws Exception;
	public void memberDel(String member_id);;
}
