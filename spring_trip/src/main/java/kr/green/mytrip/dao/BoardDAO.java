package kr.green.mytrip.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.green.mytrip.pagination.Criteria;
import kr.green.mytrip.vo.BoardVO;

public interface BoardDAO {
	
	//게시글 등록(register)
	void insertBoard(@Param("board")BoardVO board);
	//게시글 리스트(list)
	List<BoardVO> selectBoardList(@Param("cri")Criteria cri);
	//게시글 1개(detail)
	BoardVO selectBoard(@Param("bd_num")Integer bd_num);
	
	//pagination
	//totalcount
	int selectTotalBoardCount();

}
