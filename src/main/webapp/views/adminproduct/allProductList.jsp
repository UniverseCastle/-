<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.admin.AdminDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="project.bean.img.ImgDTO" %>
<%@ page import="project.bean.enums.ProductStatus" %>
<%@ page import="project.bean.search.SearchDTO" %>

<style> 
	a {
  		text-decoration-line: none;
  		color: #888;
  	}
	.main{
		width :100%;
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;		
	}
	.adminTable{
	  width: 1800px;
	  height: 700px;
	  border-collapse: collapse;
	  text-align: center;
	  font-size: 25px;
	  margin-bottom: 40px;
	  margin-top: 40px;
	}
	.adminTable>td,.tr1,.tr2{
		border-top : 1px solid #ddd;
	}
	.adminTable> .1,.2{
		width : 10%;
	}
	#pageActive{
		color: skyblue; /* 선택된 링크의 색상 */
		font-weight: bold; /* 선택된 링크의 텍스트를 굵게 표시 */
	}
</style>
<jsp:include page="../admin/adminHeader.jsp"/>
<%	
	AdminDAO dao = AdminDAO.getInstance();
	String status ="";
	String keyWord ="";
	String sortName="";
	String sort="";
	
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
	
	//페이징
	int pageSize = 10;
	
	String pageNum = request.getParameter("pageNum");
	if( pageNum == null ){
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = ( currentPage - 1 ) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int AllProductCount = dao.AllProductCount();	
	
	SearchDTO searchDto = new SearchDTO(startRow,endRow,keyWord,sortName,sort);
	
	List<ProductDTO> list = dao.loadAllProduct(searchDto);
	
%>

<div class="main">
<div style="text-align: left;width: 1800px;">
<p style="font-size:20px;">전체상품수 <b style="color:skyblue"><%=AllProductCount%></b>명</p>
</div>
<jsp:include page="../admin/adminProductSort.jsp"></jsp:include>
<table class="adminTable">
	<tr class="tr1" style="border-top:2px solid black;border-bottom:2px solid black;">
		<th class="1">상품번호</th>
		<th class="2">대표이미지</th>
		<th class="3">상품명</th>
		<th class="4">상품가격</th>
		<th class="5">제조사</th>
		<th class="6">등록일</th>
		<th class="7">상품삭제여부</th>
		<th class="8">상품관리</th>
	</tr>
	<% for(ProductDTO dto : list){ 
		
		String business_name = dao.findBusinessName(dto.getMember_num());
	
	%>
	
	<tr class="tr2" >
		<td class="1"><%=dto.getProduct_num() %></td>
		<% for(ImgDTO imgDto : dto.getImages()){ %>
			<td class="2"><img src="../upload/<%=imgDto.getImg_name()%>" width="100" height="100"></td>
		<% } %>
		<td class="3"><%=dto.getProduct_name()%></td>
		<td class="4"><%=dto.getPrice() %></td>
		<td class="5"><%=business_name%></td>
		<td class="6"><%=dto.getCreated_date()%></td>
		<td class="6"><%=dto.getDelete_yn()%></td>
		<td class="8">
			<button type="button" onclick="location.href='productDetail.jsp?product_num=<%=dto.getProduct_num()%>'">관리</button>
		</td>
	</tr>
	<%} %>	
</table>
<div>
	<%
	

	if( AllProductCount > 0 ){
		int pageCount = AllProductCount / pageSize +( AllProductCount % pageSize == 0 ? 0 : 1 );
		int startPage = (int)((currentPage-1)/10) * 10 +1;
		int pageBlock = 10;
		
		int endPage = startPage + pageBlock -1;
		if( endPage > pageCount ){
			endPage = pageCount;
			
			if( startPage > 10 ){ %>
				<a href="allProductList.jsp?pageNum=<%=startPage-10 %>&sortName=<%=sortName %>&sort=<%=sort%>">[이전]</a>
<%	 		}
			for( int i = startPage; i <= endPage; i++ ){ %>
				<a href="allProductList.jsp?pageNum=<%=i%>&sortName=<%=sortName %>&sort=<%=sort%>"<%if(currentPage==i){%>id="pageActive" <%}%>>[<%=i %>]</a>
<%			}
			if( endPage < pageCount){ %>
				<a href="allProductList.jsp?pageNum=<%=startPage+10 %>&sortName=<%=sortName %>&sort=<%=sort%>">[다음]</a>
<%			}
		}
	}
	
%>
<div>
</div>