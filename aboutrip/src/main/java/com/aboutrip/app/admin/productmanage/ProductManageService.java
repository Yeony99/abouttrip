package com.aboutrip.app.admin.productmanage;

import com.aboutrip.app.product.Product;

public interface ProductManageService {
	public void insertProduct(Product dto, String pathname) throws Exception;
	public void insertProductDetail(Product dto) throws Exception;
	
	public Product readProduct(int code) throws Exception;
	
	public int countOption(int code) throws Exception;
}
