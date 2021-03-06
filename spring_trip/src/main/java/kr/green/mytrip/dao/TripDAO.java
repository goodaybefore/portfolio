package kr.green.mytrip.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

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

public interface TripDAO {
	//spot_home
	List<String> selectTripPoints(@Param("spot_user")String spot_user);
	
	//여행지 장소
	List<MiddleCategoryVO> selectMiddleCategory(@Param("lc_num")Integer lc_num);
	List<SmallCategoryVO> selectSmallCategory(@Param("mc_num")Integer mc_num);
	//여행지 업로드
	void insertTrip(@Param("trip")TripVO trip);
	//여행지 파일업로드
	void insertFile(@Param("file")FileVO f);
	
	//여행지 카테고리가 맞는지 검사
	String selectMiddleCategoryName(@Param("mc_num")Integer mc_num);
	String selectSmallCategoryName(@Param("sc_num")Integer sc_num);
	
	
	//여행지 목록 불러오기 tripList
	List<TripVO> selectTripListAll(@Param("sm_num")Integer sm_num, @Param("cri")Criteria cri, @Param("spot_user")String spot_user);//모두 불러오기
	List<TripVO> selectTripList(@Param("openRange")String openRange, @Param("sm_num")Integer sm_num, @Param("spot_user")String spot_user, @Param("cri")Criteria cri);//특정 범위만 불러오기
	//여행지 목록 페이지네이션
	int selectTotalTripCount(@Param("sm_num")Integer sm_num);
	
	//여행지 detail
	TripVO selectTripDetail(@Param("tr_num") Integer tr_num);
	List<FileVO> selectFileList(@Param("tr_num")Integer tr_num);
	List<ActivityVO> selectActivityList(@Param("tr_num")Integer tr_num, @Param("cri")Criteria cri);//활동 리스트 출력
	int selectTotalActivityCount(@Param("tr_num")Integer reg_tr_num);//pagination
	List<String> selectActivityAddressList(@Param("tr_num")Integer tr_num);//여행지의 활동들의 장소 리스트
	
	
	//여행지 delete
	void deleteTrip(@Param("tr_num")Integer tr_num);
	TripVO selectTrip(@Param("tr_num")Integer tr_num);
	//trip Delete시 활동도 함께 delete
	void deleteTripActivity(@Param("tr_num")Integer tr_num);
		
	//여행지 modify
	void updateTrip(@Param("trip")TripVO trip);
	Integer selectSmallcategoryNum(String tr_sca_name);
	Integer selectMiddlecategoryNum(String tr_mca_name);
	
	
	//활동 Reg(insert)
	void insertActivity(@Param("activity")ActivityVO activity);
	//활동 Detail
	ActivityVO selectActivity(@Param("ac_num")Integer ac_num);
	
	//reg_sm_num
	Integer selectSmNum(@Param("tr_num")int ac_tr_num);
	
	//활동 Modify(update)
	void updateActivity(@Param("activity")ActivityVO activity);
	List<ActivityPhotoVO> selectActivityPhotoList(@Param("ac_num")Integer ac_num);//활동사진들
	//활동 Delete
	void deleteActivity(@Param("ac_num")int ac_num);
	
	//활동 사진 저장
	//void insertActivityPhoto(@Param("photo")ActivityPhotoVO photoVo);
	void insertActivityImgFile(@Param("ap")ActivityPhotoVO ap);
	
	//활동 복사
	List<ActivityVO> selectCopyActList(@Param("tr_num")Integer tr_num);//활동 리스트 전부 불러오기
	List<SpotMenuVO> selectUserMenu(@Param("me_id")String me_id);
	
	//여행 결제
	void insertChargeRecord(@Param("charged")ChargeTripVO chargeTrip);//결제내역삽입
	MemberVO selectMemberInfo(@Param("me_id")String tr_me_id);//여행결제
	ChargeTripVO selectChargedRecord(@Param("tr_num")Integer tr_num,
			@Param("me_id")String me_id);//해당 여행에대해 로그인한 사용자가 결제했는지 안했는지 알아보기
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
