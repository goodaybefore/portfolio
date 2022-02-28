package kr.green.mytrip.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	private int bd_num;
	private String bd_title;
	private String bd_contents;
	private String bd_me_id;
	private Date bd_date;
	private String bd_op_name;
	private String bd_type;
	
	public String getBd_date_str() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String str = format.format(bd_date);
		return str;
	}
}
