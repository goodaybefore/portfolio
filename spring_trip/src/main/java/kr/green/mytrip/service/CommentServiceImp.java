package kr.green.mytrip.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.green.mytrip.dao.CommentDAO;
import kr.green.mytrip.pagination.Criteria;
import kr.green.mytrip.vo.CommentVO;
import kr.green.mytrip.vo.MemberVO;

@Service
public class CommentServiceImp implements CommentService{
	@Autowired
	CommentDAO commentDao;
	
	@Override
	public boolean insertComment(CommentVO comment, MemberVO user) {
		if(user == null || comment == null) return false;
		if(comment.getCo_contents()==null || user.getMe_id()==null) return false;
		
		if(!comment.getCo_me_id().equals(user.getMe_id())) return false;
		
		comment.setCo_me_id(user.getMe_id());
		commentDao.insertComment(comment);
		return true;
	}

	@Override
	public int selectTotalCnt(Integer bd_num) {
		if(bd_num<=0||bd_num==null) return 0;
		return commentDao.selectTotalCnt(bd_num);
	}

	@Override
	public List<CommentVO> selectCommentList(Integer bd_num, Criteria cri) {
		if(bd_num<=0 || bd_num==null) return null;
		return commentDao.selectCommentList(bd_num, cri);
	}
	

}
