package kr.green.mytrip.controller;

import java.text.ParseException;
import java.util.Arrays;
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
import kr.green.mytrip.vo.MiddleCategoryVO;
import kr.green.mytrip.vo.SmallCategoryVO;
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
		mv.addObject("user", user); 
		mv.setViewName("/myspot/tripRegister");
		
		return mv;
	}
	
	//여행지 select box
	@ResponseBody
	@RequestMapping(value="/middlecategory", method = RequestMethod.GET)
	public Map<String, Object> middleCategoryGet(){
		Integer lc_num = 1;//large-category = '지역'
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<MiddleCategoryVO> list = tripService.selectMiddleCategory(lc_num);
		map.put("list", list);
		return map;
	}
	@ResponseBody
	@RequestMapping(value="/smallcategory", method = RequestMethod.GET)
	public Map<String, Object> smallCategoryGet(Integer sc_mc_num){
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<SmallCategoryVO> list = tripService.selectSmallCategory(sc_mc_num);
		map.put("list", list);
		return map;
	}
	
	@RequestMapping(value = "/tripReg", method = RequestMethod.POST)
	public ModelAndView tripRegPost(ModelAndView mv, HttpServletRequest request, TripVO trip, String from, Integer sc_num, Integer mc_num) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		//여행기간(String)을 Date로 변환
		String tr_dates[] = from.split(" ~ ");
		try {
			trip.setTr_start_date_str(tr_dates[0]);
			System.out.println("tr_dates.length : "+tr_dates.length);
			//*****잘못입력되었을때 alert 출력하는거 넣고싶음 *****
			if(tr_dates.length < 1) mv.setViewName("redirect:/tripRegister");
			if(tr_dates.length == 1) trip.setTr_end_date_str(tr_dates[0]);
			if(tr_dates.length == 2) trip.setTr_end_date_str(tr_dates[1]);
			if(tr_dates.length>2) mv.setViewName("redirect:/tripRegister");
			
			
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
