package kr.green.mytrip.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.green.mytrip.vo.MiddleCategoryVO;

public interface TripDAO {
	
	//여행지설정
	List<MiddleCategoryVO> selectMiddleCategory(@Param("lc_num")int lc_num);

}
