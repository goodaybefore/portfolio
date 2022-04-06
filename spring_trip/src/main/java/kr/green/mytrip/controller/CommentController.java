package kr.green.mytrip.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import kr.green.mytrip.pagination.Criteria;
import kr.green.mytrip.pagination.PageMaker;
import kr.green.mytrip.service.CommentService;
import kr.green.mytrip.vo.CommentVO;
import kr.green.mytrip.vo.MemberVO;

@RestController
public class CommentController {
	@Autowired
	CommentService commentService;
	
	//ajax에서 json으로 넘겨줄떄(post방식으로) 서버에서 받으려먼 @RequestBody 쓰기
	@RequestMapping(value = "/comment/insert", method=RequestMethod.POST)
	public boolean commentInsert(@RequestBody CommentVO comment, HttpServletRequest request){
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		System.out.println("comment : "+comment);
		
		return false;
		//return commentService.insertComment(comment, user);
	}
	
//	//comment list
//	@RequestMapping(value = "/comment/list", method=RequestMethod.GET)
//	public Map<String, Object> commentList(Integer page, Integer bd_num){
//		
//		Map<String, Object> map = new HashMap<String, Object>();
//		
//		int totalCnt = commentService.selectTotalCnt(bd_num); // db에서 가져올 예정
//		int displayPageNum = 2;
//		Criteria cri = new Criteria(page, 3);//1페이지, 한 페이지에 3개씩
//		
//		List<CommentVO> list = commentService.selectCommentList(bd_num, cri);
//		PageMaker pm = new PageMaker(totalCnt, displayPageNum, cri);
//		
//		
//		map.put("pm", pm);
//		map.put("list", list);
//		return map;
//	}
//	
//	//댓글 삭제
//	@RequestMapping(value = "/comment/delete", method=RequestMethod.GET)
//	public boolean commentDelete(Integer co_num, HttpServletRequest request){
//		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
//		System.out.println("user : "+user);
//		System.out.println("co_num : "+co_num);
//		
//		return commentService.deleteComment(user, co_num);
//	}
//	
//	//댓글 수정
//	@RequestMapping(value = "/comment/modify", method=RequestMethod.POST)
//	public boolean commentModify(@RequestBody CommentVO comment, HttpServletRequest request){
//		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
//		
//		return commentService.modifyComment(user, comment);
//	}
}
