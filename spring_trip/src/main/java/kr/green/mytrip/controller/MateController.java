package kr.green.mytrip.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.green.mytrip.service.MateService;
import kr.green.mytrip.vo.MemberVO;
import kr.green.mytrip.vo.TripmateVO;

@Controller
@RequestMapping(value="/spot/{spot_user}/tripmate")
public class MateController {
	@Autowired
	MateService mateService;
	@RequestMapping(value="/tripmateList", method = RequestMethod.GET)
	public ModelAndView friendListGet(ModelAndView mv, HttpServletRequest request ) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		if(user == null) {
			System.out.println("friendList's user == null");
			mv.setViewName("redirect:/");
		}else {
			List<TripmateVO> mateList = mateService.getMateList(user.getMe_id());
			mv.addObject("mateList", mateList);
			System.out.println("mateList : "+mateList);
			mv.setViewName("/tripmate/tripmateList");
		}
		
		return mv;
	}
	
	@RequestMapping(value="/tripmateRequest", method = RequestMethod.GET)
	public ModelAndView friendRequestGet(ModelAndView mv, HttpServletRequest request,
			@PathVariable(required=false, value="spot_user")String spot_user) {
		String isTripmate = (String)request.getSession().getAttribute("isTripmate");
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		
		if(!user.getMe_id().equals(spot_user)) mv.setViewName("redirect:/spot/"+user.getMe_id()+"/tripmate/tripmateRequest");
		else mv.setViewName("/tripmate/tripmateRequest");
		return mv;
	}
	
	@RequestMapping(value="/sendTripmateRequest", method = RequestMethod.POST)
	public ModelAndView friendRequestPost(ModelAndView mv, String spot_user, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		//tripmate 신청 insert 성공시
		if(mateService.requestTripmate(user.getMe_id(), spot_user) == "true") {
			out.println("<script>alert('트립메이트 신청이 완료되었습니다.');</script>");
		}else if(mateService.requestTripmate(user.getMe_id(), spot_user) == "duplicated") {
			out.println("<script>alert('트립메이트 수락 대기중입니다.');</script>");
		}else {
			out.println("<script>alert('트립메이트 신청 대상이 존재하지 않습니다.');</script>");
		}
		out.flush();
		mv.setViewName("/spot/home");
		return mv;
	}
	
}
