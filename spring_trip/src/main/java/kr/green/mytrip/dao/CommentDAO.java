package kr.green.mytrip.dao;

import org.apache.ibatis.annotations.Param;

import kr.green.mytrip.vo.CommentVO;

public interface CommentDAO {
	//댓글 등록
	void insertComment(@Param("comment")CommentVO comment);

}
