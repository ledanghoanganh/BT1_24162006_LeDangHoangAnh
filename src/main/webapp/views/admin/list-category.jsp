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
<title>Quản lý danh mục</title>
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

.top-navbar {
	background-color: #0099e6;
	color: white;
	padding: 12px 20px;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.top-navbar a {
	color: white;
	text-decoration: none;
}

.top-navbar .btn-logout {
	background-color: #e65100;
	padding: 5px 12px;
	border-radius: 3px;
	color: white;
}

.main-container {
	padding: 25px;
}

.content-box {
	background: #ffffff;
	padding: 20px 25px;
	border-radius: 4px;
	box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.table th, .table td {
	vertical-align: middle !important;
}

.cate-img {
	border-radius: 4px;
	object-fit: cover;
	border: 1px solid #ddd;
}
</style>
</head>
<body>
	<!-- Top Bar -->
	<div class="top-navbar">
		<div>
			<h4 style="margin: 0; font-weight: bold;">
				<i class="fa fa-dashboard"></i> Dashboard
			</h4>
		</div>
		<div>
			<span>Xin chào <strong>${sessionScope.account != null ? sessionScope.account.fullName : 'Admin'}</strong></span>
			<a href="<c:url value='/logout'/>" class="btn-logout" style="margin-left: 15px;">Đăng xuất</a>
		</div>
	</div>

	<!-- Main Content -->
	<div class="container-fluid main-container">
		<div class="content-box">
			<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
				<h3 style="margin: 0; color: #333;">Quản lý danh mục</h3>
				<a href="<c:url value='/admin/category/add'/>" class="btn btn-primary">
					<i class="fa fa-plus"></i> Thêm danh mục mới
				</a>
			</div>

			<table class="table table-bordered table-striped table-hover">
				<thead>
					<tr style="background-color: #f9f9f9;">
						<th style="width: 80px; text-align: center;">STT</th>
						<th style="width: 220px; text-align: center;">Hình ảnh</th>
						<th>Tên danh mục</th>
						<th style="width: 180px; text-align: center;">Hành động</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${cateList}" var="cate" varStatus="STT">
						<tr class="odd gradeX">
							<td style="text-align: center;">${STT.index + 1}</td>
							<td style="text-align: center;">
								<c:url value="/image?fname=${cate.icon}" var="imgUrl"></c:url>
								<img height="120" width="160" src="${imgUrl}" class="cate-img"
									onerror="this.src='https://via.placeholder.com/160x120?text=No+Image';" />
							</td>
							<td><strong>${cate.catename}</strong></td>
							<td style="text-align: center;">
								<a href="<c:url value='/admin/category/edit?id=${cate.id}'/>"
									class="btn btn-sm btn-info">
									<i class="fa fa-edit"></i> Sửa
								</a>
								<a href="<c:url value='/admin/category/delete?id=${cate.id}'/>"
									class="btn btn-sm btn-danger"
									onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');">
									<i class="fa fa-trash"></i> Xóa
								</a>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${empty cateList}">
						<tr>
							<td colspan="4" style="text-align: center; color: #888; padding: 20px;">
								Chưa có danh mục nào. Hãy bấm "Thêm danh mục mới".
							</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>
