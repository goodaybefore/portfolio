package kr.green.mytrip.service;

import kr.green.mytrip.vo.MemberVO;

public interface MemberService {

	//회원가입
	boolean insertMember(MemberVO member);
	//로그인
	MemberVO loginMember(MemberVO input);



}
