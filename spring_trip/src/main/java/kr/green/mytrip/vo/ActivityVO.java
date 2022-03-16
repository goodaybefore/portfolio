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
	private String ac_mca_name;//활동 중분류(숙박, 먹부림, 활동)
	private String ac_sca_name;//활동 소분류
	private String ac_address;
	private Date ac_start_date;
	private Date ac_end_date;
	private String ac_contents;
	private String ac_color;
	private String ac_op_name;
	private String ac_with;
	private String ac_del;
	
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
		String str = format.format(ac_start_date);
		return str;
	}
	public Date setAc_end_date_str(String ac_end_date) throws ParseException{
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		return this.ac_end_date = format.parse(ac_end_date);
	}
	
}
