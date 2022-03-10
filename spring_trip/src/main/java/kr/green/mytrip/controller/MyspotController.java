package kr.green.mytrip.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.green.mytrip.pagination.Criteria;
import kr.green.mytrip.service.TripService;
import kr.green.mytrip.vo.MemberVO;

@Controller
@RequestMapping(value = "/myspot")
public class MyspotController {
	@Autowired
	TripService tripService;
	
	//myspot home
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public ModelAndView myspotHome(ModelAndView mv, HttpServletRequest request) {
		mv.setViewName("/spot /home");
		return mv;
	}
	
	//myspot tripList
	@RequestMapping(value = "/tripList", method = RequestMethod.GET)
	public ModelAndView myspotTripList(ModelAndView mv, HttpServletRequest request, Criteria cri) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		System.out.println(user);
		mv.setViewName("/spot/tripList");
		return mv;
	}
	
	
}
