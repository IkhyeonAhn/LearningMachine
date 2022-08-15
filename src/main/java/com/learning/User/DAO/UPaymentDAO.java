package com.learning.User.DAO;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.learning.User.DTO.ULectureDTO;
import com.learning.User.DTO.UPaymentDTO;
import com.learning.User.Form.URegiForm;

@Repository
public class UPaymentDAO {

	private final String namespace = "UPaymentMapper";
	
	@Autowired
	private SqlSession sqlSession;
	
	public int LectureRegist(URegiForm dto) {
		
		return sqlSession.insert(namespace + ".LectureRegist", dto);
	}
	
	public UPaymentDTO PaymentRegist(UPaymentDTO dto) {
		
		sqlSession.insert(namespace + ".PaymentRegist", dto);
		
		return dto;
	}
}
