package baitap1.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import baitap1.model.User;

@WebFilter(urlPatterns = { "/admin/*", "/views/admin/*" })
public class AdminFilter implements Filter {

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;

		// Ngăn chặn trình duyệt lưu cache trang admin (ngăn bấm nút Back sau khi đăng xuất)
		resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		resp.setHeader("Pragma", "no-cache");
		resp.setDateHeader("Expires", 0);

		HttpSession session = req.getSession(false);
		User user = (session != null) ? (User) session.getAttribute("account") : null;

		// 1. Chưa đăng nhập -> chuyển hướng về trang login
		if (user == null) {
			resp.sendRedirect(req.getContextPath() + "/login");
			return;
		}

		// 2. Đã đăng nhập nhưng không phải admin (roleid != 1) -> không có quyền vào /admin/*
		if (user.getRoleid() != 1) {
			resp.sendRedirect(req.getContextPath() + "/home");
			return;
		}

		// 3. Đúng quyền admin -> cho phép truy cập
		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {
	}
}
