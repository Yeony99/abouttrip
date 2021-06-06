package com.aboutrip.app.common.dao;

import java.util.List;

public interface AboutDAO {
	public <T> T selectOne(String id, Object value) throws Exception;
	public <T> T selectOne(String id) throws Exception;
	public int insertData(String id, Object value) throws Exception;
	public int updateData(String id, Object value) throws Exception;
	public int deleteData(String id, Object value)	throws Exception;
	
	public <T> List<T> selectList(String id, Object value) throws Exception;
	public <T> List<T> selectList(String id) throws Exception;
}
