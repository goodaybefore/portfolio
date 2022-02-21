package kr.green.mytrip.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.green.mytrip.dao.BoardDAO;
import kr.green.mytrip.vo.BoardVO;
import kr.green.mytrip.vo.MemberVO;

@Service
public class BoardServiceImp implements BoardService{
	@Autowired
	BoardDAO boardDao;

	@Override
	public boolean registerBoard(BoardVO board, MemberVO user) {
		if( board.getBd_me_id()==null || board == null || board.getBd_title().trim().length() == 0 ||
				board.getBd_contents().trim().length() == 0) {
			System.out.println(user.getMe_gr_name());
			System.out.println(board);
			return false;
		}
		if(user.getMe_id().equals(board.getBd_me_id()) && (user.getMe_gr_name().equals("트립매니저") ||
				user.getMe_gr_name().equals("트립파트너")) ) {
			board.setBd_type("notice");
			boardDao.insertBoard(board);
			return true;
		}
		return false;
	}
	
	
}
