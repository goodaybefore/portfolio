package kr.green.mytrip.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.green.mytrip.vo.MemberVO;
import kr.green.mytrip.vo.SpotMenuVO;

public interface MemberDAO {

	MemberVO selectMember(@Param("me_id")String me_id);
	
	//회원가입 - 기본메뉴를 함께 생성
	void insertMember(@Param("user")MemberVO member);
	void insertDefaultMenu(@Param("menu")SpotMenuVO menu);
	//로그인 - 사용자의 메뉴리스트 불러오기
	List<String> selectMenuList(@Param("user")MemberVO user);

}
