<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.product.ProductDAO" %>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="project.bean.search.SearchDTO" %>
<%@ page import="project.bean.img.ImgDTO" %>
<%@ page import="java.util.List" %>
<style>
	a {
  	text-decoration-line: none;
  	color: #888;
  	}
	.mainCon{
		width:100%;
		display: flex;
		flex-direction : column;
		justify-content: center;
		align-items: center;
	}
	.main{
		display: flex;
		flex-direction : row;
		justify-content: center;
		align-items: center;
	}
	.mainTable{
		margin-top : 50px;
		margin-left : 80px;
		margin-bottom : 110px;
		display: flex;
		flex-direction : row;
		justify-content: flex-start;
		flex-wrap : wrap;
		width:1000px;
	}
	.count{
		margin-top : 10px;
		width :1000px;
		text-align: left;
	}
	.thumnail{
		border : 1px solid white;
	}
	.thumnail:hover{
		opacity:0.5;
	}
	#soldOut{
		opacity:0.5;
	}
	#pageActive{
		color: skyblue; /* 선택된 링크의 색상 */
		font-weight: bold; /* 선택된 링크의 텍스트를 굵게 표시 */
	}

</style>
<jsp:include page="header.jsp"/>
<div class="mainCon">
<jsp:include page="category.jsp" />

<%
	int snum =0;
	String svendor="";
	String keyWord ="";
	String sortName="";
	String sort="";
	
	if(session.getAttribute("snum")!=null){
		snum = (int)session.getAttribute("snum");
	}
	if(session.getAttribute("svendor")!=null){
		 svendor = (String)session.getAttribute("svendor");
	}
	if(request.getParameter("keyWord")!=null){
		 keyWord = request.getParameter("keyWord");
	}
	
	if(request.getParameter("sortName")!=null){
		sortName = request.getParameter("sortName");
	}else{
		sortName = "created_date";
	}
	
	if(request.getParameter("sort")!=null){
		sort = request.getParameter("sort");
	}else{
		sort = "desc";
	}		

	ProductDAO dao = ProductDAO.getInstance();
	
	// 페이징
	int pageSize = 9;
	
	String pageNum = request.getParameter("pageNum");
	if( pageNum == null ){
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = ( currentPage - 1 ) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int productCount = dao.productCount();
	
	SearchDTO searchDto = new SearchDTO(startRow,endRow,keyWord,sortName,sort);

	// 상품 목록
	List<ProductDTO> list = dao.productList(searchDto);
	
%>
<div class="count" >
		<%if(snum!=0 && svendor.equals("2") || snum!=0 && svendor.equals("3")){ %>
	<button type="button" onclick="goProductForm()">상품등록</button>
		<%} %>
	<p>전체 상품 <b style="color:skyblue"><%=productCount %></b>개</p>
	<hr color="darkgray">
</div>
<jsp:include page="sort.jsp"></jsp:include>
<div class="main">		
<%if(productCount!=0){ %>

<div class="mainTable">
	<%for (ProductDTO dto : list){ %>
<table style="margin: 50px; height: 50px;">
	
	<tr>
		<% for(ImgDTO img : dto.getImages()){ %>
		<td>
			<% if(dto.getStock()==0){ %>
			<div class="thumnail">
				<a href="../product/productContent.jsp?product_num=<%=dto.getProduct_num()%>&pageNum=<%=pageNum%>&category_num=<%=dto.getCategory_num()%>"><img src="../upload/<%=img.getImg_name()%>" width="200" height="200" alt="썸네일" id="soldOut"  /></a>
			</div>
			<%}else{ %>
			<div class="thumnail">
				<a href="../product/productContent.jsp?product_num=<%=dto.getProduct_num()%>&pageNum=<%=pageNum%>&category_num=<%=dto.getCategory_num()%>"><img src="../upload/<%=img.getImg_name()%>" width="200" height="200" alt="썸네일"/></a>
			</div>
			<%} %>
		</td>
<%		   }%>
	</tr>
	<tr>
		<% if(dto.getStock()==0){ %>
			<td width="150px">
				<b style="text-decoration: line-through;"><%=dto.getProduct_name() %></b>
				<b style="color:red">품절</b>
			</td>
		<%}else{ %>
		<td  width="150px">
			<%=dto.getProduct_name() %>
		</td>
		<%} %>
	</tr>
	<tr>
		<% if(dto.getStock()==0){ %>
		<td style="text-decoration: line-through;">
			<%=dto.getPrice() %>
		</td>
		<%}else{ %>
		<td><b><%=dto.getPrice() %>원</b></td>
		<%} %>
	</tr>
</table>
	<%}%>
	</div>
	<%}else{%>
	<h1>준비된 상품이 없습니다.</h1>
	<%}


	if( productCount > 0 ){
		int pageCount = productCount / pageSize +( productCount % pageSize == 0 ? 0 : 1 );
		int startPage = (int)((currentPage-1)/10) * 10 +1;
		int pageBlock = 10;
		
		int endPage = startPage + pageBlock -1;
		if( endPage > pageCount ){
			endPage = pageCount;
		}%>
</div>	
<div>
	<%	if( startPage > 10 ){ %>
			<a href="../main/main.jsp?pageNum=<%=startPage-10 %>&sortName=<%=sortName %>&sort=<%=sort%>">[이전]</a>
<% 		}
		for( int i = startPage; i <= endPage; i++ ){ %>
			<a href="../main/main.jsp?pageNum=<%=i%>&sortName=<%=sortName %>&sort=<%=sort%>"<%if(currentPage==i){%>id="pageActive" <%}%>>[<%=i %>]</a>
<%		}
		if( endPage < pageCount){ %>
			<a href="../main/main.jsp?pageNum=<%=startPage+10 %>&sortName=<%=sortName %>&sort=<%=sort%>">[다음]</a>
<%		}
	}
	
%>
</div>
</div>
<jsp:include page="footer.jsp"/>
<script>
	function goProductForm(){ 
		location.href="../product/productInsertForm.jsp";
	}

</script>	