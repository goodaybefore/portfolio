package kr.green.mytrip.service;

import java.util.List;

import kr.green.mytrip.pagination.Criteria;
import kr.green.mytrip.vo.BoardVO;
import kr.green.mytrip.vo.MemberVO;

public interface BoardService {

	//board 작성
	boolean registerBoard(BoardVO board, MemberVO user);

	//board List 가져오기
	List<BoardVO> getBoardList(Criteria cri);
	
	//board 1개 가져오기
	BoardVO getBoard(Integer bd_num);
	
	//board 전체 개수 가져오기
	int getTotalBoardCount();
	

}
