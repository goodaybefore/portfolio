package kr.green.mytrip.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.green.mytrip.dao.MemberDAO;
import kr.green.mytrip.utills.UploadFileUtills;
import kr.green.mytrip.vo.MemberVO;
import kr.green.mytrip.vo.SpotMenuVO;

@Service
public class MemberServiceImp implements MemberService {
	@Autowired
	MemberDAO memberDao;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	String uploadPath = "E:\\2021\\portfolio\\member_profile";
	//signup
	@Override
	public boolean insertMember(MemberVO member) {
		if(member.getMe_id()==null || member.getMe_pw()==null || member.getMe_pw().length()==0) return false;
		//아이디 중복 확인
		if(memberDao.selectMember(member.getMe_id()) != null) return false;
		
		//비밀번호 암호화
		String encPw = passwordEncoder.encode(member.getMe_pw());
		member.setMe_pw(encPw);
		//회원 기본 등급 저장
		member.setMe_gr_name("트립비기너");
		//기본 공개 범우 저장
		member.setMe_op_name("전체공개");
		
		//DB에 회원 추가
		memberDao.insertMember(member);
		//기본메뉴 생성
		SpotMenuVO menu = new SpotMenuVO(member.getMe_id());
		memberDao.insertDefaultMenu(menu);
		
		return true;
	}
	
	//login
	@Override
	public MemberVO loginMember(MemberVO input) {
		if(input == null) return null;
		if(input.getMe_id()==null || input.getMe_pw()==null) return null;
		
		//id로 db회원 불러오기
		MemberVO dbuser = memberDao.selectMember(input.getMe_id());
		if(dbuser == null) return null;
		
		//input user의 비밀번호가 일치하는지 확인
		if(dbuser.getMe_id().equals(input.getMe_id()) && passwordEncoder.matches(input.getMe_pw(), dbuser.getMe_pw())) {
			System.out.println("로그인성공");
			return dbuser;
		}
		
		
		return null;
	}
	//login - 사용자 메뉴리스트 불러오기
	@Override
	public List<SpotMenuVO> getMenuList(String user) {
		if(user == null) return null;
		return memberDao.selectMenuList(user);
	}

	@Override
	public boolean mypageUpdate(MemberVO user, MemberVO input, List<MultipartFile> file) {
		if(!user.getMe_id().equals(input.getMe_id())) return false;
		//기존프로필가져오기
		MemberVO dbUser = memberDao.selectMember(user.getMe_id());
		
		//
		if(dbUser.getMe_photo()!=null) {
			memberDao.deleteProfile(user.getMe_id());
		}
		//프로필 업데이트
		memberDao.mypageUpdate(input);
		//기존사진 가져오기
		
		
		//프로필 사진 업데이트
		uploadFile(file, user.getMe_id());
		return true;
	}
	
	//file upload 함수
	private void uploadFile(List<MultipartFile> file, String me_id) {
		if(file == null) return;
		for(MultipartFile tmpFile : file) {
			if(tmpFile != null && tmpFile.getOriginalFilename().length()!=0) {
				String path;
				try {
					path = UploadFileUtills.uploadProfile(uploadPath, tmpFile.getOriginalFilename(), tmpFile.getBytes(), me_id);
					MemberVO p = new MemberVO(path);
					p.setMe_id(me_id);
					//FileVO f = new FileVO(tmpFile.getOriginalFilename(), path, tr_num);
					memberDao.updateProfile(p);
					
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
		
	}

	
	
}

