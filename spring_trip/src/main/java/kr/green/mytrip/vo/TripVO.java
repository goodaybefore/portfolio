package kr.green.mytrip.vo;

import java.util.Date;

import lombok.Data;

@Data
public class TripVO {
	private int tr_num;
	private String tr_me_id;
	private int st_sm_num;
	private int tr_sc_num;
	private String tr_title;
	private Date tr_start_date;
	private Date tr_end_date;
	private String tr_color;
	private String tr_favorite;
	private String tr_op_name;
	private String tr_del;
	private int tr_charge;
}
