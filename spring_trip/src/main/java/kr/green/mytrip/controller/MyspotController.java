package kr.green.mytrip.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping(value = "/myspot")
public class MyspotController {
	
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public ModelAndView myspotHome(ModelAndView mv) {
		mv.setViewName("/myspot/home");
		return mv;
	}

}
