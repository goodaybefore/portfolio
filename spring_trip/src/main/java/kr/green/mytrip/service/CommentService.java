package kr.green.mytrip.service;

import java.util.List;

import kr.green.mytrip.pagination.Criteria;
import kr.green.mytrip.vo.CommentVO;
import kr.green.mytrip.vo.MemberVO;

public interface CommentService {
	//댓글 등록
	boolean insertComment(CommentVO comment, MemberVO user);
	//댓글 출력
	int selectTotalCnt(Integer bd_num);
	List<CommentVO> selectCommentList(Integer bd_num, Criteria cri);

}
