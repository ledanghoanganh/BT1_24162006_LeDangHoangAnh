<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:if test="${empty sessionScope.account}">
	<c:redirect url="/login" />
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HelloWorld - Trang chủ</title>
<!-- Bootstrap 3.4.1 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<!-- Font Awesome 4.7.0 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body {
	background-color: #f7f7f7;
	font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
}

.home-container {
	max-width: 460px;
	margin: 80px auto 20px auto;
	background: #ffffff;
	padding: 35px 35px 30px 35px;
	border: 1px solid #e0e0e0;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
	text-align: center;
}

.alert-success {
	font-size: 16px;
	padding: 14px;
	margin-bottom: 25px;
	border-radius: 3px;
	font-weight: 500;
}

.btn-login {
	background-color: #0099e6;
	border-color: #0088cc;
	color: #ffffff;
	height: 44px;
	font-size: 15px;
	font-weight: 500;
	border-radius: 2px;
	line-height: 30px;
}

.btn-login:hover, .btn-login:focus {
	background-color: #0088cc;
	color: #ffffff;
}

.btn-register-alt {
	background-color: #ffffff;
	border: 1px solid #d0d0d0;
	color: #555555;
	height: 44px;
	font-size: 15px;
	font-weight: 500;
	border-radius: 2px;
	line-height: 30px;
	margin-top: 12px;
}

.btn-register-alt:hover {
	background-color: #f0f0f0;
	color: #333333;
}

.footer-text {
	text-align: center;
	color: #888888;
	font-size: 13px;
	margin-top: 20px;
}
</style>
</head>
<body>
	<div class="home-container">
		<div class="alert alert-success">
			<i class="fa fa-check-circle"></i> Đăng nhập thành công
		</div>

		<c:if test="${sessionScope.account != null && sessionScope.account.roleid == 1}">
			<a href="<c:url value='/admin/category/list'/>" class="btn btn-login btn-block">
				<i class="fa fa-th-list"></i> Quản lý danh mục (CRUD Category)
			</a>
		</c:if>

		<a href="<c:url value='/'/>" class="btn btn-register-alt btn-block">
			<i class="fa fa-home"></i> Về trang chính
		</a>
	</div>
</body>
</html>
