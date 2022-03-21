package kr.green.mytrip.vo;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;

@Data
public class TripVO {
	private int tr_num;
	private String tr_me_id;
	private int tr_sm_num;
	private String tr_mca_name;//middlecategory name
	private String tr_sca_name;//smallcategory name
	private String tr_title;
	private Date tr_start_date;
	private Date tr_end_date;
	private String tr_color;
	private String tr_favorite;
	private String tr_op_name;
	private String tr_del;
	private Date del_date;//삭제리스트에서 삭제날짜로 정렬하기위해 del_date 추가
	private int tr_charge;
	private String tr_with;
	
	public String getTr_start_date_str() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy.MM.dd");
		String str = format.format(tr_start_date);
		return str;
	}
	public String getTr_end_date_str() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy.MM.dd");
		String str = format.format(tr_end_date);
		return str;
	}
	
	public Date setTr_start_date_str(String tr_start_date) throws ParseException{
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		return this.tr_start_date = format.parse(tr_start_date);
	}
	public Date setTr_end_date_str(String tr_end_date) throws ParseException {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		return this.tr_end_date = format.parse(tr_end_date);
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
