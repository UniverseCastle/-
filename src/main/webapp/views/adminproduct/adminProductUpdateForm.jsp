<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.product.ProductDAO"%>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="project.bean.category.CategoryDTO" %>
<%@ page import="project.bean.img.ImgDTO" %>
<%@ page import="java.util.List" %>
<style>
.main{
	display: flex;
	flex-direction: column;
	align-items: center;
}
form{
	margin-top : 20px;
	display: flex;
	flex-direction: column;
	align-items: center;
}
.imgCon{
	width : auto;
	padding : 20px;
	border : 1px solid darkgray;
	border-radius :10px;
	display: flex;
	flex-direction: row;
	align-items: center;
}
form > .info{
	border : 1px solid darkgray;
	border-radius :10px;
	padding : 20px;
}
#productImgDragZone,#textImgDragZone{
	border-radius :10px;
	border : 1px dashed black;
	width : 200px;
	height: 100px;
	text-align: center;
}

#imgBox{
	display: flex;
	flex-direction: column;
}
.currentImg{
	display: flex;
	flex-direction: row;
}
#productImgPreview,#textImgPreview{
	display: flex;
	flex-direction: row;
}
#imgBox > input{
	font-weight : bolder;
	border-radius :5px;
	border : 1px solid darkgray;
	width: 200px;
	height: 30px;
	background-color: white;
	margin:5px;
}	
#imgBox > img{
	border-radius :5px;
	border : 1px solid darkgray;
	margin:5px;
}
.setImg{
	padding : 20px;
	margin-left: 50px;
	border : 1px solid darkgray;
	border-radius :10px;
	padding : 20px;
}
#submit{
	color : white;
	font-weight : bolder;
	font-size : 20px;
	border-radius :10px;
	border-style : none;
	width: 300px;
	height : 50px;
	background-color: darkgray;
}
.cancel{
	margin-top:10px;
	color : white;
	font-weight : bolder;
	font-size : 20px;
	border-radius :10px;
	border-style : none;
	width: 300px;
	height : 50px;
	background-color: darkgray;
}
.info{
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
}
.info> div{ 
	margin-top : 20px;
}
input[type]{
	border-radius: 5px;
}
</style>

<%
	int snum = 0;
	String svendor="";
	
	if(session.getAttribute("snum")!=null){
		snum  = (int)session.getAttribute("snum");
	}
	if(session.getAttribute("svendor")!=null){
		svendor = (String)session.getAttribute("svendor");
	}
	
	if(snum == 0 || svendor == ""){%>
		
<%	}
	
	int i = 0;
	int product_num = Integer.parseInt(request.getParameter("product_num"));
	ProductDAO dao = ProductDAO.getInstance();	
	List<CategoryDTO> list = dao.loadCategory();   
	
	ProductDTO data = dao.updateForm(product_num);
%>

<div class="main">
	<form action="<%=request.getContextPath() %>/productUpdate" method="post" enctype="multipart/form-data">
		<input type="hidden"name="product_num" value="<%=product_num%>"/>	
		<input type="hidden"name="ad" value="1"/>	
		
		<%--이미지삭제 예약 리스트 히든 --%>
		<input type="hidden"name="deleteList"/>	
		
		<div class="info">
		<h2>상품정보</h2>	
			<%--상품카테고리 --%>
			<div>
				<select name="category_num">
					<option value="<%=data.getCategory_num()%>" selected><%=data.getCategory_name() %></option>
					<% for(CategoryDTO dto : list){ %>
					<option value="<%=dto.getCategory_num()%>"><%=dto.getCategory_name() %></option>
					<%} %>
				</select>
			</div>
			<%--상품정보 --%>
			<div>
			상품명<input type="text" name="product_name" value="<%=data.getProduct_name()%>"><br/>
			</div>
			<div>	
			상품 설명<textarea name="product_info"><%=data.getProduct_info() %></textarea><br/>
			</div>
			
			<div>
				상품 가격	<input type="number" name="price" value="<%=data.getPrice()%>">원<br/>
			</div>
			<%--상품배송비 --%>
			
			<div>
			배송비 유무 및 배송비 수정
				<% if(data.getHas_delivery_fee().equals("있음")){ %>
				<input type="radio" name="has_delivery_fee" onclick="showInputBox()" value="있음" checked>있음
				<input type="radio" name="has_delivery_fee" onclick="closeInputBox()" value="없음">없음
				<div id="d_price" style="display : block; margin-top:5px;">
					배송비 <input type="number" name="delivery_price" value="<%=data.getDelivery_price()%>">원
				</div><br>
			</div>
		
			<%}else{%>
			<input type="radio" name="has_delivery_fee" onclick="showInputBox()" value="있음" >있음
			<input type="radio" name="has_delivery_fee" onclick="closeInputBox()" value="없음"checked>없음
			<div id="d_price" style="display : none">
				배송비 <input type="number" name="delivery_price" value="0">원
			</div>
			<%}%>
			
			
			<%--상품재고 --%>
			<div>
			현재 상품 재고<%=data.getStock()%>개<br>
			<input type="hidden" name="stock" value="<%=data.getStock()%>"/>
			</div>
			<div>
			추가 재고 
			<input type="number" name="first_stock" value="0"/><br>
			</div>
		</div>
		
		<%--상품 이미지 --%>
			<br>
			<h2>현재이미지</h2>
		<div class="imgCon">
			
			<div class="currentImg">
			
			<% if(data.getImages()!=null){
					for(ImgDTO img : data.getImages()){ 
					%>
				<div id="imgBox">
				<img src="../upload/<%=img.getImg_name()%>" width="200" height="200" id="<%=img.getImg_num()%>"/>
				<input type="button" id="deleteBtn" value="삭제" onclick="deleteImg(<%=img.getImg_num()%>)">
				<input type="button" id="cancelBtn" value="취소" onclick="deleteCancel(<%=img.getImg_num()%>)"><br/>
			</div>
			 <%} 
		   }%>
		 
		</div>

		
			<div class="setImg">
				<h2>수정할 이미지</h2>
				<h4>[대표 이미지]</h4>
				<input type="file" name="thumbnail" ><br/>
				<br/>
				<br/>
				<h4>[상품 이미지]</h4>
				
				<div id="productImgDragZone">
					<p>클릭하거나 상품이미지를 드래그 & 드롭 해주세요</p>
					<input id="productImgInput" type="file" name="img" style="display:none" multiple><br/>
				</div>
				<div id="productImgPreview" ></div>
				상품이미지 업로드파일 수 :<span id="productImgCount"></span>개
		
				<br>
				<br>
				<h4>[상품 설명 이미지]</h4>
				<div id="textImgDragZone">
					<p>클릭하거나 상품설명이미지를 드래그 & 드롭 해주세요</p>
					<input id="textImgInput"  type="file" name="textImg" style="display:none"  multiple><br/>
				</div>
				<div id="textImgPreview"></div>
				상품설명이미지 업로드파일 수 :<span id="textImgCount"></span>개
			</div>
		</div>								
		<br/>
		<br/>
		<input id="submit" type="submit" value="수정 완료" onclick="listJoin()">
		<button class="cancel" type="button" onclick="location.href='../adminproduct/allProductList.jsp?sortName=created_date&sort=desc'">취소</button>
		
	</form>
</div>
<script type="text/javascript" src="/project/views/js/updateForm.js"></script>
<script type="text/javascript" src="/project/views/js/dragAndDrop.js"></script>
<script type="text/javascript" src="/project/views/js/dragAndDrop2.js"></script>
