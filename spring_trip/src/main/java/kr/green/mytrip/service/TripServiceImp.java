package kr.green.mytrip.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.green.mytrip.dao.TripDAO;
import kr.green.mytrip.pagination.Criteria;
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
		if(user == null || trip== null || user.getMe_id()==null || trip.getTr_me_id()==null ||
				trip.getTr_title()==null) return false;
		//세션의 ID와 trip의 ID가 같지 않은 경우
		if(!user.getMe_id().equals(trip.getTr_me_id())) return false;
		//endDate가 없을경우 ==> 당일여행인 경우
		if(trip.getTr_end_date() ==null) trip.setTr_end_date(trip.getTr_start_date());
		//tr_ca_num(카테고리 번호)가 해당 분류(middle or small)안에 있는 카테고리 개수범위에 들어가지 않을 경우 false를 리턴
		if(!CategoryInput(trip, sc_num, mc_num)) return false;
		
		
		//trip insert
		tripDao.insertTrip(trip);
		//file insert
		uploadFile(file, trip.getTr_num());
		
		return true;
	}
	public boolean CategoryInput(TripVO trip, Integer sc_num, Integer mc_num) {
		//카테고리 분류(1차) => 중분류/소분류 나누기
		if(sc_num == null && mc_num != null) {
			//중분류까지 입력되어있을 경우
			trip.setTr_ca_sort_name("middle_category");
		}else if(sc_num != null && mc_num != null) {
			//중분류와 소분류가 모두 입력되어 있을 경우
			trip.setTr_ca_sort_name("small_category");
		}else {
			return false;
		}
		
		//카테고리 분류 (2차) => 소분류or중분류에 입력된 숫자가 해당 분류의 개수범위에 들어가지 않을 때 return false;
		//tripDao.selectCategoryCount(개수가져올테이블이름, 상위카테고리행이름, 상위카테고리번호);
		int exist;
		if(trip.getTr_ca_sort_name().equals("small_category")) {//소분류일때
			exist = tripDao.selectCategoryCount(trip.getTr_ca_sort_name(), "sc_mc_num", mc_num, "sc_num", sc_num);
		}else if(trip.getTr_ca_sort_name().equals("middle_category")) {//중분류일때
			exist = tripDao.selectCategoryCount(trip.getTr_ca_sort_name(), "mc_lc_num",1, "mc_num", mc_num);
		}else {	return false; }
		//만약 결과값(exist)이 1이 아니면 return false(해당조건에 맞는 결과는 1개만 나와야함)
		String ca_name;
		if(trip.getTr_ca_sort_name() == null || exist != 1) return false;
		else {//분류칸이 null이 아니고 exist가 1이면
			//tr_ca_name에 지역명을 넣어줌
			//tripDao.selectCategoryName(테이블이름, 범위이름, 이전범위이름, 이전범위번호, 지금범위이름, 지금범위번호);
			if(trip.getTr_ca_sort_name().equals("middle_category")) {
				ca_name = tripDao.selectCategoryName(trip.getTr_ca_sort_name(), "mc_name", "mc_lc_num", 1, "mc_num", mc_num);
				trip.setTr_ca_name(ca_name);
			}
			else if(trip.getTr_ca_sort_name().equals("small_category")) {
				ca_name = tripDao.selectCategoryName(trip.getTr_ca_sort_name(), "sc_name", "sc_mc_num", mc_num, "sc_num", sc_num);
				trip.setTr_ca_name(ca_name);
			}else return false;
		}
		
		
		return true;
	}
	//카테고리
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
	
	//여행지리스트(tripList)가져오기
	@Override
	public List<TripVO> getTripList(MemberVO user, String spot_user, Integer sm_num) {
		if(spot_user == null) return null;
		//guest로그인시..일단 다 보여주기
		if(user == null) return tripDao.selectTripList("전체공개", sm_num);
		if(user.getMe_id().equals(spot_user)) //본인이면 모든 게시글 보여주기
			return tripDao.selectTripListAll(sm_num);
		return null;
	}
	//여행지리스트(tripList) 페이지네이션
	@Override
	public int getTotalTripCount(Criteria cri, Integer sm_num) {
		return tripDao.selectTotalTripCount(sm_num);
	}
	
	//여행지 1개의 detail 불러오기
	@Override
	public TripVO getTripDetail(Integer tr_num) {
		//일단 전체공개 select
		return tripDao.selectTripDetail("전체공개", tr_num);
	}

}
