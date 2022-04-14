package kr.green.mytrip.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.green.mytrip.dao.MateDAO;
import kr.green.mytrip.vo.TripmateRequestVO;
import kr.green.mytrip.vo.TripmateVO;

@Service
public class MateServiceImp implements MateService{
	@Autowired
	MateDAO mateDao;
	
	@Override
	public List<TripmateVO> getMateList(String me_id) {
		return mateDao.selectMateList(me_id);
	}
	
	//spot_user와 login_user가 트립메이트인지 확인
	@Override
	public String isTripmate(String me_id, String thisUser) {
		 //login_user(tm_me_id)의 친구목록에 spot_user(tm_mate_id)가 있는지확인
		//spot_user(tm_mate_id)의 친구목록에 login_user(tm_me_id)가 있는지 확인
		TripmateVO checkTripmate1 = mateDao.selectTripmate(me_id, thisUser);
		TripmateVO checkTripmate2 = mateDao.selectTripmate(thisUser, me_id );
		if(checkTripmate1 != null && checkTripmate2 != null) return "true";
		else return "false";
		
	}

	//트립메이트 신청
	@Override
	public String requestTripmate(String me_id, String spot_user) {
		if(spot_user == null) return "false";
		
		TripmateRequestVO dbRequestMate = mateDao.checkTripmateRequest(me_id, spot_user);
		if(dbRequestMate != null) return "duplicated";
		
		TripmateVO dbTripmate = mateDao.checkTripmate(me_id, spot_user);
		
		//tripmate 신청
		//me_id => 신청한 사용자(tr_me_id)
		//spot_user => 신청 받은 사용자(tr_mate_id)
		mateDao.insertTripmateRequest(me_id, spot_user);
		return "true";
	}

	@Override
	public List<TripmateVO> getReceiveList(String me_id) {
		List<TripmateVO> received = mateDao.tripmateReceived(me_id);
		if(received != null) return received;
		else return null;
	}

	@Override
	public List<TripmateVO> getSendList(String me_id) {
		List<TripmateVO> request = mateDao.tripmateRequest(me_id);
		if(request != null) return request;
		else return null;
	}

	
	
	

}
