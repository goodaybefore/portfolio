package kr.green.mytrip.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.green.mytrip.pagination.Criteria;
import kr.green.mytrip.vo.ActivityVO;
import kr.green.mytrip.vo.FileVO;
import kr.green.mytrip.vo.MiddleCategoryVO;
import kr.green.mytrip.vo.SmallCategoryVO;
import kr.green.mytrip.vo.TripVO;

public interface TripDAO {
	
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
	List<TripVO> selectTripListAll(@Param("sm_num")Integer sm_num, @Param("cri")Criteria cri);//모두 불러오기
	List<TripVO> selectTripList(@Param("openRange")String openRange, Integer sm_num);//특정 범위만 불러오기
	//여행지 목록 페이지네이션
	int selectTotalTripCount(@Param("sm_num")Integer sm_num);
	
	//여행지 detail
	TripVO selectTripDetail(@Param("tr_num") Integer tr_num);
	List<FileVO> selectFileList(@Param("tr_num")Integer tr_num);
	List<ActivityVO> selectActivityList(Integer tr_num);//활동 리스트 출력
	
	//여행지 delete
	void deleteTrip(@Param("tr_num")Integer tr_num);
	TripVO selectTrip(@Param("tr_num")Integer tr_num);
	
	//여행지 modify
	void updateTrip(@Param("trip")TripVO trip);
	Integer selectSmallcategoryNum(String tr_sca_name);
	Integer selectMiddlecategoryNum(String tr_mca_name);
	
	
	//활동 Reg(insert)
	void insertActivity(@Param("activity")ActivityVO activity);
	
	
	
	
	
	
	
	
	
	

}
