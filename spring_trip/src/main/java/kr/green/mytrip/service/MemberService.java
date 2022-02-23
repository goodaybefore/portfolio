package kr.green.mytrip.service;

import java.util.List;

import kr.green.mytrip.vo.MemberVO;

public interface MemberService {

	//회원가입
	boolean insertMember(MemberVO member);
	//로그인 + 사용자메뉴리스트 불러오기
	MemberVO loginMember(MemberVO input);
	List<String> getMenuList(MemberVO user);



}
