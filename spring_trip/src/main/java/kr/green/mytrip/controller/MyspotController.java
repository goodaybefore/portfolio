package kr.green.mytrip.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.green.mytrip.service.TripService;
import kr.green.mytrip.vo.MemberVO;


@Controller
@RequestMapping(value = "/myspot")
public class MyspotController {
	@Autowired
	TripService tripService;
	
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public ModelAndView myspotHome(ModelAndView mv, HttpServletRequest request) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		mv.addObject("user", user);
		mv.setViewName("/myspot/home");
		return mv;
	}
	
	
	//여행지 등록(tripReg)
	@RequestMapping(value = "/tripReg", method = RequestMethod.GET)
	public ModelAndView tripReg(ModelAndView mv, HttpServletRequest request) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		mv.addObject("user", user); 
		mv.setViewName("/myspot/tripRegister");
		return mv;
	}
	
	//여행지(trip) 출력
	@RequestMapping(value = "/tripList", method = RequestMethod.GET)
	public ModelAndView tripList(ModelAndView mv, HttpServletRequest request) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		mv.addObject("user", user);
		mv.setViewName("/myspot/tripList");
		return mv;
	}
	
	
	
	
	

}
