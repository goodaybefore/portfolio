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
import kr.green.mytrip.service.TripService;
import kr.green.mytrip.vo.FileVO;
import kr.green.mytrip.vo.MemberVO;
import kr.green.mytrip.vo.MiddleCategoryVO;
import kr.green.mytrip.vo.SmallCategoryVO;
import kr.green.mytrip.vo.SpotMenuVO;
import kr.green.mytrip.vo.TripVO;


@Controller
@RequestMapping(value = "/spot")
public class SpotController {
	@Autowired
	TripService tripService;
	
	@GetMapping({"{spot_user}/home", "/home"})
	public ModelAndView spotUserHome(@PathVariable(required=false, value="spot_user")String spot_user, ModelAndView mv,
			HttpServletRequest request) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		//해당 유저의 trip 정보 가져오기 - spot user의 공개범위에 따라 현재 로그인한 user에게 보여줄 범위를 가져옴
		//tripService.getTripList(spot_user, user);
		
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
//		if(spot_user == user.getMe_id()) {
//			
//		}
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
	@RequestMapping(value = "/tripRegister", method = RequestMethod.GET)
	public ModelAndView tripRegGet(ModelAndView mv, HttpServletRequest request, Integer reg_sm_num) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		//List<SpotMenuVO> menu = (List<SpotMenuVO>)request.getSession().getAttribute("menu");
		mv.addObject("reg_sm_num", reg_sm_num);
		mv.setViewName("/spot/tripRegister");
		
		return mv;
	}
	
	//여행지 select box
	@ResponseBody
	@RequestMapping(value="/middlecategory", method = RequestMethod.GET)
	public Map<String, Object> middleCategoryGet(){
		Integer lc_num = 1;//large-category = '지역'
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<MiddleCategoryVO> list = tripService.selectMiddleCategory(lc_num);
		map.put("list", list);
		return map;
	}
	@ResponseBody
	@RequestMapping(value="/smallcategory", method = RequestMethod.GET)
	public Map<String, Object> smallCategoryGet(Integer sc_mc_num){
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<SmallCategoryVO> list = tripService.selectSmallCategory(sc_mc_num);
		map.put("list", list);
		return map;
	}
	
	@RequestMapping(value = "/tripRegister", method = RequestMethod.POST)
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
			mv.setViewName("redirect:/spot/"+user.getMe_id()+"/tripList/1");
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
	
	@GetMapping("/{spot_user}/tripDetail/{sm_num}/{tr_num}")
	public ModelAndView tripDetail(ModelAndView mv, HttpServletRequest request,
			@PathVariable(required=false, value="sm_num")Integer sm_num,
			@PathVariable(required=false, value="spot_user")String spot_user,
			@PathVariable(required=false, value="tr_num")Integer tr_num) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		TripVO trip = tripService.getTripDetail(tr_num);
		List<FileVO> fileList = tripService.getFileList(tr_num);
		mv.addObject("trip", trip);
		mv.addObject("fileList", fileList);
		mv.setViewName("/spot/tripDetail");
		return mv;
	}
	
	//여행지(trip) 수정(modify)
	@RequestMapping(value = "/tripModify", method = RequestMethod.GET)
	public ModelAndView tripModifyGet(ModelAndView mv, HttpServletRequest request, Integer tr_num) {
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		TripVO trip = tripService.getTripDetail(tr_num);
		Integer sc_num = 0;
		Integer mc_num = 0;
		
		//SpotMenuVO spotMenu = tripService.selectMenu(trip, user);
		if(trip == null) {
			mv.setViewName("redirect:/spot/"+user.getMe_id()+"/tripList/"+trip.getTr_sm_num());
			if(trip.getTr_sca_name()!=null) {
				//sca_name의 sc_num을 찾기
				//SELECT sc_num FROM small_category WHERE sc_num = #{tr_sca_name};
				sc_num = tripService.getTripScaNum(trip.getTr_sca_name());
				mc_num = tripService.getTripMcaNum(trip.getTr_mca_name());
			}else {
				mc_num = tripService.getTripMcaNum(trip.getTr_mca_name());
			}
			
		}else {
			List<FileVO> fileList = tripService.getFileList(tr_num);
			mv.addObject("fileList", fileList);
			mv.addObject("trip", trip);
			mv.setViewName("/spot/tripModify");
		}
		
		
		return mv;
	}
	@RequestMapping(value = "/tripModify", method = RequestMethod.POST)
	public ModelAndView tripModifyPost(ModelAndView mv, HttpServletRequest request, TripVO trip,
			List<MultipartFile> file, Integer[] fileNums) {
		if(fileNums != null) {
			for(Integer tmp : fileNums)
				System.out.println(tmp);
		}
		
		MemberVO user = (MemberVO)request.getSession().getAttribute("user");
		System.out.println(trip);
		if(tripService.modifyTrip(trip, file, fileNums)) {
			mv.setViewName("/spot/"+user.getMe_id()+"/tripList/"+trip.getTr_sm_num());
		}
		mv.setViewName("/spot/tripModify");
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
		}else if(dbTrip == null) {
			 System.out.println("삭제실패");
			 mv.setViewName("redirect:/spot/"+user.getMe_id()+"/home");
		}else {
			mv.setViewName("redirect:/"+user.getMe_id()+"/tripDetail/"+dbTrip.getTr_sm_num()+"/"+dbTrip.getTr_num());
		}
		
		return mv;
	}
	
	
	

}
