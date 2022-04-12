package kr.green.mytrip.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value="/{spot_user}/tripmate")
public class MateController {
	
	//@RequestGetMapping(value="/friendRequest", method = RequestMethod.GET)
	@RequestMapping(value="/friendList", method = RequestMethod.GET)
	public ModelAndView friendListGet(ModelAndView mv ) {
		
		mv.setViewName("/tripmate/tripmateList");
		return mv;
	}
}
