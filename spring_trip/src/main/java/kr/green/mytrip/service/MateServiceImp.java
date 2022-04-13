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

}
