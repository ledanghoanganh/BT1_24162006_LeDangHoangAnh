<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng nhập hệ thống</title>
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

.login-container {
	max-width: 420px;
	margin: 70px auto 20px auto;
	background: #ffffff;
	padding: 30px 35px 30px 35px;
	border: 1px solid #e0e0e0;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
}

.login-container h2 {
	font-size: 20px;
	color: #777777;
	text-align: center;
	margin-top: 0;
	margin-bottom: 25px;
	font-weight: 500;
}

.input-group {
	margin-bottom: 15px;
	width: 100%;
}

.input-group-addon {
	background-color: #ffffff;
	border-right: none;
	color: #999999;
	width: 42px;
}

.form-control {
	border-left: none;
	height: 42px;
	background-color: #f3f8fd;
	box-shadow: none;
}

.form-control:focus {
	border-color: #66afe9;
	box-shadow: none;
	background-color: #ffffff;
}

.btn-login {
	background-color: #0099e6;
	border-color: #0088cc;
	color: #ffffff;
	height: 42px;
	font-size: 15px;
	font-weight: 500;
	border-radius: 2px;
	margin-top: 5px;
}

.btn-login:hover, .btn-login:focus {
	background-color: #0088cc;
	color: #ffffff;
}

.login-options {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 15px;
	font-size: 13px;
	color: #666666;
}

.login-options label {
	font-weight: normal;
	margin-bottom: 0;
	cursor: pointer;
}

.login-options a {
	color: #777777;
	text-decoration: none;
}

.login-options a:hover {
	text-decoration: underline;
}

.register-link {
	text-align: center;
	color: #777777;
	font-size: 13px;
	margin-top: 20px;
}

.register-link a {
	color: #0099e6;
	text-decoration: none;
}

.register-link a:hover {
	text-decoration: underline;
}

.alert-danger {
	font-size: 14px;
	padding: 10px;
	margin-bottom: 15px;
}
</style>
</head>
<body>
	<div class="login-container">
		<form action="login" method="post">
			<h2>Đăng Nhập Vào Hệ Thống</h2>

			<c:if test="${alert != null}">
				<h3 class="alert alert-danger">${alert}</h3>
			</c:if>

			<section>
				<label class="input login-input" style="width: 100%;">
					<div class="input-group">
						<span class="input-group-addon"><i class="fa fa-user"></i></span>
						<input type="text" placeholder="Tài khoản" name="username"
							class="form-control" required>
					</div>
				</label>
			</section>

			<section>
				<label class="input login-input" style="width: 100%;">
					<div class="input-group">
						<span class="input-group-addon"><i class="fa fa-lock"></i></span>
						<input type="password" placeholder="Mật khẩu" name="password"
							class="form-control" required>
					</div>
				</label>
			</section>

			<div class="login-options">
				<label>
					<input type="checkbox" name="remember" value="ok"> Nhớ tôi
				</label>
				<a href="#">Quên mật khẩu?</a>
			</div>

			<button type="submit" class="btn btn-login btn-block">Đăng nhập</button>
		</form>
	</div>

	<div class="register-link">
		Nếu bạn chưa có tài khoản trên hệ thống, thì hãy <a
			href="<c:url value='/register'/>">Đăng ký</a>
	</div>
</body>
</html>
