package kr.green.mytrip.service;

import kr.green.mytrip.vo.MemberVO;
import kr.green.mytrip.vo.TripVO;

public interface TripService {

	boolean insertTrip(MemberVO user, TripVO trip);

}
