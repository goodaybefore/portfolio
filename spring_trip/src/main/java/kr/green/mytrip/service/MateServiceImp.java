package kr.green.mytrip.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.green.mytrip.dao.MateDAO;
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
	
	

}
