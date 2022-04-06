package kr.green.mytrip.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.green.mytrip.dao.CommentDAO;
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
		System.out.println("user : "+ user);
		System.out.println("commentVO : "+comment);
		commentDao.insertComment(comment);
		return true;
	}
	

}
