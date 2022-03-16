package kr.green.mytrip.controller;

import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.green.mytrip.service.TripService;
import kr.green.mytrip.vo.ActivityVO;
import kr.green.mytrip.vo.MemberVO;
import kr.green.mytrip.vo.TripVO;

@Controller
@RequestMapping(value = "/spot/{spot_user}")
public class ActivityController {
	
	@Autowired
	TripService tripService;
	
	//활동 등록(activity Reg)
	@RequestMapping(value = "/activityReg", method = RequestMethod.GET)
	public ModelAndView tripRegGet(ModelAndView mv, HttpServletRequest request, Integer tr_num) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		String spot_user = (String)request.getSession().getAttribute("spot_user");
		if(user == null || !user.getMe_id().equals(spot_user)) mv.setViewName("redirect:/");
		else {
			TripVO trip = tripService.selectTrip(tr_num);
			mv.addObject("trip", trip);
			mv.setViewName("/activity/activityRegister");
		}
		
		return mv;
	}
	@RequestMapping(value = "/activityReg", method = RequestMethod.POST)
	public ModelAndView tripRegPost(ModelAndView mv, HttpServletRequest request, ActivityVO activity, String from,
			Integer mc_num, Integer sc_num, Integer reg_sm_num) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		String spot_user = (String)request.getSession().getAttribute("spot_user");
		System.out.println("reg_sm_num : "+reg_sm_num);
		
		//여행기간(String)을 Date로 변환
		String tr_dates[] = from.split(" ~ ");
		try {
			activity.setAc_start_date_str(tr_dates[0]);
			//*****잘못입력되었을때 alert 출력하는거 넣고싶음 *****
			if(tr_dates.length < 1) mv.setViewName("redirect:/tripRegister");
			if(tr_dates.length == 1) activity.setAc_end_date_str(tr_dates[0]);
			if(tr_dates.length == 2) activity.setAc_end_date_str(tr_dates[1]);
			if(tr_dates.length>2) mv.setViewName("redirect:/tripRegister");
		} catch (ParseException e) {
			System.out.println("activity Reg에서의 period 변환 문제");
			e.printStackTrace();
		}
		if(tripService.insertActivity(activity, mc_num, sc_num)) {
			System.out.println("insert 성공");
			mv.setViewName("redirect:/spot/"+spot_user+"/tripDetail/"+reg_sm_num+"/"+activity.getAc_tr_num());
		}else {
			System.out.println("insert 실패");
			mv.setViewName("/activity/activityRegister");
		}
		
		
		
		return mv;
	}
	
}
