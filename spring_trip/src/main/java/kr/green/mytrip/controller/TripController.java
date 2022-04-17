package kr.green.mytrip.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.ParseException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.green.mytrip.pagination.Criteria;
import kr.green.mytrip.pagination.PageMaker;
import kr.green.mytrip.service.MemberService;
import kr.green.mytrip.service.TripService;
import kr.green.mytrip.vo.ActivityVO;
import kr.green.mytrip.vo.ChargeTripVO;
import kr.green.mytrip.vo.FileVO;
import kr.green.mytrip.vo.MemberVO;
import kr.green.mytrip.vo.MiddleCategoryVO;
import kr.green.mytrip.vo.SmallCategoryVO;
import kr.green.mytrip.vo.SpotMenuVO;
import kr.green.mytrip.vo.TripVO;


@Controller
@RequestMapping(value = "/spot")
public class TripController {
	@Autowired
	TripService tripService;
	@Autowired
	MemberService memberService;
	String[] managers = { "트립매니저", "트립서포터" };
	
	@GetMapping({"{spot_user}/home", "/home", "/{spot_user}"})
	public ModelAndView spotUserHome(@PathVariable(required=false, value="spot_user")String spot_user, ModelAndView mv,
			HttpServletRequest request) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		//spot_user의 여행목록가져오기
		List<String> points = tripService.getTripPoints(spot_user);
		points.removeAll(Arrays.asList("", null));
		//해당 유저의 trip 정보 가져오기 - spot user의 공개범위에 따라 현재 로그인한 user에게 보여줄 범위를 가져옴
		//tripService.getTripList(spot_user, user);
		mv.addObject("points", points);
		mv.addObject("user", user);
		mv.addObject("spot_user", spot_user);
		
		mv.setViewName("/spot/home");
		return mv;
	}
	
	//여행지 목록(trip List) 출력
	@GetMapping(value = "/{spot_user}/tripList/{sm_num}")
	public ModelAndView tripList(ModelAndView mv, HttpServletRequest request,
			@PathVariable(required=false, value="sm_num")Integer sm_num,
			@PathVariable(required=false, value="spot_user")String spot_user,
			Criteria cri) {
		
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		
		cri.setPerPageNum(5);
		List<TripVO> tripList = tripService.getTripList(user, spot_user, sm_num, cri);
		int totalCount = tripService.getTotalTripCount(cri, sm_num);
		PageMaker pm = new PageMaker(totalCount, 2, cri);
		
		mv.addObject("pm", pm);
		mv.addObject("tripList", tripList);
		
		mv.setViewName("/spot/tripList"); 
		return mv;
	}
	
	
	//여행지 등록(tripReg)
	@RequestMapping(value = "{spot_user}/tripRegister", method = RequestMethod.GET)
	public ModelAndView tripRegGet(ModelAndView mv, HttpServletRequest request, Integer reg_sm_num) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		List<SpotMenuVO> menu = (List<SpotMenuVO>)request.getSession().getAttribute("menu");
		System.out.println("Reg menuList : "+menu);
		mv.addObject("reg_sm_num", reg_sm_num);
		mv.setViewName("/spot/tripRegister");
		
		return mv;
	}
	
	//여행지 select box
	@ResponseBody
	@RequestMapping(value="{spot_user}/middlecategory", method = RequestMethod.GET)
	public Map<String, Object> middleCategoryGet(Integer lc_num){
		//Integer lc_num = 1;//large-category = '지역'
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<MiddleCategoryVO> list = tripService.selectMiddleCategory(lc_num);
		map.put("list", list);
		return map;
	}
	@ResponseBody
	@RequestMapping(value="{spot_user}/smallcategory", method = RequestMethod.GET)
	public Map<String, Object> smallCategoryGet(Integer sc_mc_num){
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<SmallCategoryVO> list = tripService.selectSmallCategory(sc_mc_num);
		map.put("list", list);
		return map;
	}
	public String[] dividePeroid(String period, String url) {
		String tr_dates[] = period.split(" ~ ");
		return tr_dates;
	}
	
	@RequestMapping(value = "{spot_user}/tripRegister", method = RequestMethod.POST)
	public ModelAndView tripRegPost(ModelAndView mv, HttpServletRequest request, TripVO trip, String from,
			Integer sc_num, Integer mc_num, List<MultipartFile> file) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		//여행기간(String)을 Date로 변환
		String tr_dates[] = from.split(" ~ ");
		try {
			trip.setTr_start_date_str(tr_dates[0]);
			//*****잘못입력되었을때 alert 출력하는거 넣고싶음 *****
			if(tr_dates.length < 1) mv.setViewName("redirect:/tripRegister");
			if(tr_dates.length == 1) trip.setTr_end_date_str(tr_dates[0]);
			if(tr_dates.length == 2) trip.setTr_end_date_str(tr_dates[1]);
			if(tr_dates.length>2) mv.setViewName("redirect:/tripRegister");
			
		} catch (ParseException e) {
			System.out.println("tripReg에서의 period 변환 문제");
			e.printStackTrace();
		}
		if(tripService.insertTrip(user, trip, file, mc_num, sc_num)) {
			mv.setViewName("redirect:/spot/"+user.getMe_id()+"/tripList/"+trip.getTr_sm_num());
		}else {
			//***** 비정상적인 접근입니다 하는 alert 경고창 넣을 수 없나? *****
			mv.setViewName("redirect:/spot/tripRegister");
		}
		return mv;
	}
	//file upload
	@ResponseBody//리턴값이 직접적으로 화면에(요청한곳에) 가도록 해줌 
	@RequestMapping("/download")
	public ResponseEntity<byte[]> downloadFile(String fileName)throws Exception{
		//집
//		String uploadPath = "C:\\Users\\tsj02\\Documents\\java_gny\\upload";
		//학원
		String uploadPath = "E:\\2021\\portfolio\\upload_file";
		
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
	
	//여행지(trip) 상세(detail)
	@GetMapping("/{spot_user}/tripDetail/{reg_sm_num}/{tr_num}")
	public ModelAndView tripDetail(ModelAndView mv, HttpServletRequest request,
			@PathVariable(required=false, value="reg_sm_num")Integer reg_sm_num,
			@PathVariable(required=false, value="spot_user")String spot_user,
			@PathVariable(required=false, value="tr_num")Integer tr_num,
			Criteria cri) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		TripVO trip = tripService.getTripDetail(tr_num);
		List<FileVO> fileList = tripService.getFileList(tr_num);
		boolean isPurchased = false;
		
		//해당 trip의 activity 주소들을 모두 불러오기
		List<String> actAddressList = tripService.getActAddressList(tr_num);
		System.out.println("actAddressList : "+actAddressList);
		//trip 글쓴이의 등급 확인
		String userGrade = tripService.getUserGrade(trip.getTr_me_id());
		boolean isManager = false;
		for(String tmp : managers) {
			if(userGrade.equals(tmp)) isManager = true;
		}
		if(isManager) {//해당여행에 현재 로그인한 사용자가 결제했는지 확인
			//결제했으면 isPurchase를 리턴
			isPurchased = tripService.checkTripPurchase(tr_num, user.getMe_id());
		}
		
		//pagination
		cri.setPerPageNum(5);
		int totalCount = tripService.getTotalActivityCount(cri, trip.getTr_num());
		//활동 (activity) 불러오기 및 출력
		List<ActivityVO> actList = tripService.getActList(tr_num, cri);
		PageMaker pm = new PageMaker(totalCount, 2, cri);
		mv.addObject("pm", pm);
		
		mv.addObject("actList", actList);
		mv.addObject("trip", trip);
		mv.addObject("fileList", fileList);
		mv.addObject("isManager", isManager);
		mv.addObject("isPurchased", isPurchased);
		mv.addObject("acAdList", actAddressList);
		mv.setViewName("/spot/tripDetail");
		return mv;
	}
	
	//여행지(trip) 수정(modify)
	@RequestMapping(value = "/{spot_user}/tripModify", method = RequestMethod.GET)
	public ModelAndView tripModifyGet(ModelAndView mv, HttpServletRequest request, Integer tr_num) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		String spot_user =  (String)request.getSession().getAttribute("spot_user");
		TripVO trip = tripService.getTripDetail(tr_num);
		
		if(trip == null) {
			mv.setViewName("redirect:/spot/"+user.getMe_id()+"/tripModify");
			
		}else {
			//file modify
			List<FileVO> fileList = tripService.getFileList(tr_num);
			
			//중분류, 소분류의 primary key 찾기
			Integer sc_num = 0;
			Integer mc_num = 0;
			if(trip.getTr_sca_name()!=null) 
				//sca_name의 sc_num을 찾기
				//SELECT sc_num FROM small_category WHERE sc_num = #{tr_sca_name};
				sc_num = tripService.getScaNum(trip.getTr_sca_name());
			mc_num = tripService.getMcaNum(trip.getTr_mca_name());
			
			mv.addObject("sc_num", sc_num);
			mv.addObject("mc_num", mc_num);
			mv.addObject("fileList", fileList);
			mv.addObject("trip", trip);
			mv.setViewName("/spot/tripModify");
		}
		return mv;
	}
	@RequestMapping(value = "{spot_user}/tripModify", method = RequestMethod.POST)
	public ModelAndView tripModifyPost(ModelAndView mv, HttpServletRequest request, TripVO trip,
			List<MultipartFile> file, Integer[] fileNums, Integer mc_num, Integer sc_num, String from) {
		if(fileNums != null) {
			for(Integer tmp : fileNums)
				System.out.println(tmp);
		}
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		String spot_user =  (String)request.getSession().getAttribute("spot_user");
		//날짜
		String tr_dates[] = from.split(" ~ ");
		try {
			trip.setTr_start_date_str(tr_dates[0]);
			//*****잘못입력되었을때 alert 출력하는거 넣고싶음 *****
			if(tr_dates.length < 1) mv.setViewName("redirect:/tripRegister");
			if(tr_dates.length == 1) trip.setTr_end_date_str(tr_dates[0]);
			if(tr_dates.length == 2) trip.setTr_end_date_str(tr_dates[1]);
			if(tr_dates.length>2) mv.setViewName("redirect:/tripRegister");
			
		} catch (ParseException e) {
			System.out.println("tripReg에서의 period 변환 문제");
			e.printStackTrace();
		}
		
		if(tripService.modifyTrip(trip, file, fileNums, mc_num, sc_num)) {
			System.out.println("modify success");
			mv.setViewName("redirect:/spot/"+spot_user+"/tripList/"+trip.getTr_sm_num());
		}else {
			mv.setViewName("/spot/tripModify");
			
			
		}
		
		return mv;
	}
	
	
	//여행지 삭제(delete)
	@RequestMapping(value = "/{spot_user}/tripDelete", method = RequestMethod.GET)
	public ModelAndView tripDelete(ModelAndView mv, HttpServletRequest request, Integer tr_num,
			@PathVariable(required=false, value="spot_user")String spot_user) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		System.out.println("delete user : "+user);
		TripVO dbTrip = tripService.selectTrip(tr_num);

		if(tripService.deleteTrip(user, dbTrip)){
			System.out.println("삭제성공");
			mv.setViewName("redirect:/spot/"+spot_user+"/tripList/"+dbTrip.getTr_sm_num());
		}else {
			mv.setViewName("redirect:/spot/"+spot_user+"/tripDetail/"+dbTrip.getTr_sm_num()+"/"+dbTrip.getTr_num());
		}
		
		return mv;
	}
	
	//tripcopy 새창
	@RequestMapping(value="/{spot_user}/tripDetail/{sm_num}/selectMenuCategory")
	public ModelAndView tripCopySelectInsertMenu(ModelAndView mv, HttpServletRequest request,
			@PathVariable(required=false, value="sm_num")String sm_num, Integer tr_num) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		//내 여행 메뉴리스트 불러와서 출력
		List<SpotMenuVO> menuList = tripService.getUserMenu(user.getMe_id());
		System.out.println("menuList : "+menuList);
		mv.addObject("sm_num", sm_num);
		mv.setViewName("spot/tripCopySelectMenu");
		return mv;
	}
	
	@ResponseBody//여기서 menu리스트 받아오는 ajax동작을 
	@RequestMapping(value="/{userId}/menuCategory", method = RequestMethod.GET)
	public Map<String, Object> menuCategoryGet(String userId){
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<SpotMenuVO> menuList = tripService.getUserMenu(userId);
		map.put("menuList", menuList); 
		return map;
	}
	
	
	
	@RequestMapping(value="/{spot_user}/tripDetail/{sm_num}/selectMenuCategory", method = RequestMethod.POST)
	public ModelAndView tripCopySelectInsertMenuPost(ModelAndView mv, HttpServletRequest request, Integer sm_num,
			Integer tr_num,	HttpServletResponse response, Integer copy_sm_num) throws IOException {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		TripVO copyTrip = tripService.getTripDetail(tr_num);

		//jsp 파일에 script를 쓰기 위한 초석작업
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		// 공개범위에 따라 copy 제한 걸어줘야함.. 아직 공개범위 설정 안했음
		if(copyTrip==null || copyTrip.getTr_op_name().equals("비공개")) {
			System.out.println("비어있음");
			out.println("<script>alert('가져올 수 없는 여행입니다.');");
		}else if(copy_sm_num == null) {//복사해서 저장할 메뉴를 선택하지 않은 경우
			out.println("<script>alert('메뉴를 선택해주세요.');</script>");
			out.flush();
			mv.addObject("sm_num", sm_num);
			mv.setViewName("spot/tripCopySelectMenu");
			return mv;
		}else {
			if(tripService.copyTrip(user.getMe_id(), tr_num, copy_sm_num)) {
				out.println("<script>alert('여행 가져오기가 완료되었습니다.\\n첨부파일과 활동사진은 저장되지 않습니다.');");
			}else {
				out.println("<script>alert('여행 가져오기에 실패했습니다. 다시 시도해주세요');");
			}
			
		}
		
		out.println("window.close();</script>");
		out.flush();
		mv.setViewName("spot/tripCopySelectMenu");
		return mv;
	}
	
	//결제 내역 추가하기
	@ResponseBody
	@RequestMapping(value="{spot_user}/chargeRecord")
	public Map<String, Object> chargeRecord(@RequestBody ChargeTripVO chargeTrip, HttpServletRequest request){
		HashMap<String, Object> map = new HashMap<String, Object>();
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		chargeTrip.setCh_me_id(user.getMe_id());
		System.out.println("charged : "+chargeTrip);
		//chargeTrip에 insert
		if(tripService.insertChargeRecord(chargeTrip)) {
			map.put("result", "ok");
		}else {
			map.put("result", "failed");
		}
		return map;
	}
	
	
//	
//	//여행지 가져오기(copy) At tripDetail
//	@RequestMapping(value="/{spot_user}/tripCopy", method = RequestMethod.GET)
//	public ModelAndView tripCopyGet(ModelAndView mv, HttpServletRequest request, Integer tr_num,
//			@PathVariable(required=false, value="spot_user")String spot_user,
//			HttpServletResponse response) throws IOException {
//		//해당 여행번호 가져오기
//		TripVO copyTrip = tripService.getTripDetail(tr_num);
//		
//		/* user확인
//			=> 회원본인-회원본인인 경우 copy 안되게해야함
//			=> 되는경우 : (회원-관리자)(결제후가능) / (트립메이트-트립메이트)
//			일단 나중에 검사하는걸로 하고 지금은 일단 대충 user != null user!=user로 하자 
//		*/
//		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
//		String resultStr="";
//		if(tripService.copyTrip(user, tr_num)) {
//			System.out.println("가져오기완료");
//			resultStr = "가져오기를 완료했습니다";
//		}else {
//			//tripDetail을 setviewName
//			System.out.println("가져오기실패");
//			resultStr = "가져오기를 실패하였습니다.";
//		}
//		response.setContentType("text/html; charset=utf-8");
//		response.setCharacterEncoding("utf-8");
//		PrintWriter out = response.getWriter();
//		out.println("<script>alert('"+resultStr+"');</script>");
//		mv.setViewName("redirect:/spot/"+spot_user+"/tripDetail/"+copyTrip.getTr_sm_num()+"/"+copyTrip.getTr_num());
//		
//		return mv;
//	}
	

}
