<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<c:if test="${empty sessionScope.account || sessionScope.account.roleid != 1}">
	<c:redirect url="/login" />
</c:if>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thêm danh mục mới</title>
<!-- Bootstrap 3.4.1 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<!-- Font Awesome 4.7.0 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
body {
	background-color: #f5f5f5;
	font-family: Arial, sans-serif;
}

.box-form {
	max-width: 600px;
	margin: 50px auto;
	background: #ffffff;
	padding: 30px;
	border-radius: 4px;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.box-form h2 {
	margin-top: 0;
	margin-bottom: 25px;
	font-size: 22px;
	color: #333;
	border-bottom: 1px solid #eee;
	padding-bottom: 10px;
}
</style>
</head>
<body>
	<div class="container">
		<div class="box-form">
			<h2>Thêm danh mục mới</h2>

			<form role="form" action="add" method="post" enctype="multipart/form-data">
				<div class="form-group">
					<label>Tên danh mục:</label>
					<input class="form-control" placeholder="please enter category Name"
						name="catename" required />
				</div>

				<div class="form-group">
					<label>Ảnh đại diện:</label>
					<input type="file" name="icon" class="form-control" />
				</div>

				<div style="margin-top: 20px;">
					<button type="submit" class="btn btn-default" style="background-color: #e0e0e0; font-weight: bold;">Thêm</button>
					<button type="reset" class="btn btn-primary">Hủy</button>
					<a href="<c:url value='/admin/category/list'/>" class="btn btn-link" style="margin-left: 10px;">Quay lại danh sách</a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
