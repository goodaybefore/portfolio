package kr.green.mytrip.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.green.mytrip.pagination.Criteria;
import kr.green.mytrip.vo.CommentVO;

public interface CommentDAO {
	//댓글 등록
	void insertComment(@Param("comment")CommentVO comment);
	//댓글 확인
	int selectTotalCnt(@Param("bd_num")Integer bd_num);
	List<CommentVO> selectCommentList(@Param("bd_num")Integer bd_num, @Param("cri")Criteria cri);

}
