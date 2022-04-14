package kr.green.mytrip.service;

import java.util.List;

import kr.green.mytrip.vo.TripmateVO;

public interface MateService {

	List<TripmateVO> getMateList(String me_id);
	//spot_user와 login_user가 트립메이트인지 확인
	String isTripmate(String me_id, String thisUser);
	//트립메이트 신청
	String requestTripmate(String me_id, String spot_user);

}
