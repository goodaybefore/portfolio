package kr.green.mytrip.controller;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.green.mytrip.service.MemberService;
import kr.green.mytrip.vo.MemberVO;

@Controller
public class HomeController {
	@Autowired
	MemberService memberService;

	//메인
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(ModelAndView mv, HttpServletRequest request) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		mv.addObject("user", user);
		mv.setViewName("/main/main");
		return mv;
	}
	
	
	//로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView loginPost(ModelAndView mv, MemberVO input) {
		MemberVO user = memberService.loginMember(input);
		if(user == null) {
			mv.setViewName("redirect:/");
		}else{
			mv.setViewName("redirect:/myspot/home");
			mv.addObject("user", user);
		}
		return mv;
	}
	
	
	//회원가입
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public ModelAndView signupGet(ModelAndView mv) {
		mv.setViewName("/member/signup");
		return mv;
	}
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public ModelAndView signupPost(ModelAndView mv, MemberVO member) {
		boolean isSignup = memberService.insertMember(member);
		if(isSignup) {
			mv.setViewName("redirect:/");
		}else {
			mv.addObject("member", member);
			mv.setViewName("redirect:/signup");
		}
		
		return mv;
	}
	
	
	
}