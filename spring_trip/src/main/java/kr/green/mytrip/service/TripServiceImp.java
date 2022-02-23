package kr.green.mytrip.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.green.mytrip.dao.TripDAO;

@Service
public class TripServiceImp implements TripService{
	@Autowired
	TripDAO tripDao;
}
