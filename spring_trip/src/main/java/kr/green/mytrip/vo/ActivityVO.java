package kr.green.mytrip.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;

@Data
public class ActivityVO {
	private int ac_num;
	private int ac_tr_num;
	private String ac_title;
	private String ac_me_id;
	private String ac_mca_name;//활동 중분류(숙박, 먹부림, 활동)
	private String ac_sca_name;//활동 소분류
	private String ac_address;
	private String ac_address_detail;
	private Date ac_start_date;
	private Date ac_end_date;
	private String ac_contents;
	private String ac_color;
	private String ac_op_name;
	private String ac_with;
	private String ac_del;
	private Date del_date;//삭제리스트에서 삭제날짜로 정렬하기위해 del_date 추가
	
	public String getAc_start_date_str() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String str = format.format(ac_start_date);
		return str;
	}
	public Date setAc_start_date_str(String ac_start_date) throws ParseException{
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		return this.ac_start_date = format.parse(ac_start_date);
	}
	
	
	public String getAc_end_date_str() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String str = format.format(ac_end_date);
		return str;
	}
	public Date setAc_end_date_str(String ac_end_date) throws ParseException{
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		return this.ac_end_date = format.parse(ac_end_date);
	}
	
	
	public String getDel_date_str() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy.MM.dd");
		String str = format.format(del_date);
		return str;
	}
	public Date setDel_date_str(String del_date) throws ParseException {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		return this.del_date = format.parse(del_date);
	}
}
