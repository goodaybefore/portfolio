package kr.green.mytrip.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.green.mytrip.pagination.Criteria;
import kr.green.mytrip.vo.ActivityPhotoVO;
import kr.green.mytrip.vo.ActivityVO;
import kr.green.mytrip.vo.ChargeTripVO;
import kr.green.mytrip.vo.FileVO;
import kr.green.mytrip.vo.MemberVO;
import kr.green.mytrip.vo.MiddleCategoryVO;
import kr.green.mytrip.vo.SmallCategoryVO;
import kr.green.mytrip.vo.SpotMenuVO;
import kr.green.mytrip.vo.TripVO;

public interface TripService {
	
	//spot home에 출력할 여행포인트
	List<String> getTripPoints(String spot_user);
	
	//trip Reg
	boolean insertTrip(MemberVO user, TripVO trip, List<MultipartFile> file, Integer mc_num, Integer sc_num);
	
	//카테고리
	List<MiddleCategoryVO> selectMiddleCategory(Integer lc_num);
	List<SmallCategoryVO> selectSmallCategory(Integer mc_num);
	
	//등록한 여행지 목록 출력
	List<TripVO> getTripList(MemberVO user, String spot_user, Integer sm_num, Criteria cri);
	//여행지 pagination
	int getTotalTripCount(Criteria cri, Integer sm_num);
	//여행지 detail
	TripVO getTripDetail(Integer tr_num);
	List<FileVO> getFileList(Integer tr_num);
	List<String> getActAddressList(Integer tr_num);//map 출력을 위한 trip의 모든 activity 가져오기
	//여행지 delete
	boolean deleteTrip(MemberVO user, TripVO dbTrip);
	//여행지 선택
	TripVO selectTrip(Integer tr_num);
	//여행지의 Menu Category 불러오기
	SpotMenuVO selectMenu(TripVO trip, MemberVO user);

	//여행지 수정
	boolean modifyTrip(TripVO trip, List<MultipartFile> file, Integer[] fileNums, Integer mc_num, Integer sc_num);
	Integer getScaNum(String tr_sca_name);
	Integer getMcaNum(String tr_mca_name);
	
	//여행 가져오기
	boolean copyTrip(String user, Integer tr_num, Integer copy_sm_num);
	List<SpotMenuVO> getUserMenu(String me_id);//여행지 내려받을 회원의 spotMenuList 불러오기
	
	
	//활동 목록 출력
	List<ActivityVO> getActList(Integer tr_num, Criteria cri);
	//활동 개수(pagination)
	int getTotalActivityCount(Criteria cri, Integer reg_tr_num);
		
	//활동 등록
	boolean insertActivity(ActivityVO activity, Integer mc_num, Integer sc_num, List<MultipartFile> ac_files);
	//활동 상세(detail)
	ActivityVO selectActivity(Integer ac_num);
	//reg_sm_num 가져오기
	Integer getSmNum(int ac_tr_num);
	
	//활동 수정(modify)
	boolean modifyActivity(ActivityVO activity, Integer mc_num, Integer sc_num, MemberVO user);
	//활동에 첨부한 이미지 가져오기
	List<ActivityPhotoVO> getActivityPhotoList(Integer ac_num);
	
	//활동 삭제(delete)
	boolean deleteActivity(ActivityVO dbActivity);
	
	//활동 이미지 저장
	String summernoteImg(MultipartFile img);
	
	//trip 결제 내역 저장
	boolean insertChargeRecord(ChargeTripVO chargeTrip);
	//me_id의 회원등급 알아보기
	String getUserGrade(String me_id);
	boolean checkTripPurchase(Integer tr_num, String me_id);//me_id로 이 여행에 대한 결제가 있는지 확인


	
	

	
	
	
	
	
	
	

	

}
