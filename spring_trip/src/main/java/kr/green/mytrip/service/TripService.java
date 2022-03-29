package kr.green.mytrip.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.green.mytrip.pagination.Criteria;
import kr.green.mytrip.vo.ActivityPhotoVO;
import kr.green.mytrip.vo.ActivityVO;
import kr.green.mytrip.vo.FileVO;
import kr.green.mytrip.vo.MemberVO;
import kr.green.mytrip.vo.MiddleCategoryVO;
import kr.green.mytrip.vo.SmallCategoryVO;
import kr.green.mytrip.vo.SpotMenuVO;
import kr.green.mytrip.vo.TripVO;

public interface TripService {
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
	boolean copyTrip(MemberVO user, Integer tr_num);
	
	
	
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
	
	
	
	
	
	
	

	

}
