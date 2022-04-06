package kr.green.mytrip.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.green.mytrip.vo.FileVO;
import kr.green.mytrip.vo.MemberVO;
import kr.green.mytrip.vo.SpotMenuVO;

public interface MemberDAO {

	MemberVO selectMember(@Param("me_id")String me_id);
	
	//회원가입 - 기본메뉴를 함께 생성
	void insertMember(@Param("user")MemberVO member);
	void insertDefaultMenu(@Param("menu")SpotMenuVO menu);
	//로그인 - 사용자의 메뉴리스트 불러오기
	List<SpotMenuVO> selectMenuList(@Param("userId")String userId);
	
	//mypage 수정
	void mypageUpdate(@Param("input")MemberVO input);
	//photo(프로필사진
	void updateProfile(@Param("photo")MemberVO p);
	void deleteProfile(@Param("me_id")String me_id);
	
	//아이디 찾기
	MemberVO selectMemberByEmail(@Param("member")MemberVO member);
	//비밀번호 찾기
	void updateMember(@Param("user")MemberVO dbuser);

}
