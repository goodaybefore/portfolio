package kr.green.mytrip.service;

import java.util.List;

import kr.green.mytrip.vo.TripmateVO;

public interface MateService {

	List<TripmateVO> getMateList(String me_id);

}
