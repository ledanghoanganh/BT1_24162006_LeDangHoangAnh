package baitap1.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import baitap1.config.Constant;
import baitap1.model.Category;
import baitap1.service.CategoryService;
import baitap1.service.impl.CategoryServiceImpl;

@WebServlet(urlPatterns = { "/admin/category/edit" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 5 * 5)
public class CategoryEditController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	CategoryService cateService = new CategoryServiceImpl();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter("id");
		if (id != null) {
			Category category = cateService.get(Integer.parseInt(id));
			req.setAttribute("category", category);
		}
		RequestDispatcher dispatcher = req.getRequestDispatcher("/views/admin/edit-category.jsp");
		dispatcher.forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");

		Category category = new Category();
		String idParam = req.getParameter("id");
		if (idParam == null || idParam.isEmpty()) {
			idParam = req.getParameter("cateid");
		}
		int categoryid = Integer.parseInt(idParam);
		String categoryname = req.getParameter("catename");

		category.setCateId(categoryid);
		category.setCateName(categoryname);

		// Lưu hình cũ
		Category cateold = cateService.findById(categoryid);
		String fileold = (cateold != null && cateold.getIcon() != null) ? cateold.getIcon() : "avata.png";

		// Xử lý images
		String fname = "";
		String uploadPath = Constant.UPLOAD_DIRECTORY;
		File uploadDir = new File(uploadPath);
		if (!uploadDir.exists()) {
			uploadDir.mkdirs();
		}

		try {
			Part part = req.getPart("icon");
			if (part == null || part.getSize() == 0) {
				part = req.getPart("images");
			}

			if (part != null && part.getSize() > 0) {
				String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
				int index = filename.lastIndexOf(".");
				String ext = (index > 0) ? filename.substring(index + 1) : "png";
				fname = System.currentTimeMillis() + "." + ext;
				part.write(uploadPath + File.separator + fname);
				category.setIcon(fname);
			} else {
				category.setIcon(fileold);
			}
		} catch (Exception e) {
			e.printStackTrace();
			category.setIcon(fileold);
		}

		cateService.update(category);
		resp.sendRedirect(req.getContextPath() + "/admin/category/list");
	}
}
