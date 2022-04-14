package kr.green.mytrip.vo;

import java.util.Date;

import lombok.Data;

@Data
public class TripmateRequestVO {
	private int tq_num;
	private String tq_request_id;
	private String tq_receive_id;
	private Date tq_date;
}
