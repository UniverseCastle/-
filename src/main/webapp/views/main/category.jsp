<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.category.CategoryDTO" %>
<%@ page import="java.util.List" %>
<%@page import="project.bean.product.ProductDAO"%>
<style>
	.category{
		height : 50px;
		text-align : center;
		width : 1000px;
		border-style: hidden;
		border-collapse: collapse;
	}
	.table{
		height : 50px;
		border : 1px solid #ddd;
		border-radius : 50px;	
	}
	#active {
	color: skyblue; /* 선택된 링크의 색상 */
	font-weight: bold; /* 선택된 링크의 텍스트를 굵게 표시 */
}
</style>
<%  	
	ProductDAO dao = ProductDAO.getInstance();	
	List<CategoryDTO> list = dao.loadCategory();   
	
	// 카테고리 번호 가져오기
	int category_num = 0; 
	if(request.getParameter("category_num") != null){
		category_num = Integer.parseInt(request.getParameter("category_num"));
	}
%>

<div class="table">
<table class="category">
	<tr class="tr">
		<td class="td1">
		<a href="main.jsp?sortName=created_date&sort=desc"<%if(category_num == 0){%>	id="active"
			<%}%>>전체상품</a>
		</td>
		<% 
			for(CategoryDTO dto : list){
			int categoryProductCnt = dao.categoryProductCount(dto.getCategory_num());
		%>
		<td class="td2">
			<a href="categoryMain.jsp?sortName=created_date&sort=desc&category_num=<%=dto.getCategory_num() %>"
			<%if(category_num == dto.getCategory_num()){%>
			id="active"
			<%}%>
			>
			<%=dto.getCategory_name() %>(<%=categoryProductCnt %>)</a>
		</td>
		<%	} %>

	</tr>
</table>
</div>
