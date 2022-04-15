 package kr.green.mytrip.controller;


import java.io.FileInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.green.mytrip.service.MemberService;
import kr.green.mytrip.vo.MemberVO;
import kr.green.mytrip.vo.MiddleCategoryVO;
import kr.green.mytrip.vo.SpotMenuVO;

@Controller
public class HomeController {
	@Autowired
	MemberService memberService;

	//메인
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(ModelAndView mv, HttpServletRequest request) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		mv.addObject("user", user);
		mv.setViewName("main/main");
		return mv;
	}
	
	
	//로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView loginPost(ModelAndView mv, MemberVO input) {
		MemberVO user = memberService.loginMember(input);
		if(user == null) {
			mv.setViewName("redirect:/");
		}else{
			//회원의 사용자메뉴리스트 불러오기
			List<SpotMenuVO> menu = memberService.getMenuList(user.getMe_id());
			mv.setViewName("redirect:/spot/"+input.getMe_id()+"/home");
			mv.addObject("user", user);
			mv.addObject("menu", menu);
		}
		return mv;
	}
	
	
	//로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public ModelAndView logoutGet(ModelAndView mv, HttpServletRequest request) {
		request.getSession().removeAttribute("user");
		mv.setViewName("redirect:/");
		return mv;
	}
	
	//회원가입
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public ModelAndView signupGet(ModelAndView mv) {
		mv.setViewName("member/signup");
		return mv;
	}
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public ModelAndView signupPost(ModelAndView mv, MemberVO member) {
		boolean isSignup = memberService.insertMember(member);
		if(isSignup) {
			mv.setViewName("redirect:/");
		}else {
			mv.addObject("member", member);
			mv.setViewName("redirect:/signup");
		}
		
		return mv;
	}
	
	//mypage 회원정보
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public ModelAndView mypageGet(ModelAndView mv, HttpServletRequest request) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		String spot_user = (String)request.getSession().getAttribute("spot_user");
		List<SpotMenuVO> menuList = memberService.getMenuList(user.getMe_id());
		
		System.out.println("user"+user);
		if(!user.getMe_id().equals(spot_user))
			mv.setViewName("redirect:/spot/"+user.getMe_id()+"/home");
		else {
			mv.addObject("menuList", menuList);
			mv.setViewName("/member/mypage");
		}
		
		return mv;
	}
	@RequestMapping(value = "/mypage", method = RequestMethod.POST)
	public ModelAndView mypagePost(ModelAndView mv, HttpServletRequest request, MemberVO input,
			List<MultipartFile> file) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		System.out.println("mypage input : "+input);
		
		if(memberService.mypageUpdate(user, input, file)) {
			System.out.println("mypage update 성공");
			mv.setViewName("redirect:/mypage");
		}else {
			mv.setViewName("redirect:/mypage");
		}
		
		return mv;
	}
	
	//메뉴 보기/mypage/menuCategory
	@RequestMapping(value = "/MemberMenu", method = RequestMethod.GET)
	public ModelAndView menuView(ModelAndView mv, HttpServletRequest request) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		List<SpotMenuVO> menuList = memberService.getMenuList(user.getMe_id());
		mv.addObject("menuList", menuList);
		mv.setViewName("member/MemberMenu");
		return mv;
	}
	
	///mypage/menuCategory
	@ResponseBody
	@RequestMapping(value="/mypage/menuCategory", method = RequestMethod.GET)
	public Map<String, Object> menuCategoryGet(String userId){
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<SpotMenuVO> list = memberService.getMenuList(userId);
		System.out.println("list : "+list);
		map.put("list", list);
		return map;
	}
	
	//file upload
	@ResponseBody//리턴값이 직접적으로 화면에(요청한곳에) 가도록 해줌 
	@RequestMapping("/download")
	public ResponseEntity<byte[]> downloadFile(String fileName)throws Exception{
		//집
		String uploadPath = "E:\\2021\\portfolio\\member_profile";
		//학원
		//String uploadPath = "E:\\2021\\portfolio\\upload_file";
		
	    InputStream in = null;
	    //byte에 담아서 전송
	    ResponseEntity<byte[]> entity = null;
	    try{
	        String FormatName = fileName.substring(fileName.lastIndexOf(".")+1);
	        HttpHeaders headers = new HttpHeaders();
	        in = new FileInputStream(uploadPath+fileName);

	        fileName = fileName.substring(fileName.indexOf("_")+1);
	        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
	        headers.add("Content-Disposition",  "attachment; filename=\"" 
				+ new String(fileName.getBytes("UTF-8"), "ISO-8859-1")+"\"");
	        entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in),headers,HttpStatus.CREATED);
	    }catch(Exception e) {
	        e.printStackTrace();
	        entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
	    }finally {
	        in.close();
	    }
	    return entity;
	}
	
	@RequestMapping(value = "/find", method = RequestMethod.GET)
	public ModelAndView findMemberGet(ModelAndView mv) {
		mv.setViewName("member/find");
		return mv;
	}
	//id찾기
	@ResponseBody
	@RequestMapping(value = "/member/find/id", method=RequestMethod.POST)
	public String findIdPost(@RequestBody MemberVO member){
		System.out.println("find memeber : "+member);
		return memberService.findId(member);
	}
	//pw찾기
	@ResponseBody
	@RequestMapping(value = "/member/find/pw", method=RequestMethod.POST)
	public String findPwPost(@RequestBody MemberVO member){
		System.out.println("find memeber : "+member);
		return memberService.findPw(member);
	}
	
}