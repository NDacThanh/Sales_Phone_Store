<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<base href="${pageContext.servletContext.contextPath}/">
<%@include file="/WEB-INF/views/include/header.jsp"%>
<%@include file="/WEB-INF/views/include/menu.jsp"%>
	<br>
	
<div class="container">
	<div class="row">
  		<div class="col-6 text-center">
			<img class="img-product rounded card-img-top mb-5 mb-md-0 border border-info" src="resources/images/products/${product.image }" alt="...">
		</div>
		
  		<div class="col-6">
	  		<div class="mt-5">
	  			<h3 class="fw-bolder">${product.name }</h3>
	  			
	  			<div class="text-muted my-2">Đã bán: ${product.sold_quantity } </div>
	  			
	  			<div class="fs-5 mb-4 mt-4 p-2 mbg-price">
	            	<span class="text-decoration-line-through fs-6 text-muted"><f:formatNumber value="${product.price }" type="currency" currencySymbol="đ" maxFractionDigits="0"/></span>
	            	<span class="fs-3"><f:formatNumber value="${product.price - (product.price * product.discount / 100) }" type="currency" currencySymbol="đ" maxFractionDigits="0"/></span>
	            </div>
            
				<hr>            
            	<c:forEach var="s" items="${requestScope.pr}">
			 		<%-- <button type="button" class="btn btn-outline-info px-4 mx-2" >${s.specification}</button> --%>
			 		<a class="btn btn-outline-dark mt-auto" href="home/product.htm?id=${s.id}">${s.specification}</a>
				</c:forEach>
            	<div class="my-2 fs-5">Số lượng: </div>
            	
            	
			
				<span class="text-muted px-3 my-2 fs-6">${product.quantity - product.sold_quantity } sản phẩm có sẵn </span>
				
				<div class="my-4">
				<c:choose>
					<c:when test="${not empty message }">
						<button type="button" class="btn btn-info"><i class="fas fa-cart-plus"></i> Đã thêm vào giỏ hàng</button>
					</c:when>
					<c:otherwise>
						<c:choose>
							<c:when test="${product.quantity > product.sold_quantity }">
								<a href="user/addCart.htm?id=${product.id }"><button type="button" class="btn btn-outline-info"><i class="fas fa-cart-plus"></i> Thêm vào giỏ hàng</button></a>
							</c:when>
							<c:otherwise>
								<button type="button" class="btn btn-danger"><i class="fas fa-cart-plus"></i> Hết hàng</button>
							</c:otherwise>
						</c:choose>
					</c:otherwise>
				</c:choose>
				</div>
            </div>
  		</div>
	</div>
	
	<div class="card border border-info mx-5 my-3" style="width: 65rem;">
		<div class="m-1 p-2 mbg-azure h5">MÔ TẢ SẢN PHẨM</div> <!-- Mấy cái chưa có show ở trên như brand, category... nhét vô đây hết nha  -->
		<div class="m-1 p-2 ">
		<p>Thể loại: ${product.categories.name }</p>
		<p>Dung lượng:  ${product.specification }</p>
		<p>Sản phẩm kèm theo: ${product.calculation_unit }</p>
		<p>Giới thiệu: ${product.description }</p>
		
		<p> Cấu hình Điện thoại</p>
		<%-- </div>
		<div class="parameter">
		<ul class="parameter__list 267871 active">
		<li data-id="6459" data-group-id="8" data-index="1">
			<div class="lileft">
				<p>Công nghệ màn hình:</p>
			</div>
			<div class="liright">
				<p> ${product.display }</p>
			</div>
		<li>	
		</div> --%>
		<p>Màn Hình &emsp;&emsp; &emsp; : ${product.display }</p>
		<p>Độ phân giải &emsp; &emsp;: ${product.resolution }</p>
		<p>Hệ điều hành &emsp;&emsp;: ${product.system }</p>
		<p>Chip xử lí (CPU) &emsp;: ${product.CPU }</p>
		<p>Dung lượng RAM : ${product.RAM }</p>
		<p>SIM &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;: ${product.SIM }</p>
		<p>Pin &emsp; &emsp;&emsp;&emsp;&emsp;&emsp;: ${product.battery }</p> 

		
	</div>
	
	<div class="card border border-info mx-5 my-3" style="width: 65rem;">
		<div class="m-1 p-2 mbg-azure h5">ĐÁNH GIÁ SẢN PHẨM</div>
		
		<!-- Sau dùng JSTL để xuất -->
		<c:forEach var="s" items="${product.feedback}">
			<div class="mx-5 my-2 p-2 border-bottom">
				<div class="row">
					<div class="col-auto">
						<img src="${s.user.image }" class="rounded-circle" style="width: 50px; height: 50px;">
					</div>
					
					<div class="col">
						<div class="h6">${s.user.firstName } ${s.user.lastName }</div>
						<div>${s.date }</div>
						<div>
							<c:choose>
								<c:when test="${s.vote == 1}">
									<i class="fas fa-star"></i>
								</c:when>
								<c:when test="${s.vote == 2}">
									<i class="fas fa-star"></i><i class="fas fa-star"></i>
								</c:when>
								<c:when test="${s.vote == 3}">
									<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
								</c:when>
								<c:when test="${s.vote == 4}">
									<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
								</c:when>
								<c:when test="${s.vote == 5}">
									<i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
								</c:when>
							</c:choose>
						</div>
						<div>${s.comment }</div>						
					</div>
				</div>
			</div>
		</c:forEach>
		
		
	</div>
</div>

<%@include file="/WEB-INF/views/include/footer.jsp"%>