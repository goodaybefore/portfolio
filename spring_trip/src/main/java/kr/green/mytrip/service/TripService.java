package kr.green.mytrip.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.green.mytrip.vo.MemberVO;
import kr.green.mytrip.vo.MiddleCategoryVO;
import kr.green.mytrip.vo.SmallCategoryVO;
import kr.green.mytrip.vo.TripVO;

public interface TripService {
	//trip Reg
	boolean insertTrip(MemberVO user, TripVO trip, List<MultipartFile> file, Integer mc_num, Integer sc_num);
	
	//카테고리
	List<MiddleCategoryVO> selectMiddleCategory(Integer lc_num);
	List<SmallCategoryVO> selectSmallCategory(Integer mc_num);

}
