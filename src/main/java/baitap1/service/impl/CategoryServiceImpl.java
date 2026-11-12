package baitap1.service.impl;

import java.io.File;
import java.util.List;

import baitap1.config.Constant;
import baitap1.dao.CategoryDao;
import baitap1.dao.impl.CategoryDaoImpl;
import baitap1.model.Category;
import baitap1.service.CategoryService;

public class CategoryServiceImpl implements CategoryService {
	CategoryDao categoryDao = new CategoryDaoImpl();

	@Override
	public void insert(Category category) {
		categoryDao.insert(category);
	}

	@Override
	public void edit(Category newCategory) {
		Category oldCategory = categoryDao.get(newCategory.getId());
		if (oldCategory != null) {
			oldCategory.setName(newCategory.getName());
			if (newCategory.getIcon() != null && !newCategory.getIcon().isEmpty()) {
				// XOA ANH CU DI (neu co va khac anh mac dinh)
				String fileName = oldCategory.getIcon();
				if (fileName != null && !fileName.isEmpty() && !fileName.equals("avata.png")) {
					File file = new File(Constant.UPLOAD_DIRECTORY + "/" + fileName);
					if (file.exists()) {
						file.delete();
					}
				}
				oldCategory.setIcon(newCategory.getIcon());
			}
			categoryDao.edit(oldCategory);
		}
	}

	@Override
	public void update(Category category) {
		edit(category);
	}

	@Override
	public void delete(int id) {
		Category category = categoryDao.get(id);
		if (category != null && category.getIcon() != null && !category.getIcon().equals("avata.png")) {
			File file = new File(Constant.UPLOAD_DIRECTORY + "/" + category.getIcon());
			if (file.exists()) {
				file.delete();
			}
		}
		categoryDao.delete(id);
	}

	@Override
	public Category get(int id) {
		return categoryDao.get(id);
	}

	@Override
	public Category findById(int id) {
		return categoryDao.get(id);
	}

	@Override
	public Category get(String name) {
		return categoryDao.get(name);
	}

	@Override
	public List<Category> getAll() {
		return categoryDao.getAll();
	}

	@Override
	public List<Category> search(String keyword) {
		return categoryDao.search(keyword);
	}
}
