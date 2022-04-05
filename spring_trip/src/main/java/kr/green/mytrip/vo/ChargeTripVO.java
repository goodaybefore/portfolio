package kr.green.mytrip.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ChargeTripVO {
	private int ch_num;
	private String ch_me_id;//결제자 아이디
	private int ch_amount;//결제 금액
	private int ch_tr_num;//결제번호
	private Date ch_date;//결제날짜

}
