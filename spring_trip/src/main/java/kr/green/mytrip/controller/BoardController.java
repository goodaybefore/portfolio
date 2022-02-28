package kr.green.mytrip.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.green.mytrip.pagination.Criteria;
import kr.green.mytrip.pagination.PageMaker;
import kr.green.mytrip.service.BoardService;
import kr.green.mytrip.vo.BoardVO;
import kr.green.mytrip.vo.MemberVO;

@Controller
@RequestMapping(value = "/board")
public class BoardController {
	@Autowired
	BoardService boardService;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ModelAndView notice(ModelAndView mv, Criteria cri) {
		cri.setPerPageNum(5);
		List<BoardVO> boardList = boardService.getBoardList(cri);
		
		int totalCount = boardService.getTotalBoardCount();
		PageMaker pm = new PageMaker(totalCount, 2, cri);
		mv.addObject("list", boardList);
		mv.addObject("pm", pm);
		mv.setViewName("/board/list");
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
		if(!isInsert) {
			mv.setViewName("/board/register");
		}else {
			mv.setViewName("redirect:/board/list");
		}
		
		
		return mv;
	}
	
	//확인
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public ModelAndView boardDetailGet(ModelAndView mv, Integer bd_num) {
		BoardVO board = boardService.getBoard(bd_num);
		if(board==null) {
			mv.setViewName("redirece:/board/list");
		}else {
			mv.addObject("board", board);
			mv.setViewName("/board/detail");
		}
		
		return mv;
	}
	
}
