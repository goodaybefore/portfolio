package kr.green.mytrip.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.green.mytrip.vo.MemberVO;


@Controller
@RequestMapping(value = "/myspot")
public class MyspotController {
	
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public ModelAndView myspotHome(ModelAndView mv, HttpServletRequest request) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		System.out.println("myspot home session : "+user);
		mv.setViewName("/myspot/home");
		return mv;
	}

}
