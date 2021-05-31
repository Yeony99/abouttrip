package com.aboutrip.app.common.dao;

public interface AboutDAO {
	public <T> T selectOne(String id, Object value) throws Exception;
	
}
