package kr.green.mytrip.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.green.mytrip.vo.MemberVO;


public class LoginSessionInterceptor extends HandlerInterceptorAdapter {
	@Override
	public void postHandle(
	    HttpServletRequest request, 
	    HttpServletResponse response, 
	    Object handler, 
	    ModelAndView modelAndView)
	    throws Exception {
	    ModelMap modelMap = modelAndView.getModelMap();
	    MemberVO user = (MemberVO)modelMap.get("user");
	    Object menu = (Object)modelMap.get("menu");
	    System.out.println("user : "+user);
	    if(user != null) {
	        HttpSession session = request.getSession();
	        session.setAttribute("user", user);
	        session.setAttribute("menu", menu);
	    }
	}
}
