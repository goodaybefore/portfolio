package kr.green.mytrip.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.green.mytrip.dao.TripDAO;
import kr.green.mytrip.pagination.Criteria;
import kr.green.mytrip.utills.UploadFileUtills;
import kr.green.mytrip.vo.ActivityPhotoVO;
import kr.green.mytrip.vo.ActivityVO;
import kr.green.mytrip.vo.ChargeTripVO;
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
	
	String uploadTripPath = "E:\\2021\\portfolio\\upload_file";
	String uploadActivityPath = "E:\\2021\\portfolio\\activity_photo";
	
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
		uploadTripFile(file, trip.getTr_num(), uploadTripPath);
		
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
	private void uploadTripFile(List<MultipartFile> file, Integer primary_num, String uploadPath) {
		if(file == null) return;
		for(MultipartFile tmpFile : file) {
			if(tmpFile != null && tmpFile.getOriginalFilename().length()!=0) {
				String path;
				try {
					path = UploadFileUtills.uploadFile(uploadPath, tmpFile.getOriginalFilename(), tmpFile.getBytes());
					FileVO f = new FileVO(tmpFile.getOriginalFilename(), path, primary_num);
					tripDao.insertFile(f);
					
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
		
	}
	//activity img upload
	//file upload 함수
		private void uploadActivityImg(List<MultipartFile> file, ActivityVO activity, String uploadPath) {
			if(file == null) return;
			for(int i=0;i<file.size()-1;i++) {
				if(file.get(i) != null && file.get(i).getOriginalFilename().length()!=0) {
					String path;
					try {
						path = UploadFileUtills.uploadActivityImg(uploadPath, file.get(i).getOriginalFilename(), file.get(i).getBytes(), activity);
						ActivityPhotoVO ap = new ActivityPhotoVO(file.get(i).getOriginalFilename(), path, activity.getAc_num());
						tripDao.insertActivityImgFile(ap);
						
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
		if(user == null) 
			return tripDao.selectTripList("전체공개", sm_num, spot_user, cri);
		if(user.getMe_id().equals(spot_user)) 
			return tripDao.selectTripListAll(sm_num, cri, spot_user);
		if(!user.getMe_id().equals(spot_user)) {
			return tripDao.selectTripList("전체공개", sm_num, spot_user, cri);
		}
			
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
		tripDao.deleteTrip(dbTrip.getTr_num());
		//trip이 삭제될 때 ac_tr_num = tr_num인 activity도 모두 ac_del='Y'로 만들어주기
		tripDao.deleteTripActivity(dbTrip.getTr_num());
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
	public boolean modifyTrip(TripVO trip, List<MultipartFile> file, Integer[] fileNums,
			Integer mc_num, Integer sc_num) {
		if(trip==null || trip.getTr_title()==null || trip.getTr_op_name() == null)
			return false;
		//mca_name과 sca_name을 mc_num, sc_num을 통해 set하기
		trip.setTr_mca_name(tripDao.selectMiddleCategoryName(mc_num));
		trip.setTr_sca_name(tripDao.selectSmallCategoryName(sc_num));
		
		if(trip.getTr_mca_name()== null) return false;
		
		System.out.println("trip : "+trip);
		System.out.println("fileNums :" + fileNums);
		tripDao.updateTrip(trip);
		return true;
	}
	//여행지 이름으로 각 카테고리의 primary key 구하기
	@Override
	public Integer getScaNum(String sca_name) {
		return tripDao.selectSmallcategoryNum(sca_name);
	}
	@Override
	public Integer getMcaNum(String mca_name) {
		// TODO Auto-generated method stub
		return tripDao.selectMiddlecategoryNum(mca_name);
	}
	
	//활동 리스트 불러오기
	@Override
	public List<ActivityVO> getActList(Integer tr_num, Criteria cri) {
		if(tr_num <=0 || tr_num == null) return null;
		return tripDao.selectActivityList(tr_num, cri);
	}
	
	//활동 등록
	@Override
	public boolean insertActivity(ActivityVO activity, Integer mc_num, Integer sc_num, List<MultipartFile> ac_files) {
		if(activity==null || activity.getAc_title()==null || activity.getAc_op_name() == null)
			return false;
		//mca_name과 sca_name을 mc_num, sc_num을 통해 set하기
		activity.setAc_mca_name(tripDao.selectMiddleCategoryName(mc_num));
		activity.setAc_sca_name(tripDao.selectSmallCategoryName(sc_num));
		
		//활동 저장
		tripDao.insertActivity(activity);
		//활동 첨부사진 저장
		uploadActivityImg(ac_files, activity, uploadActivityPath);
		
		return true;
	}
	
	//활동 상세(detail)
	@Override
	public ActivityVO selectActivity(Integer ac_num) {
		return tripDao.selectActivity(ac_num);
	}
	
	//reg_sm_num 가져오기
	@Override
	public Integer getSmNum(int ac_tr_num) {
		return tripDao.selectSmNum(ac_tr_num);
	}
	@Override
	public boolean modifyActivity(ActivityVO activity, Integer mc_num, Integer sc_num, MemberVO user) {
		if(activity == null || activity.getAc_title()== null || !activity.getAc_me_id().equals(user.getMe_id())||
				activity.getAc_contents()== null) return false;
		//ac_tr_num을 jsp단에서 수정해서 일부러 다른 tr_num으로 입력하거나, ac_num을 그렇게 일부러 다르게 입력하거나, ac_mca와 sca를 DB에 없는걸로 입력하면??..
		
		
		activity.setAc_mca_name(tripDao.selectMiddleCategoryName(mc_num));
		activity.setAc_sca_name(tripDao.selectSmallCategoryName(sc_num));
		tripDao.updateActivity(activity);
		return true;
	}
	
	//활동 삭제(delete)
	@Override
	public boolean deleteActivity(ActivityVO dbActivity) {
		if(dbActivity == null) return false;
		//삭제 진행
		tripDao.deleteActivity(dbActivity.getAc_num());
		return true;
	}
	
	//활동 사진 추가 및 저장
	//서머노트 이용하는건데 지금 안씀.. 안될듯 ㅇㅅㅇ
	@Override
	public String summernoteImg(MultipartFile img) {
		if(img != null && img.getOriginalFilename().length() != 0) {
			return uploadImgFile(img, null);
		}
		return "";
	}
	private String uploadImgFile(MultipartFile file, Integer ac_num) {
		ActivityVO activity = tripDao.selectActivity(ac_num);
		try {
			String path = UploadFileUtills.uploadActivityImg(
				uploadActivityPath, file.getOriginalFilename(), file.getBytes(), activity);
			ActivityPhotoVO photoVo = 
				new ActivityPhotoVO(file.getOriginalFilename(), path, ac_num);
			//tripDao.insertActivityPhoto(photoVo);
			return path;
		}catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	@Override
	public int getTotalActivityCount(Criteria cri, Integer reg_tr_num) {
		return tripDao.selectTotalActivityCount(reg_tr_num);
	}
	@Override
	public List<ActivityPhotoVO> getActivityPhotoList(Integer ac_num) {
		return tripDao.selectActivityPhotoList(ac_num);
	}
	@Override
	public boolean copyTrip(String user, Integer tr_num, Integer copy_sm_num) {
		TripVO copyTrip = tripDao.selectTrip(tr_num);
		List<ActivityVO> copyActList = tripDao.selectCopyActList(tr_num);
		//내가 내껄 복사하려는 경우
		if(copyTrip.getTr_me_id().equals(user)) return false;
		//trip이 없는경우
		if(copyTrip == null) return false;
		
		/* 복사 진행
		 * trip Insert로 번호(tr_num) return하고
		 * activity Insert로 번호(ac_num) 리턴하기
		 * */
		//id 변경 후 Trip insert
		copyTrip.setTr_me_id(user);
		copyTrip.setTr_sm_num(copy_sm_num);
		tripDao.insertTrip(copyTrip);
		//불러온 Activity 목록을 복사하기
		if(copyActList != null) {
			for(int i=0;i<copyActList.size();i++) {
				copyActList.get(i).setAc_me_id(user);
				copyActList.get(i).setAc_tr_num(copyTrip.getTr_num());
				tripDao.insertActivity(copyActList.get(i));
				System.out.println(copyActList.get(i));
			}
		}
		
		return true;
	}
	@Override
	public List<SpotMenuVO> getUserMenu(String me_id) {
		if(me_id == null) return null;
		return tripDao.selectUserMenu(me_id);
	}
	@Override
	public boolean insertChargeRecord(ChargeTripVO chargeTrip) {
		TripVO dbTrip = tripDao.selectTrip(chargeTrip.getCh_tr_num());
		if(dbTrip == null) return false;
		//trip작성자가 관리자가 아닐경우 return false 하기
		MemberVO dbUser = tripDao.selectMemberInfo(dbTrip.getTr_me_id());
		if(dbUser.getMe_gr_name().equals("트립매니저") || dbUser.getMe_gr_name().equals("트립서포터")) return false;
		if(chargeTrip.getCh_amount() != dbTrip.getTr_charge()) return false;
		
		tripDao.insertChargeRecord(chargeTrip);
		return true;
	}
	
	//회원의 등급 리턴
	@Override
	public String getUserGrade(String me_id) {
		MemberVO dbUser = tripDao.selectMemberInfo(me_id);
		return dbUser.getMe_gr_name();
	}
	@Override
	public boolean checkTripPurchase(Integer tr_num, String me_id) {
		ChargeTripVO dbCh = tripDao.selectChargedRecord(tr_num, me_id);
		if(dbCh != null) return true;
		return false;
	}

}
