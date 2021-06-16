package com.aboutrip.app.admin.productmanage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aboutrip.app.common.FileManager;
import com.aboutrip.app.common.dao.AboutDAO;
import com.aboutrip.app.product.Product;

@Service("admin.productmanage.productManageService")
public class ProductManageServiceImpl implements ProductManageService{
	@Autowired
	AboutDAO dao;

	@Autowired
	private FileManager fileManager;

	@Override
	public void insertProduct(Product dto, String pathname) throws Exception {

		try {

			String saveFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
			if (saveFilename != null) {
				dto.setImg_name(saveFilename);
			}
			dao.insertData("product.insert_product", dto);
			dao.insertData("product.insert_product_image", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertProductDetail(Product dto) throws Exception {

		try {
			dao.insertData("product.insert_product_detail", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public Product readProduct(int code) throws Exception {
		Product dto = null;
		try {
			dto = dao.selectOne("product.product_read", code);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return dto;
	}
	
	@Override
	public int countOption(int code) throws Exception {
		int result = 0;
		try {
			result = dao.selectOne("product.option_count", code);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return result;
	}
}
