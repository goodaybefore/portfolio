package kr.green.mytrip.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.green.mytrip.dao.TripDAO;
import kr.green.mytrip.pagination.Criteria;
import kr.green.mytrip.utills.UploadFileUtills;
import kr.green.mytrip.vo.FileVO;
import kr.green.mytrip.vo.MemberVO;
import kr.green.mytrip.vo.MiddleCategoryVO;
import kr.green.mytrip.vo.SmallCategoryVO;
import kr.green.mytrip.vo.SpotMenuVO;
import kr.green.mytrip.vo.TripVO;

@Service
public class TripServiceImp implements TripService{
	@Autowired
	TripDAO tripDao;
	
	String uploadPath = "E:\\2021\\portfolio\\upload_file";
	
	@Override
	public boolean insertTrip(MemberVO user, TripVO trip, List<MultipartFile> file, Integer mc_num, Integer sc_num) {
		//필수로 들어가있어야 하는 항목 : tr_me_id, tr_ca_name, tr_ca_num(사용자메뉴번호), tr_sc_num(소분류), tr_op_name
		if(user == null || trip== null || user.getMe_id()==null || trip.getTr_me_id()==null ||
				trip.getTr_title()==null) return false;
		//세션의 ID와 trip의 ID가 같지 않은 경우
		if(!user.getMe_id().equals(trip.getTr_me_id())) return false;
		//endDate가 없을경우 ==> 당일여행인 경우
		if(trip.getTr_end_date() ==null) trip.setTr_end_date(trip.getTr_start_date());
		
		
		String mca_name = tripDao.selectMiddleCategoryName(mc_num);
		String sca_name = null;
		if(sc_num != null) sca_name = tripDao.selectSmallCategoryName(sc_num);
		
		if(mca_name == null) return false;
		
		trip.setTr_mca_name(mca_name);
		trip.setTr_sca_name(sca_name);
		
		
		//trip insert
		tripDao.insertTrip(trip);
		//file insert
		uploadFile(file, trip.getTr_num());
		
		return true;
	}
	//카테고리
	@Override
	public List<MiddleCategoryVO> selectMiddleCategory(Integer lc_num) {
		return tripDao.selectMiddleCategory(lc_num);
	}
	@Override
	public List<SmallCategoryVO> selectSmallCategory(Integer mc_num) {
		return tripDao.selectSmallCategory(mc_num);
	}
	
	
	//file upload 함수
	private void uploadFile(List<MultipartFile> file, Integer tr_num) {
		if(file == null) return;
		for(MultipartFile tmpFile : file) {
			if(tmpFile != null && tmpFile.getOriginalFilename().length()!=0) {
				String path;
				try {
					path = UploadFileUtills.uploadFile(uploadPath, tmpFile.getOriginalFilename(), tmpFile.getBytes());
					FileVO f = new FileVO(tmpFile.getOriginalFilename(), path, tr_num);
					tripDao.insertFile(f);
					
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
		
	}
	
	//여행지리스트(tripList)가져오기
	@Override
	public List<TripVO> getTripList(MemberVO user, String spot_user, Integer sm_num, Criteria cri) {
		if(spot_user == null) return null;
		//guest로그인시..일단 다 보여주기
		if(user == null) return tripDao.selectTripList("전체공개", sm_num);
		if(user.getMe_id().equals(spot_user)) //본인이면 모든 게시글 보여주기
			return tripDao.selectTripListAll(sm_num, cri);
		return null;
	}
	//여행지리스트(tripList) 페이지네이션
	@Override
	public int getTotalTripCount(Criteria cri, Integer sm_num) {
		return tripDao.selectTotalTripCount(sm_num);
	}
	
	//여행지 1개의 detail 불러오기
	@Override
	public TripVO getTripDetail(Integer tr_num) {
		if(tr_num <= 0 || tr_num == null) return null;
		TripVO trip = tripDao.selectTripDetail(tr_num);
		
		if(trip == null) return null;
		return trip;
	}
	@Override
	public List<FileVO> getFileList(Integer tr_num) {
		return tripDao.selectFileList(tr_num);
	}
	
	//여행지 삭제
	@Override
	public boolean deleteTrip(MemberVO user, TripVO dbTrip) {
		if(user == null  || dbTrip == null || dbTrip.getTr_num() <=0) return false;
		//tripDao.deleteTrip(tr_num);
		return true;
	}
	@Override
	public TripVO selectTrip(Integer tr_num) {
		return tripDao.selectTrip(tr_num);
	}
	
	//선택된 여행지의 menu Category 불러오기
	@Override
	public SpotMenuVO selectMenu(TripVO trip, MemberVO user) {
		if(trip==null || user == null) return null;
		if(!trip.getTr_me_id().equals(user.getMe_id())) return null;
		return null;
	}
	@Override
	
	//여행지 수정
	public boolean modifyTrip(TripVO trip, List<MultipartFile> file, Integer[] fileNums) {
		if(trip==null || trip.getTr_mca_name()== null || trip.getTr_title()==null || trip.getTr_op_name() == null)
			return false;
		System.out.println(trip);
		System.out.println(file);
		System.out.println(fileNums);
		//tripDao.updateTrip(trip);
		return false;
	}
	//여행지 이름으로 각 카테고리의 primary key 구하기
	@Override
	public Integer getTripScaNum(String tr_sca_name) {
		return tripDao.selectSmallcategoryNum(tr_sca_name);
	}
	@Override
	public Integer getTripMcaNum(String tr_mca_name) {
		// TODO Auto-generated method stub
		return tripDao.selectMiddlecategoryNum(tr_mca_name);
	}

}
