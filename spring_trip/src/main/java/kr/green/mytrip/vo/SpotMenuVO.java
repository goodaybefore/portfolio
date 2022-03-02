package kr.green.mytrip.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class SpotMenuVO {
	private int sm_num;
	private String sm_me_id;
	private String sm_name;
	
	public SpotMenuVO(String sm_me_id) {
		this.sm_me_id = sm_me_id;
		this.sm_name ="기본메뉴";
	}
}


