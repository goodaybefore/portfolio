package kr.green.mytrip.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.green.mytrip.vo.MemberVO;

@Controller
@RequestMapping(value = "/activity")
public class ActivityController {

	
	@GetMapping({"{spot_user}/home", "/home"})
	public ModelAndView spotUserHome(@PathVariable(required=false, value="spot_user")String spot_user, ModelAndView mv,
			HttpServletRequest request) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		
		mv.addObject("spot_user", spot_user);
		mv.setViewName("/spot/home");
		return mv;
	}
}
