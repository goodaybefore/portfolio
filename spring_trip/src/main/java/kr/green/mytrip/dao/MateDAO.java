package kr.green.mytrip.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.green.mytrip.vo.TripmateVO;

public interface MateDAO {

	List<TripmateVO> selectMateList(@Param("me_id")String me_id);
	
	//me_id의 친구목록에 thisUser가 있는지 확인
	TripmateVO selectTripmate(@Param("me_id_1")String me_id, @Param("me_id_2")String thisUser);
	//트립메이트 신청(update)
	void insertTripmate(@Param("me_id")String me_id, @Param("spot_user")String spot_user);
	//트립메이트 검사  //이미 트립메이트를 신청한 상황인지?
	TripmateVO checkTripmate(@Param("me_id")String me_id, @Param("spot_user")String spot_user);

}
