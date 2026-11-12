package baitap1.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;

import baitap1.config.Constant;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/image") // ?fname=abc.png
public class DownloadImageController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String fileName = req.getParameter("fname");
		if (fileName != null && !fileName.isEmpty()) {
			File file = new File(Constant.UPLOAD_DIRECTORY + File.separator + fileName);
			if (file.exists()) {
				if (fileName.toLowerCase().endsWith(".png")) {
					resp.setContentType("image/png");
				} else if (fileName.toLowerCase().endsWith(".gif")) {
					resp.setContentType("image/gif");
				} else {
					resp.setContentType("image/jpeg");
				}
				try (FileInputStream fis = new FileInputStream(file)) {
					IOUtils.copy(fis, resp.getOutputStream());
				}
			}
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
