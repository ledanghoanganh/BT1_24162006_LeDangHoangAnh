<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tạo tài khoản mới</title>
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

.register-container {
	max-width: 420px;
	margin: 50px auto 20px auto;
	background: #ffffff;
	padding: 30px 35px 30px 35px;
	border: 1px solid #e0e0e0;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
}

.register-container h2 {
	font-size: 20px;
	color: #666666;
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

.btn-register {
	background-color: #0099e6;
	border-color: #0088cc;
	color: #ffffff;
	height: 42px;
	font-size: 15px;
	font-weight: 500;
	border-radius: 2px;
	margin-top: 10px;
}

.btn-register:hover, .btn-register:focus {
	background-color: #0088cc;
	color: #ffffff;
}

.login-link {
	text-align: center;
	color: #777777;
	font-size: 13px;
	margin-top: 20px;
}

.login-link a {
	color: #0099e6;
	text-decoration: none;
}

.login-link a:hover {
	text-decoration: underline;
}

.alert-danger {
	font-size: 14px;
	padding: 10px;
	margin-bottom: 15px;
}
</style>
<script>
function validateRegister() {
	var password = document.getElementsByName("password")[0].value;
	var repassword = document.getElementsByName("repassword")[0].value;
	if (password !== repassword) {
		alert("Mật khẩu nhập lại không khớp!");
		return false;
	}
	return true;
}
</script>
</head>
<body>
	<div class="register-container">
		<form action="register" method="post" onsubmit="return validateRegister();">
			<h2>Tạo tài khoản mới</h2>

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
						<span class="input-group-addon"><i class="fa fa-user"></i></span>
						<input type="text" placeholder="Họ tên" name="fullname"
							class="form-control" required>
					</div>
				</label>
			</section>

			<section>
				<label class="input login-input" style="width: 100%;">
					<div class="input-group">
						<span class="input-group-addon"><i class="fa fa-envelope"></i></span>
						<input type="email" placeholder="Nhập Email" name="email"
							class="form-control" required>
					</div>
				</label>
			</section>

			<section>
				<label class="input login-input" style="width: 100%;">
					<div class="input-group">
						<span class="input-group-addon"><i class="fa fa-phone"></i></span>
						<input type="text" placeholder="Số điện thoại" name="phone"
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

			<section>
				<label class="input login-input" style="width: 100%;">
					<div class="input-group">
						<span class="input-group-addon"><i class="fa fa-lock"></i></span>
						<input type="password" placeholder="Nhập lại mật khẩu"
							name="repassword" class="form-control" required>
					</div>
				</label>
			</section>

			<button type="submit" class="btn btn-register btn-block">Tạo tài khoản</button>
		</form>
	</div>

	<div class="login-link">
		Nếu bạn đã có tài khoản? <a href="<c:url value='/login'/>">Đăng nhập</a>
	</div>
</body>
</html>
