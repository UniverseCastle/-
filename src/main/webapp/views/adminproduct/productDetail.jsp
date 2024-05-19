<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.admin.AdminDAO"%>
<%@ page import="project.bean.product.ProductDTO"%>
<%@ page import="project.bean.img.ImgDTO"%>
<style>
	main{
		display: flex;
		align-items: center;
		justify-content: center;
		flex-direction: column;
	}
	.imgBox > .img{
		padding: 10px;
	}
	.imgBox{
		display :flex;
		flex-direction: row;
	}
	.detailTable{
		height : 500px;
		width : 1000px;
		text-align: center;
		border-collapse: collapse;
	}
	.detailTable > .tr,.th,.td{
		border :1px solid darkgray;
	}
</style>
<jsp:include page="../admin/adminHeader.jsp"/>
<%
	String svendor="";	
	int snum = 0;
	
	if(session.getAttribute("svendor")!=null){
		svendor = (String)session.getAttribute("svendor");
	}
	if(session.getAttribute("snum")!=null){
		snum = (int)session.getAttribute("snum");
	}
	if(!(svendor.equals("3")) && snum == 0){%>
		<script>
			alert("관리자 권한이 없습니다.");
			location.href="../member/loginForm.jsp";
		</script>
	<%	}
	
	AdminDAO dao = AdminDAO.getInstance();
	if(request.getParameter("product_num")!=null){
		int product_num = Integer.parseInt(request.getParameter("product_num"));
		ProductDTO dto = dao.productDetail(product_num);
		
%>
<main>
	<div class="tableCon">
		<table class="detailTable">
			<tr class="tr">
				<th class="th">상품번호</th>
				<td class="td"><%=dto.getProduct_num() %></td>
				<th class="th">상품명</th>
				<td class="td"><%=dto.getProduct_name() %></td> 
			</tr>
			<tr class="tr">
				<th class="th">카테고리</th>
				<td class="td"><%=dto.getCategory_name() %></td>
				<th class="th">상품 가격</th>
				<td class="td"><%=dto.getPrice() %></td>
			</tr>
			<tr class="tr">
				<th class="th">상품 설명</th>
				<td class="td"><%=dto.getProduct_info() %></td>
				<th class="th">상품 상태</th>
				<td class="td"><%=dto.getProduct_info() %></td>
			</tr>
			<tr class="tr">
				<th class="th">상품 최초 재고</th>
				<td class="td"><%=dto.getFirst_stock() %></td>
				<th class="th">상품 현재 재고</th>
				<td class="td"><%=dto.getStock() %></td>
			</tr>
			<tr class="tr">
				<th class="th">배송비 유무 여부</th>
				<td class="td"><%=dto.getHas_delivery_fee()%></td>
				<th class="th">배송비</th>
				<td class="td"><%=dto.getDelivery_price()%></td>
			</tr>
			<tr class="tr">
				<th class="th">상품 등록 일시</th>
				<td class="td"><%=dto.getCreated_date() %></td>
				<th class="th">상품 수정 일시</th>
				<td class="td"><%=dto.getModified_date() %></td>
			</tr>
		</table>	
	</div>
		<h2>현재 등록된 이미지</h2>
		<div class="imgBox">
		<%		for(ImgDTO img : dto.getImages()){ %>
					<div class="img">
						<img src="../upload/<%=img.getImg_name()%>" width="200" height="200" id="<%=img.getImg_num()%>"/>
					</div>
		<%		} %>  
		</div>
		<div class="btns">
			<button type="button" onclick="location.href='adminProductUpdateForm.jsp?product_num=<%=product_num%>'">수정하기</button>
			<%if(dto.getDelete_yn().equals("N")){%>
				<button type="button" onclick="deleteProduct(<%=product_num%>)">삭제하기</button>
			<%}else{ %>
				<button type="button" onclick="restoreProduct(<%=product_num%>)">복구하기</button>
			<%} %>
			<button type="button" onclick="location.href='../adminproduct/allProductList.jsp'">목록으로</button>
		</div>
</main>
<script>
	function deleteProduct(product_num){
		if(!confirm("해당 상품을 삭제하시겠습니까?")){
			return false;
		}
		location.href="../product/productDeletePro.jsp?product_num=<%=product_num%>&ad=1";
	}
	function restoreProduct(product_num){
		if(!confirm("해당 상품을 복구하시겠습니까?")){
			return false;
		}
		location.href="../adminproduct/productRestorePro.jsp?product_num=<%=product_num%>";
	}
</script>


		
		
		
		
		
		
<%	}else{ %>
		<script>
			alert("상품 시퀀스 번호가 없습니다 코드확인 요망");
			location.href="allProductList.jsp";
		</script>	
<%	}
%>
