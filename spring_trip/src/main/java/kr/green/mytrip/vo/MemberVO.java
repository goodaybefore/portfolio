package kr.green.mytrip.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class MemberVO {
	private String me_id;
	private String me_pw;
	private String me_name;
	private String me_gender;
	private String me_phone;
	private String me_email;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date me_birth;
	private String me_del;
	private String me_nickname;
	private String me_photo;
	private String me_gr_name;
	private String me_intro;
	private String me_membership;
	private String me_op_name;
	private Date me_last_date;
	private int me_attend_num;

	
}
