package kr.green.mytrip.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.green.mytrip.dao.MemberDAO;
import kr.green.mytrip.vo.MemberVO;

@Service
public class MemberServiceImp implements MemberService {
	@Autowired
	MemberDAO memberDao;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	@Override
	public boolean insertMember(MemberVO member) {
		if(member.getMe_id()==null || member.getMe_pw()==null || member.getMe_pw().length()==0) return false;
		//아이디 중복 확인
		if(memberDao.selectMember(member.getMe_id()) != null) return false;
		
		//비밀번호 암호화
		String encPw = passwordEncoder.encode(member.getMe_pw());
		member.setMe_pw(encPw);
		//회원 기본 등급 저장
		member.setMe_gr_name("트립비기너");
		//기본 공개 범우 저장
		member.setMe_op_num("1");
		//DB에 회원 추가
		memberDao.insertMember(member);
		return true;
	}
	@Override
	public MemberVO loginMember(MemberVO input) {
		if(input == null) return null;
		if(input.getMe_id()==null || input.getMe_pw()==null) return null;
		
		//id로 db회원 불러오기
		MemberVO dbuser = memberDao.selectMember(input.getMe_id());
		if(dbuser == null) return null;
		
		//input user의 비밀번호가 일치하는지 확인
		if(dbuser.getMe_id().equals(input.getMe_id()) && passwordEncoder.matches(input.getMe_pw(), dbuser.getMe_pw())) {
			return dbuser;
		}
		
		
		return null;
	}
	
}

