package kr.green.mytrip.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.green.mytrip.service.BoardService;
import kr.green.mytrip.vo.BoardVO;
import kr.green.mytrip.vo.MemberVO;

@Controller
@RequestMapping(value = "/board")
public class BoardController {
	@Autowired
	BoardService boardService;
	
	@RequestMapping(value = "/notice", method = RequestMethod.GET)
	public ModelAndView notice(ModelAndView mv, HttpServletRequest request) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		mv.addObject("user", user);
		mv.setViewName("/board/notice");
		return mv;
	}
	
	//등록
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public ModelAndView boardRegisteGetr(ModelAndView mv, HttpServletRequest request) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		//if(user ==null || !user.getMe_gr_name().equals("트립매니저") || !user.getMe_gr_name().equals("트립파트너"))
			//mv.setViewName("redirect:/board/notice");
		mv.setViewName("/board/register");
		return mv;
	}
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public ModelAndView boardRegisterPost(ModelAndView mv, HttpServletRequest request, BoardVO board) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		boolean isInsert = boardService.registerBoard(board, user);
		System.out.println(isInsert);
		mv.setViewName("/board/register");
		return mv;
	}
	
	//확인
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public ModelAndView boardDetailGet(ModelAndView mv, Integer bd_num) {
		System.out.println("bd_num : "+bd_num);
		mv.setViewName("/board/detail");
		return mv;
	}
	
}
