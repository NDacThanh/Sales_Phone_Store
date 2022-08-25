<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<base href="${pageContext.servletContext.contextPath}/">
<%@include file="/WEB-INF/views/include/header.jsp"%>
<%@include file="/WEB-INF/views/include/adminMenu.jsp"%>
<div class="container-fluid">
	<div class="row">
		<div class="col-3">
			<%@include file="/WEB-INF/views/include/adminTool.jsp"%>
		</div>
		
		<div class="col-9 mbg-azure py-2">
			<div class="card-group">
				<div class="card">
					<!-- <img class="card-img-top rounded" src="resources/images/users/.jpg" width="250" height="260" alt="Card image cap"> -->
					<div class="card-body">
						<h5 class="card-title">Thành viên 1</h5>
						<p class="card-text">Đỗ Huy Hoàng</p>
						<p class="card-text">MSSV: N18DCCN063</p>
						<p class="card-text">Lớp: D19CQCN02-N</p>
					</div>
				</div>
				<div class="card">
					<!-- <img class="card-img-top rounded" src="resources/images/users/.jpg" width="250" height="260" alt="Card image cap"> -->
					<div class="card-body">
						<h5 class="card-title">Thành viên 2</h5>
						<p class="card-text">Nguyễn Phúc Thịnh</p>
						<p class="card-text">MSSV: N19DCCN197</p>
						<p class="card-text">Lớp: D19CQCN02-N</p>
					</div>
				</div>
				<div class="card">
					<!-- <img class="card-img-top rounded" src="resources/images/users/dt.jpg" width="250" height="260" alt="Card image cap"> -->
					<div class="card-body">
						<h5 class="card-title">Thành viên 3</h5>
						<p class="card-text">Nguyễn Đắc Thành</p>
						<p class="card-text">MSSV: N19DCCN191</p>
						<p class="card-text">Lớp: D19CQCN02-N</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@include file="/WEB-INF/views/include/adminFooter.jsp"%>