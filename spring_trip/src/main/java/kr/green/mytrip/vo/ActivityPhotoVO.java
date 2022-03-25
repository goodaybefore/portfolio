package kr.green.mytrip.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ActivityPhotoVO {
	private Integer ap_num;
	private Integer ap_ac_num;
	private String ap_name;
	private String ap_ori_name;
	
	public ActivityPhotoVO(String ap_ori_name, String ap_name, Integer ap_ac_num) {
		this.ap_ori_name = ap_ori_name;
		this.ap_name = ap_name;
		this.ap_ac_num = ap_ac_num;
	}
}

