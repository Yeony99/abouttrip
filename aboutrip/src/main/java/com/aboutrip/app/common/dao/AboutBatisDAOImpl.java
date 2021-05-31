package com.aboutrip.app.common.dao;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;



@Repository("dao")
public class AboutBatisDAOImpl implements AboutDAO{
	@Autowired
	private SqlSession sqlSession;

	private final Logger logger=LoggerFactory.getLogger(getClass());
	
	@Override
	public <T> T selectOne(String id, Object value) throws Exception {
		try {
			return sqlSession.selectOne(id, value);
		} catch (Exception e) {
			logger.error(e.toString());
			
			throw e;
		}
	}
	
}
