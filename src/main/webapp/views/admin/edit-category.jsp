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
<title>Chỉnh sửa danh mục</title>
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
			<h2>Chỉnh sửa danh mục</h2>

			<c:url value="/admin/category/edit" var="edit"></c:url>
			<form role="form" action="${edit}" method="post" enctype="multipart/form-data">
				<input name="id" value="${category.cateid}" hidden="" />

				<div class="form-group">
					<label>Tên danh sách:</label>
					<input type="text" class="form-control" value="${category.name}"
						name="catename" required />
				</div>

				<div class="form-group">
					<label>Ảnh hiện tại:</label><br />
					<c:url value="/image?fname=${category.icon}" var="imgUrl"></c:url>
					<img class="img-responsive img-thumbnail" width="120px" src="${imgUrl}"
						onerror="this.src='https://via.placeholder.com/120?text=No+Image';"
						alt="" style="margin-bottom: 10px;" />
					<br />
					<label>Chọn ảnh đại diện mới:</label>
					<input type="file" name="icon" class="form-control" />
				</div>

				<div style="margin-top: 20px;">
					<button type="submit" class="btn btn-default" style="background-color: #e0e0e0; font-weight: bold;">Edit</button>
					<button type="reset" class="btn btn-primary">Reset</button>
					<a href="<c:url value='/admin/category/list'/>" class="btn btn-link" style="margin-left: 10px;">Quay lại danh sách</a>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
