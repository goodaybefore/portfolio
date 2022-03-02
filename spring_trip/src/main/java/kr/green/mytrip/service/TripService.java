package kr.green.mytrip.service;

import java.util.List;

import kr.green.mytrip.vo.MemberVO;
import kr.green.mytrip.vo.MiddleCategoryVO;
import kr.green.mytrip.vo.TripVO;

public interface TripService {

	boolean insertTrip(MemberVO user, TripVO trip);
	
	//카테고리
	List<MiddleCategoryVO> selectMiddleCategory(int lc_num);

}
