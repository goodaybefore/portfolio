package kr.green.mytrip.controller;

import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.green.mytrip.service.TripService;
import kr.green.mytrip.vo.MemberVO;
import kr.green.mytrip.vo.TripVO;


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
	public ModelAndView tripRegGet(ModelAndView mv, HttpServletRequest request) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		//List<String> ;
		mv.addObject("user", user); 
		mv.setViewName("/myspot/tripRegister");
		
		return mv;
	}
	
	//여행지 select box
	@ResponseBody
	@RequestMapping(value="/middlecategory", method = RequestMethod.GET)
	public Map<String, Object> middleCategoryGet(){
		HashMap<String, Object> map = new HashMap<String, Object>();
		return map;
	}
	@ResponseBody
	@RequestMapping(value="/smallcategory", method = RequestMethod.GET)
	public Map<String, Object> smallCategoryGet(){
		HashMap<String, Object> map = new HashMap<String, Object>();
		return map;
	}
	
	@RequestMapping(value = "/tripReg", method = RequestMethod.POST)
	public ModelAndView tripRegPost(ModelAndView mv, HttpServletRequest request, TripVO trip, String from) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		
		//여행기간(String)을 Date로 변환
		String tr_dates[] = from.split(" ~ ");
		try {
			trip.setTr_start_date_str(tr_dates[0]);
			trip.setTr_end_date_str(tr_dates[1]);
		} catch (ParseException e) {
			System.out.println("tripReg에서의 period 변환 문제");
			e.printStackTrace();
		}
		
		boolean isRegSuccess = tripService.insertTrip(user, trip);
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
