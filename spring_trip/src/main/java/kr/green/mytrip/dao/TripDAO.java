package kr.green.mytrip.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

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
	int selectCategoryCount(@Param("tableName")String tableName, @Param("col_name")String columnName,
			@Param("num")Integer num, @Param("col_name2")String string, @Param("num2")Integer sc_num);
	//여행지 목록 불러오기 tripList
	List<TripVO> selectTripList();
	String selectCategoryName(@Param("tableName")String tableName,  @Param("selectName")String selectName,
			@Param("colName1")String colName1, @Param("colVal1")Integer colVal1,
			@Param("colName2")String colName2,  @Param("colVal2")Integer calVal2);
	

}
