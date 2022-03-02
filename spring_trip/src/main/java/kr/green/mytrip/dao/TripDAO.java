package kr.green.mytrip.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.green.mytrip.vo.MiddleCategoryVO;
import kr.green.mytrip.vo.SmallCategoryVO;

public interface TripDAO {
	
	//여행지설정
	List<MiddleCategoryVO> selectMiddleCategory(@Param("lc_num")Integer lc_num);

	List<SmallCategoryVO> selectSmallCategory(@Param("mc_num")Integer mc_num);

}
