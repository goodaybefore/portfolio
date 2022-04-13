package kr.green.mytrip.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.green.mytrip.vo.TripmateVO;

public interface MateDAO {

	List<TripmateVO> selectMateList(@Param("me_id")String me_id);

}
