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
	
	//테이블이름
	int selectCategoryCount(@Param("tableName")String tableName, @Param("col_name")String columnName, @Param("num")Integer num);
	

}
