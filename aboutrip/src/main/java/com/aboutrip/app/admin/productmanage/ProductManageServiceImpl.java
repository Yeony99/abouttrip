package com.aboutrip.app.admin.productmanage;

import java.util.List;

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

	@Override
	public List<Product> listProduct() throws Exception {
		List<Product> list = null;
		try {
			list=dao.selectList("product.product_management_list");
			String category_name = "";
			for(int i=0; i<list.size(); i++) {
				switch (list.get(i).getCategory_num()) {
				case 1 : category_name = "패키지"; break;
				case 2 : category_name = "티켓 / 투어"; break;
				case 3 : category_name = "모바일"; break;
				case 4 : category_name = "패키지 이벤트"; break;
				case 5 : category_name = "티켓 / 투어 이벤트"; break;
				case 6 : category_name = "모바일 이벤트"; break;					
				}
				list.get(i).setCategory_name(category_name);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return list;
	}

	@Override
	public List<Product> listOptions() throws Exception {
		List<Product> list = null;
		try {
			list=dao.selectList("product.option_management_list");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
