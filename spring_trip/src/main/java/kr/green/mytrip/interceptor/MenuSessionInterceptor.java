package kr.green.mytrip.interceptor;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import kr.green.mytrip.service.MemberService;
import kr.green.mytrip.vo.MemberVO;
import kr.green.mytrip.vo.SpotMenuVO;

public class MenuSessionInterceptor extends HandlerInterceptorAdapter{
	@Autowired
	MemberService memberService;
	@Override
	public boolean preHandle(HttpServletRequest request, 
			HttpServletResponse response, 
			Object handler)
			throws Exception {
		
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		String[] url = request.getServletPath().split("/");
		
		System.out.println("현재 url : "+Arrays.toString(url));
		System.out.println("url[1] : "+url[1]+"\nurl.length : "+url.length);
		List<SpotMenuVO> menuList = null;
		String thisUser = null;
		//mypage
		if(url[1].equals("mypage") && url.length == 2) {
			if(user == null) {//접근을 시도하는 사용자가 guest login인 경우
				response.sendRedirect(request.getContextPath()+"/");
				return false;
			}
			menuList = memberService.getMenuList(user.getMe_id());
		}
		//'/spot/(~~)' 형식
		else if(!url[2].isEmpty() && url[1].equals("spot")) {
			thisUser = url[2];
			menuList = memberService.getMenuList(thisUser);
		}
		
		if(thisUser == null) {
			System.out.println("<MenuSession>\nthisUser == null!");
		}
		
		if(menuList.isEmpty()) {//menuList에 아무것도 없을 때
			System.out.println("menu list가 empty : "+menuList);
			if(user == null) {//접근을 시도하는 사용자가 guest login인 경우
				response.sendRedirect(request.getContextPath()+"/");
				return false;
			}
			//menuList가 비어있고 접근시도중인 사용자가 login 되어있는 경우 => 본인의 spot으로 이동
			menuList = memberService.getMenuList(user.getMe_id());
			//session에 본인 spot 추가
			HttpSession session = request.getSession();
			session.setAttribute("menu", menuList);
			session.setAttribute("spot_user", user.getMe_id());
			
			//본인 spot home으로 redirect
			response.sendRedirect(request.getContextPath()+"/spot/"+user.getMe_id());
			return false;
			}else {
			
			HttpSession session = request.getSession();
			session.setAttribute("menu", menuList);
			session.setAttribute("spot_user", thisUser);
			
			return true;
		}
	}
}
