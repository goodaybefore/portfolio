package kr.green.mytrip.vo;

import lombok.Data;

@Data
public class FileVO {
	private int fi_num;
	private int fi_tr_num;
	private String fi_ori_name;
	private String fi_name;
	private String fi_del;
	
	public FileVO(String fi_ori_name, String fi_name, int fi_tr_num) {
		this.fi_ori_name = fi_ori_name;
		this.fi_name = fi_name;
		this.fi_tr_num = fi_tr_num;
	}
}

