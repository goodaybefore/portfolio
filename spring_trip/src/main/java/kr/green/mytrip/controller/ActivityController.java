package kr.green.mytrip.controller;

import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
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
	public ModelAndView activityRegGet(ModelAndView mv, HttpServletRequest request, Integer tr_num) {
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
	public ModelAndView activityRegPost(ModelAndView mv, HttpServletRequest request, ActivityVO activity, String from,
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
	
	//활동 상세(activity Detail)
	@RequestMapping(value = "/activityDetail/{sm_num}/{reg_tr_num}/{ac_num}", method = RequestMethod.GET)
	public ModelAndView activityDetailGet(ModelAndView mv, HttpServletRequest request, Integer tr_num,
			@PathVariable(required=false, value="ac_num")Integer ac_num,
			@PathVariable(required=false, value="reg_tr_num")Integer reg_tr_num,
			@PathVariable(required=false, value="sm_num")Integer sm_num) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		String spot_user = (String)request.getSession().getAttribute("spot_user");
		
		ActivityVO active = tripService.selectActivity(ac_num);
		if(active == null) {
			System.out.println("activity load fail");
			mv.setViewName("redirect:/spot/"+spot_user+"/tripDetail/"+sm_num+"/"+reg_tr_num);
		}else {
			mv.addObject("activity", active);
			mv.setViewName("/activity/activityDetail");
		}
		
		return mv;
	}
	
	//활동 수정(activity Modify)
	@RequestMapping(value = "/activityMod", method = RequestMethod.GET)
	public ModelAndView activityModifyGet(ModelAndView mv, HttpServletRequest request, Integer ac_num) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		String spot_user = (String)request.getSession().getAttribute("spot_user");
		ActivityVO activity = tripService.selectActivity(ac_num);
		Integer sc_num = 0;
		Integer mc_num = 0;

		//sm_num 가져오기
		Integer reg_sm_num = tripService.getSmNum(activity.getAc_tr_num());
		
		
		if(user == null || !user.getMe_id().equals(spot_user)|| !activity.getAc_me_id().equals(user.getMe_id())) mv.setViewName("redirect:/");
		else {
			sc_num = tripService.getScaNum(activity.getAc_sca_name());
			mc_num = tripService.getMcaNum(activity.getAc_mca_name());
			mv.addObject("mc_num", mc_num);
			mv.addObject("sc_num", sc_num);
			mv.addObject("ac_num", ac_num);
			mv.addObject("reg_sm_num", reg_sm_num);
			mv.addObject("activity", activity);
			mv.setViewName("/activity/activityModify");
		}
		return mv;
	}
	
	//활동 수정(activity Modify)
		@RequestMapping(value = "/activityMod", method = RequestMethod.POST)
		public ModelAndView activityModifyPost(ModelAndView mv, HttpServletRequest request, ActivityVO activity,
				Integer ac_num, String from, Integer mc_num, Integer sc_num, Integer reg_sm_num) {
			MemberVO user = (MemberVO)request.getSession().getAttribute("user");
			String spot_user = (String)request.getSession().getAttribute("spot_user");
			
			//여행기간(String)을 Date로 변환
			String tr_dates[] = from.split(" ~ ");
			try {
				activity.setAc_start_date_str(tr_dates[0]);
				//*****잘못입력되었을때 alert 출력하는거 넣고싶음 *****
				if(tr_dates.length < 1) mv.setViewName("redirect:/spot/"+spot_user+"/activityMod?ac_num="+ac_num);
				if(tr_dates.length == 1) activity.setAc_end_date_str(tr_dates[0]);
				if(tr_dates.length == 2) activity.setAc_end_date_str(tr_dates[1]);
				if(tr_dates.length>2) mv.setViewName("redirect:/spot/"+spot_user+"/activityMod?ac_num="+ac_num);
			} catch (ParseException e) {
				System.out.println("activity Reg에서의 period 변환 문제");
				e.printStackTrace();
			}
			if(tripService.modifyActivity(activity, mc_num, sc_num, user)) {
				System.out.println("수정 성공");
				mv.setViewName("redirect:/spot/"+spot_user+"/tripDetail/"+reg_sm_num+"/"+activity.getAc_tr_num());
			}else {
				System.out.println("수정 실패");
				mv.setViewName("redirect:/spot/"+spot_user+"/activityMod?ac_num="+ac_num);
			}
			
			return mv;
		}
	
}
