package baitap1.service;

import java.util.List;
import baitap1.model.Category;

public interface CategoryService {
	void insert(Category category);

	void edit(Category category);

	void update(Category category);

	void delete(int id);

	Category get(int id);

	Category findById(int id);

	Category get(String name);

	List<Category> getAll();

	List<Category> search(String keyword);
}
