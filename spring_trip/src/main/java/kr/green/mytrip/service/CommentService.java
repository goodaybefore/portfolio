package kr.green.mytrip.service;

import kr.green.mytrip.vo.CommentVO;
import kr.green.mytrip.vo.MemberVO;

public interface CommentService {
	//댓글 등록
	boolean insertComment(CommentVO comment, MemberVO user);

}
