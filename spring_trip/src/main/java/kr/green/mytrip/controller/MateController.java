package kr.green.mytrip.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.green.mytrip.service.MateService;
import kr.green.mytrip.vo.MemberVO;
import kr.green.mytrip.vo.TripmateVO;

@Controller
@RequestMapping(value="/spot/{spot_user}/tripmate")
public class MateController {
	@Autowired
	MateService mateService;
	@RequestMapping(value="/tripmateList", method = RequestMethod.GET)
	public ModelAndView friendListGet(ModelAndView mv, HttpServletRequest request ) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		if(user == null) {
			System.out.println("friendList's user == null");
			mv.setViewName("redirect:/");
		}else {
			List<TripmateVO> mateList = mateService.getMateList(user.getMe_id());
			mv.addObject("mateList", mateList);
			System.out.println("mateList : "+mateList);
			mv.setViewName("/tripmate/tripmateList");
		}
		
		return mv;
	}
	
	@RequestMapping(value="/tripmateRequest", method = RequestMethod.GET)
	public ModelAndView friendRequestGet(ModelAndView mv, HttpServletRequest request,
			@PathVariable(required=false, value="spot_user")String spot_user) {
		String isTripmate = (String)request.getSession().getAttribute("isTripmate");
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		
		if(!user.getMe_id().equals(spot_user)) mv.setViewName("redirect:/spot/"+user.getMe_id()+"/tripmate/tripmateRequest");
		else mv.setViewName("/tripmate/tripmateRequest");
		return mv;
	}
	
}
