 package kr.green.mytrip.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.green.mytrip.service.MemberService;
import kr.green.mytrip.vo.MemberVO;
import kr.green.mytrip.vo.SpotMenuVO;

@Controller
public class HomeController {
	@Autowired
	MemberService memberService;

	//메인
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(ModelAndView mv, HttpServletRequest request) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		mv.addObject("user", user);
		mv.setViewName("main/main");
		return mv;
	}
	
	
	//로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView loginPost(ModelAndView mv, MemberVO input) {
		MemberVO user = memberService.loginMember(input);
		if(user == null) {
			mv.setViewName("redirect:/board/list");
		}else{
			//회원의 사용자메뉴리스트 불러오기
			List<SpotMenuVO> menu = memberService.getMenuList(user.getMe_id());
			mv.setViewName("redirect:/spot/"+input.getMe_id()+"/home");
			mv.addObject("user", user);
			mv.addObject("menu", menu);
		}
		return mv;
	}
	
	
	//로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public ModelAndView logoutGet(ModelAndView mv, HttpServletRequest request) {
		request.getSession().removeAttribute("user");
		mv.setViewName("redirect:/");
		return mv;
	}
	
	//회원가입
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public ModelAndView signupGet(ModelAndView mv) {
		mv.setViewName("member/signup");
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
	
	//mypage 회원정보
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public ModelAndView mypageGet(ModelAndView mv, HttpServletRequest request) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		mv.addObject("user", user);
		mv.setViewName("/member/mypage");
		return mv;
	}
	
	
	
}