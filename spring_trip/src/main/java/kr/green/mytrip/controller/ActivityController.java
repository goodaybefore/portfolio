package kr.green.mytrip.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.green.mytrip.vo.MemberVO;

@Controller
@RequestMapping(value = "/spot/{spot_user}")
public class ActivityController {
	//활동 등록(activity Reg)
	@RequestMapping(value = "/activityReg", method = RequestMethod.GET)
	public ModelAndView tripRegGet(ModelAndView mv, HttpServletRequest request, Integer tr_num) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		
		mv.setViewName("/activity/activityRegister");
		
		return mv;
	}
	
}
