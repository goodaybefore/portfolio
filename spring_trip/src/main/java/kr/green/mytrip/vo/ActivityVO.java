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
	private String ac_address;
	private Date ac_date;
	private String ac_contents;
	private String ac_color;
	private String ac_op_name;
	private String ac_del;
	
	public String getAc_date_str() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String str = format.format(ac_date);
		return str;
	}
	public Date setAc_date_str(String ac_date) throws ParseException{
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		return this.ac_date = format.parse(ac_date);
	}
}
