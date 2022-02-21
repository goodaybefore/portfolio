package kr.green.mytrip.service;

import kr.green.mytrip.vo.BoardVO;
import kr.green.mytrip.vo.MemberVO;

public interface BoardService {

	boolean registerBoard(BoardVO board, MemberVO user);

}
