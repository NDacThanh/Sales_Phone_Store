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
		
	<div class="col-9 mbg-azure pt-2">
		<div class="h4 text-uppercase text-center">Cập nhật sản phẩm</div>
		
		<c:if test="${not empty message}">			
		  	<c:choose>
				<c:when test="${message == 0}">
					<div class="col-sm-8 alert alert-danger" role="alert">
					Cập nhật thất bại!
					<button type="button" class="rem" data-dismiss="alert" aria-label="Close">&times;</button>
					</div>
				</c:when>
				<c:when test="${message == 1}">
					<div class="col-sm-8 alert alert-success alert-dismissible" role="alert">
					Cập nhật thành công!
					<button type="button" class="rem" data-dismiss="alert" aria-label="Close">&times;</button>
					</div>
				</c:when>
				<c:when test="${message == 2}">
					<div class="col-sm-8 alert alert-danger alert-dismissible" role="alert">
					Lưu hình ảnh thất bại!
					<button type="button" class="rem" data-dismiss="alert" aria-label="Close">&times;</button>
					</div>
				</c:when>
			</c:choose>		  	
		</c:if>
		
		<form:form action="admin/editProduct.htm" method="post" modelAttribute="product" enctype="multipart/form-data">
			<div class="row my-3">
	    		<label class="col-sm-3 col-form-label text-end">Mã sản phẩm: </label>
	    		<div class="col-sm-8">
	      			<form:input path="id" type="text" class="form-control" readonly="true"/>
	    		</div>
  			</div>
		
			<div class="row my-3">
	    		<label class="col-sm-3 col-form-label text-end">Tên sản phẩm: <label style="color: red;">*</label></label>
	    		<div class="col-sm-8">
	      			<form:input path="name" type="text" class="form-control"/>
	      			<form:errors path="name" class="fst-italic text-danger"/>
	    		</div>
  			</div>
			
			<div class="row mb-3">
	    		<label class="col-sm-3 col-form-label text-end">Loại sản phẩm: <label style="color: red;">*</label></label>
	    		<div class="col-sm-8">
					<form:select path="categories.id" items="${categorySel}" itemLabel="name" itemValue="id" class="form-select mb-6"></form:select>
	    		</div>
  			</div>
  					
  		
  			<div class="row my-3">
	    		<label class="col-sm-3 col-form-label text-end">Đơn giá: <label style="color: red;">*</label></label>
	    		<div class="col-sm-8">
	    			<div class="input-group">
	    				<form:input path="price" type="text" class="form-control"/>
	      				<span class="input-group-text">đ</span>
	    			</div>
	    			<form:errors path="price" class="fst-italic text-danger"/>
	    		</div>
  			</div>
  			
  			<div class="row my-3">
	    		<label class="col-sm-3 col-form-label text-end">Dung lượng : <label style="color: red;">*</label></label>
	    		<div class="col-sm-8">
	      			<form:input path="specification" type="text" class="form-control"/>
	      			<form:errors path="specification" class="fst-italic text-danger"/>
	    		</div>
  			</div>
  			<div class="row my-3">
	    		<label class="col-sm-3 col-form-label text-end">Sản phẩm kèm theo : </label>
	    		<div class="col-sm-8">
	      			<form:input path="calculation_unit" type="text" class="form-control"/>
	      			<form:errors path="calculation_unit" class="fst-italic text-danger"/>
	    		</div>
  			</div>
  			<div class="row my-3">
	    		<label class="col-sm-3 col-form-label text-end">Số lượng thêm vào: </label>
	    		<div class="col-sm-8">
	    			<%-- <form:input path="quantity" type="hidden" class="form-control"/> --%>
	      			<input name="add" type="number" class="form-control" value="0" min="0"
	      				   oninput="this.value = !!this.value && Math.abs(this.value) >= 0 ? Math.abs(this.value) : null">
   				   	
	    		</div>
  			</div>
  			
  			<div class="row my-3">
	    		<label class="col-sm-3 col-form-label text-end">Giảm giá: </label>
	    		<div class="col-sm-8">
	    			<div class="input-group">
	    				<form:input path="discount" type="number" class="form-control"/>
	      				<span class="input-group-text">%</span>
	    			</div>
	    		</div>
  			</div>
  			<div class="row my-3">
	    		<label class="col-sm-3 col-form-label text-end">Màn hình: </label>
	    		<div class="col-sm-8">
	      			<form:input path="display" type="text" class="form-control"/>
	      			<form:errors path="display" class="fst-italic text-danger"/>
	    		</div>
  			</div>
  			<div class="row my-3">
	    		<label class="col-sm-3 col-form-label text-end">Độ phân giải: </label>
	    		<div class="col-sm-8">
	      			<form:input path="resolution" type="text" class="form-control"/>
	      			<form:errors path="resolution" class="fst-italic text-danger"/>
	    		</div>
  			</div>
  			<div class="row my-3">
	    		<label class="col-sm-3 col-form-label text-end">Hệ điều hành: </label>
	    		<div class="col-sm-8">
	      			<form:input path="system" type="text" class="form-control"/>
	      			<form:errors path="system" class="fst-italic text-danger"/>
	    		</div>
  			</div>
  			<div class="row my-3">
	    		<label class="col-sm-3 col-form-label text-end">Chip xử lí (CPU): </label>
	    		<div class="col-sm-8">
	      			<form:input path="CPU" type="text" class="form-control"/>
	      			<form:errors path="CPU" class="fst-italic text-danger"/>
	    		</div>
  			</div>
  			<div class="row my-3">
	    		<label class="col-sm-3 col-form-label text-end">Dung lượng Ram: </label>
	    		<div class="col-sm-8">
	      			<form:input path="RAM" type="text" class="form-control"/>
	      			<form:errors path="RAM" class="fst-italic text-danger"/>
	    		</div>
  			</div>
  			<div class="row my-3">
	    		<label class="col-sm-3 col-form-label text-end">SIM: </label>
	    		<div class="col-sm-8">
	      			<form:input path="SIM" type="text" class="form-control"/>
	      			<form:errors path="SIM" class="fst-italic text-danger"/>
	    		</div>
  			</div>
  			<div class="row my-3">
	    		<label class="col-sm-3 col-form-label text-end">Pin: </label>
	    		<div class="col-sm-8">
	      			<form:input path="battery" type="text" class="form-control"/>
	      			<form:errors path="battery" class="fst-italic text-danger"/>
	    		</div>
  			</div>
  			<div class="row mb-3">
	    		<label class="col-sm-3 form-label text-end">Hình ảnh:</label>
	    		<div class="col-sm-8">
					<input type="file" name="file" placeholder="Upload image" class="form-control" accept=".jpg,.gif,.png,.pdf" onchange="preview()">
					<img id="img" class="rounded" src="resources/images/products/${product.image}" >
	    			<form:input path="image" type="hidden" class="form-control"/>
	    		</div>
  			</div>
  			
  			<div class="row mb-3">
	    		<label class="col-sm-3 col-form-label text-end">Mô tả: <label style="color: red;">*</label></label>
	    		<div class="col-sm-8">
	    			<form:textarea path="description" class="form-control" id="exampleFormControlTextarea1" rows="3"></form:textarea>
	    			<form:errors path="description" class="fst-italic text-danger"/>
	    		</div>
  			</div>
  			
  			<%-- <form:input path="calculation_unit" type="hidden" class="form-control"/>
  			<form:input path="sold_quantity" type="hidden" class="form-control"/>
  			<form:input path="status" type="hidden" class="form-control"/> --%>
  			
  			<div class="text-center mb-3">
	    		<form:button type="submit" class="btn btn-primary bg-gradient text-white">Cập nhật</form:button>
  			</div>
		</form:form>
	</div>
</div>
</div>

<%@include file="/WEB-INF/views/include/adminFooter.jsp"%>