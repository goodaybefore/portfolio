package kr.green.mytrip.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.green.mytrip.dao.MemberDAO;
import kr.green.mytrip.vo.MemberVO;

@Service
public class MemberServiceImp implements MemberService {
	@Autowired
	MemberDAO memberDao;

}
