package kr.green.mytrip.service;

import java.util.List;

import kr.green.mytrip.vo.TripmateVO;

public interface MateService {

	List<TripmateVO> getMateList(String me_id);
	//spot_user와 login_user가 트립메이트인지 확인
	String isTripmate(String me_id, String thisUser);
	//트립메이트 신청
	String requestTripmate(String me_id, String spot_user);
	
	//내가 받은 트립메이트 신청 확인
	List<TripmateVO> getReceiveList(String me_id);
	//내가 보낸 트립메이트 신청 확인
	List<TripmateVO> getSendList(String me_id);
	//내가 보낸 트립메이트 신청 취소
	boolean mateRequestCancel(String receive_id, String request_id);
	//내가 받은 트립메이트 신청 반응(수락/거절)
	boolean tripmateResponse(String request_id, String me_id, boolean response);

}
