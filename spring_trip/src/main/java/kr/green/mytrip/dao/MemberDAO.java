package kr.green.mytrip.dao;

import org.apache.ibatis.annotations.Param;

import kr.green.mytrip.vo.MemberVO;

public interface MemberDAO {

	MemberVO selectMember(@Param("me_id")String me_id);

	void insertMember(@Param("user")MemberVO member);

}
