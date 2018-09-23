package com.example.inssa.model.member.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.inssa.model.member.dto.MemberDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public void signUp(MemberDTO dto)  throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public String doubleCheckId(String userid)  throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer getSocialNumber()  throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("member.getSocialNumber");
	}

	@Override
	public Integer isRegitstChk(Map<String, Object> paramMap)  throws Exception {
		return  sqlSession.selectOne("member.isRegitstChk", paramMap);
	}

	@Override
	public Integer isExistMemberId(Map<String, Object> paramMap)  throws Exception {
		return sqlSession.selectOne("member.isExistMemberId", paramMap);
	}

	@Override
	public Integer isExistMemberEmail(Map<String, Object> paramMap)  throws Exception {
		return sqlSession.selectOne("member.isExistMemberEmail" , paramMap);
	}

	@Override
	public Integer insertMember(MemberDTO member)  throws Exception {
		return sqlSession.insert("member.insertMember" , member);
	}

	@Override
	public Integer insertSocialMember(MemberDTO member)   throws Exception{
		return sqlSession.insert("member.insertSocialMember" , member);
	}

	@Override
	public Integer confirmId(MemberDTO member) throws Exception {
		return sqlSession.selectOne("member.selectMemberId" , member);
	}

	@Override
	public Integer confirmPwd(MemberDTO member) throws Exception {
		return sqlSession.selectOne("member.selectMemberPwd" , member);
	}

	@Override
	public String getLoginId(MemberDTO member) throws Exception {
		return sqlSession.selectOne("member.selectMemberIdBySocialId" , member);
	}

	@Override
	public Map<String, Object> findIdByEmail(Map<String, Object> paramMap) throws Exception {
		return sqlSession.selectOne("member.selectMemberIdByEmail", paramMap);
	}

	@Override
	public Integer modifyPwdByEmail(Map<String, Object> paramMap) throws Exception {
		return sqlSession.update("member.updatePwdByEmail", paramMap);
	}

	@Override
	public Map<String, Object> getMemberInfo(String member_id) throws Exception {
		return sqlSession.selectOne("member.selectMemberInfo", member_id );
	}

	@Override
	public Integer modifyMemberInfo(MemberDTO member) throws Exception {
		return sqlSession.update("member.updateMemberInfo", member);
	}

	@Override
	public List<Map<String, Object>>getMemberSocialInfo(String member_id) throws Exception {
		return sqlSession.selectList("member.selectMemberSocialInfo", member_id);
	}

	@Override
	public Integer social_link(MemberDTO member) throws Exception {
		return sqlSession.insert("member.insertSocialLink", member);
	}

	@Override
	public Integer social_unlink(MemberDTO member) throws Exception {
		return sqlSession.delete("member.deleteSocialLink", member);
	}

	@Override
	public void memberDel(String member_id) {
		// TODO Auto-generated method stub
		sqlSession.delete("member.memberDel", member_id);
	}

}
