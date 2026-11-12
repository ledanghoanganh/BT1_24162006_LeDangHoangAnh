package baitap1.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import baitap1.config.Constant;

@WebServlet(urlPatterns = "/logout")
public class LogoutController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		resp.setHeader("Pragma", "no-cache");
		resp.setDateHeader("Expires", 0);

		HttpSession session = req.getSession(false);
		if (session != null) {
			session.removeAttribute("account");
			session.removeAttribute("username");
			session.invalidate();
		}

		Cookie[] cookies = req.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (Constant.COOKIE_REMEMBER.equals(cookie.getName())) {
					cookie.setValue("");
					cookie.setMaxAge(0);
					cookie.setPath(req.getContextPath().isEmpty() ? "/" : req.getContextPath());
					resp.addCookie(cookie);

					Cookie rootCookie = new Cookie(Constant.COOKIE_REMEMBER, "");
					rootCookie.setValue("");
					rootCookie.setMaxAge(0);
					rootCookie.setPath("/");
					resp.addCookie(rootCookie);
				}
			}
		}

		resp.sendRedirect(req.getContextPath() + "/login");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
