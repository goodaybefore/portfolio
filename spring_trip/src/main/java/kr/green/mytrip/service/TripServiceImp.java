package kr.green.mytrip.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.green.mytrip.dao.TripDAO;
import kr.green.mytrip.utills.UploadFileUtills;
import kr.green.mytrip.vo.FileVO;
import kr.green.mytrip.vo.MemberVO;
import kr.green.mytrip.vo.MiddleCategoryVO;
import kr.green.mytrip.vo.SmallCategoryVO;
import kr.green.mytrip.vo.TripVO;

@Service
public class TripServiceImp implements TripService{
	@Autowired
	TripDAO tripDao;
	
	String uploadPath = "E:\\2021\\portfolio\\upload_file";
	
	@Override
	public boolean insertTrip(MemberVO user, TripVO trip, List<MultipartFile> file, Integer mc_num, Integer sc_num) {
		//필수로 들어가있어야 하는 항목 : tr_me_id, tr_ca_name, tr_ca_num(사용자메뉴번호), tr_sc_num(소분류), tr_op_name
		if(user == null || trip== null || user.getMe_id()==null) return false;
		//세션의 ID와 trip의 ID가 같지 않은 경우
		if(!user.getMe_id().equals(trip.getTr_me_id())) return false;
		//endDate가 없을경우 ==> 당일여행인 경우
		if(trip.getTr_end_date() ==null) trip.setTr_end_date(trip.getTr_start_date());
		//tr_ca_num(카테고리 번호)가 해당 분류(middle or small)안에 있는 카테고리 개수범위에 들어가지 않을 경우 false를 리턴
		if(!countCategoryCheck(trip, sc_num, mc_num)) return false;
		
		//trip insert
		tripDao.insertTrip(trip);
		
		//file insert
		uploadFile(file, trip.getTr_num());
		
		return true;
	}
	public boolean countCategoryCheck(TripVO trip, Integer sc_num, Integer mc_num) {
		System.out.println("sc_num : "+sc_num +"\nmc_num : "+mc_num);
		//카테고리 분류(1차) => 중분류/소분류 나누기
		if(sc_num == null && mc_num != null) {
			//중분류까지 입력되어있을 경우
			trip.setTr_ca_num(mc_num);
			trip.setTr_ca_name("middle_category");
		}else if(sc_num != null && mc_num != null) {
			//중분류와 소분류가 모두 입력되어 있을 경우
			trip.setTr_ca_num(sc_num);
			trip.setTr_ca_name("small_category");
		}else {
			return false;
		}
		
		//카테고리 분류 (2차) => 소분류or중분류에 입력된 숫자가 해당 분류의 개수범위에 들어가지 않을 때 return false;
		//tripDao.selectCategoryCount(개수가져올테이블이름, 상위카테고리행이름, 상위카테고리번호);
		int count;
		if(trip.getTr_ca_name().equals("small_category")) {//소분류가 마지막일때
			 count = tripDao.selectCategoryCount(trip.getTr_ca_name(), "sc_mc_num", mc_num);
		}else if(trip.getTr_ca_name().equals("middle_category")) {//중분류가 마지막일때
			count = tripDao.selectCategoryCount(trip.getTr_ca_name(), "mc_lc_num",1);
		}else {
			return false;
		}
		//만약 결과값(count)의 범위안에 tr_ca_num이 없는경우 return false
		if(trip.getTr_ca_num()<=0 || trip.getTr_ca_num()>count) return false;
		
		return true;
	}
	@Override
	public List<MiddleCategoryVO> selectMiddleCategory(Integer lc_num) {
		return tripDao.selectMiddleCategory(lc_num);
	}

	@Override
	public List<SmallCategoryVO> selectSmallCategory(Integer mc_num) {
		return tripDao.selectSmallCategory(mc_num);
	}
	
	
	//file upload 함수
	private void uploadFile(List<MultipartFile> file, Integer tr_num) {
		if(file == null) return;
		for(MultipartFile tmpFile : file) {
			if(tmpFile != null && tmpFile.getOriginalFilename().length()!=0) {
				String path;
				try {
					path = UploadFileUtills.uploadFile(uploadPath, tmpFile.getOriginalFilename(), tmpFile.getBytes());
					FileVO f = new FileVO(tmpFile.getOriginalFilename(), path, tr_num);
					tripDao.insertFile(f);
					
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
				
		}
		
	}

}
