package kr.green.mytrip.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	//@RequestGetMapping(value="/friendRequest", method = RequestMethod.GET)
	@RequestMapping(value="/friendList", method = RequestMethod.GET)
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
}
