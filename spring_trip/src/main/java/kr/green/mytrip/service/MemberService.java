package kr.green.mytrip.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import kr.green.mytrip.vo.MemberVO;
import kr.green.mytrip.vo.SpotMenuVO;

public interface MemberService {

	//회원가입
	boolean insertMember(MemberVO member);
	boolean idDuplicated(String id);
	//로그인 + 사용자메뉴리스트 불러오기
	MemberVO loginMember(MemberVO input);
	List<SpotMenuVO> getMenuList(String userId);
	//mypage 수정
	MemberVO mypageUpdate(MemberVO user, MemberVO input, List<MultipartFile> file);
	
	//아이디, 비밀번호 찾기
	String findId(MemberVO member);
	String findPw(MemberVO member);
	
	//메뉴 추가 수정 삭제
	String setMenu(Map<String, Object> data, MemberVO user);
	
	
	
	



}
