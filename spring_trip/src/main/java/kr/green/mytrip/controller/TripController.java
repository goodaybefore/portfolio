package kr.green.mytrip.controller;

import java.io.FileInputStream;
import java.io.InputStream;
import java.text.ParseException;
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
	
	@GetMapping({"{spot_user}/home", "/home", "/{spot_user}"})
	public ModelAndView spotUserHome(@PathVariable(required=false, value="spot_user")String spot_user, ModelAndView mv,
			HttpServletRequest request) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		//해당 유저의 trip 정보 가져오기 - spot user의 공개범위에 따라 현재 로그인한 user에게 보여줄 범위를 가져옴
		//tripService.getTripList(spot_user, user);

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
		mv.addObject("sm_num", sm_num);//사용자메뉴번호
		
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
	@RequestMapping(value = "/tripDelete", method = RequestMethod.GET)
	public ModelAndView tripDelete(ModelAndView mv, HttpServletRequest request, Integer tr_num) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		System.out.println();
		TripVO dbTrip = tripService.selectTrip(tr_num);

		if(tripService.deleteTrip(user, dbTrip)){
			System.out.println("삭제성공");
			mv.setViewName("redirect:/"+user.getMe_id()+"/tripList/"+dbTrip.getTr_sm_num());
		}else {
			mv.setViewName("redirect:/"+user.getMe_id()+"/tripDetail/"+dbTrip.getTr_sm_num()+"/"+dbTrip.getTr_num());
		}
		
		return mv;
	}
	
	
	//여행지 가져오기(copy) At tripDetail
	@RequestMapping(value="/{spot_user}/tripCopy", method = RequestMethod.GET)
	public ModelAndView tripCopyGet(ModelAndView mv, HttpServletRequest request, Integer tr_num,
			@PathVariable(required=false, value="spot_user")String spot_user) {
		//해당 여행번호 가져오기
		
		/* user확인
			=> 회원본인-회원본인인 경우 copy 안되게해야함
			=> 되는경우 : (회원-관리자)(결제후가능) / (트립메이트-트립메이트)
			일단 나중에 검사하는걸로 하고 지금은 일단 대충 user != null user!=user로 하자 
		*/
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		
		if(tripService.copyTrip(user, tr_num)) {
			System.out.println("가져오기완료");
			//tripList를 setviewname해조야함
		}else {
			//tripDetail을 setviewName
			System.out.println("가져오기실패");
		}
		return mv;
	}
	

}
