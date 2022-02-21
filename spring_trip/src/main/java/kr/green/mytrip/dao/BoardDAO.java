package kr.green.mytrip.dao;

import org.apache.ibatis.annotations.Param;

import kr.green.mytrip.vo.BoardVO;

public interface BoardDAO {

	void insertBoard(@Param("board")BoardVO board);

}
