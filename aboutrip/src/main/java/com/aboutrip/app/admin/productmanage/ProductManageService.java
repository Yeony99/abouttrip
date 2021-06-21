package com.aboutrip.app.admin.productmanage;

import java.util.List;
import java.util.Map;

import com.aboutrip.app.product.Product;

public interface ProductManageService {
	public void insertProduct(Product dto, String pathname) throws Exception;
	public void insertProductDetail(Product dto) throws Exception;
	
	public void updateProduct(Product dto, String pathname) throws Exception;
	public void updateOption(Product dto) throws Exception;
	
	public void deleteProduct(int code) throws Exception;
	public void deleteOption(int detail_num) throws Exception;
	
	public Product readProduct(int code) throws Exception;
	public Product readDetail(int detail_num) throws Exception;

	public List<Product> listProduct(Map<String,Object> map) throws Exception;
	public List<Product> listOptions() throws Exception;
	
	public int listCount(Map<String, Object> map);
	public int countOption(int code) throws Exception;
}
