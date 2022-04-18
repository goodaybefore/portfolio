package kr.green.mytrip.service;

import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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
	
	@Autowired
	private JavaMailSender mailSender;
	//집
	//String uploadPath = "E:\\2021\\portfolio\\member_profile";
	//학원
	String uploadPath = "E:\\portfolio_gny\\member_profile";
	//signup
	@Override
	public boolean insertMember(MemberVO member) {
		if(member.getMe_id()==null || member.getMe_pw()==null || member.getMe_pw().length()==0) return false;
		if(member.getMe_id().equals("guest"))return false;
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
	
	@Override
	public boolean idDuplicated(String id) {
		MemberVO user = memberDao.selectMember(id);
		if(user == null) return false;
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
	public MemberVO mypageUpdate(MemberVO user, MemberVO input, List<MultipartFile> file) {
		System.out.println("user.getMeid : "+user.getMe_id()+", input.getMeid : "+input.getMe_id());
		if(!user.getMe_id().equals(input.getMe_id())) return null;
		input.setMe_id(user.getMe_id());
		
		if(input.getMe_pw()==null || input.getMe_pw().length()==0) {
			input.setMe_pw(user.getMe_pw());
		}else {
			String encPw = passwordEncoder.encode(input.getMe_pw());
			input.setMe_pw(encPw);
		}
		System.out.println("input : "+input);
		//프로필 업데이트
		memberDao.mypageUpdate(input);
		//기존사진 가져오기
		
		
		//프로필 사진 업데이트
		uploadFile(file, user.getMe_id());
		return input;
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
					System.out.println("p:"+p);
					//FileVO f = new FileVO(tmpFile.getOriginalFilename(), path, tr_num);
					memberDao.updateProfile(p);
					
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
		
	}

	@Override
	public String findId(MemberVO member) {
		if(member == null || member.getMe_email()==null || member.getMe_name()==null) return null;
		MemberVO findUser = memberDao.selectMemberByEmail(member);
		if(findUser == null) return null;
		return findUser.getMe_id();
	}
	
	@Override
	public String findPw(MemberVO member) {
		if(member == null || member.getMe_email()==null || member.getMe_id()==null) return "false";
		MemberVO dbuser = memberDao.selectMember(member.getMe_id());
		if(dbuser == null || !dbuser.getMe_id().equals(member.getMe_id())) return "false";
		
		//랜덤한 n자리 숫자 만들기
		String newPw = createRandom(6);
		//비번 암호화해서 DB에 저장
		String encPw = passwordEncoder.encode(newPw);
		dbuser.setMe_pw(encPw);
		memberDao.updateMember(dbuser);
		
		//변경된 비밀번호를 이메일로 보내주기
		String setfrom = "goodaybefore@gmail.com";         
	    String tomail  = member.getMe_email();     // 받는 사람 이메일
	    String title   = "변경된 비밀번호 안내";      // 제목
	    String content = "변경된 비밀번호는 "+newPw+" 입니다.";    // 내용

	    try {
	        MimeMessage message = mailSender.createMimeMessage();
	        MimeMessageHelper messageHelper 
	            = new MimeMessageHelper(message, true, "UTF-8");

	        messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
	        messageHelper.setTo(tomail);     // 받는사람 이메일
	        messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
	        messageHelper.setText(content);  // 메일 내용
	        mailSender.send(message);
	    } catch(Exception e){
	        System.out.println(e);
	        return "errer";
	    }
		
		return "true";
	}
	private String createRandom(int size) {
		String newPw = "";
		//size 길이만큼 만들어야하니까
		for(int i=1;i<=size;i++) {
			int max = 62, min = 1;
			//int rand = (int)(Math.random()*(max - min + 1)+min);
			int rand = (int)(Math.random()*62);
			
			if(rand>=0 && rand <10) {
				newPw += (char)('0' + rand);//'0'으로부터 rand번째에 있는 char
			}else if(rand < 36) {
				newPw += (char)('a' + (rand - 10));
			}else if(rand < 62) {
				newPw += (char)('A' + (rand - 36));
			}
		}
		return newPw;
	}

	//메뉴 수정
	@Override
	public String setMenu(Map<String, Object> data, MemberVO user) {
		SpotMenuVO menu = new SpotMenuVO();
		
		String type = (String)data.get("type");
		System.out.println("type : "+type);
		menu.setSm_name((String) data.get("sm_name"));
		if(type.equals("mod") || type.equals("del")) {
			String tmp = (String)data.get("sm_num");
			Integer smNum = Integer.parseInt(tmp);
			menu.setSm_num(smNum);
		}
		
		menu.setSm_me_id(user.getMe_id());
		Integer menuCnt = memberDao.selectMenuCnt(user.getMe_id());
		System.out.println("바뀔 menu : "+menu);
		if(type.equals("add")) {
			//메뉴가 5개인지 체크
			if(menuCnt>=5) return "menuCntOver";
			memberDao.insertSpotMenu(menu);
			return "true";
		}
		if(type.equals("mod")) {
			memberDao.modifySpotMenu(menu);
			return "true";
		}
		if(type.equals("del")) {
			if(menuCnt == 1) return "menuCntLack";
			memberDao.deleteSpotMenu(menu);
			return "true";
		}
		return "false";
	}

	

	
	
}

