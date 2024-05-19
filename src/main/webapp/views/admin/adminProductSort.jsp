<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.sortTable {
	width: 1800px;
	text-align: center;
	font-size: 20px;
}

#active {
	color: skyblue; /* 선택된 링크의 색상 */
	font-weight: bold; /* 선택된 링크의 텍스트를 굵게 표시 */
}
</style>
<%
	String sortName= "";
	String sort= "";
	if(request.getParameter("sortName")!=null){
		sortName = request.getParameter("sortName");
	}
	if(request.getParameter("sort")!=null){
		sort = request.getParameter("sort");
	}	
%>
<table class="sortTable">
	<tr>
		<td><a  href="allProductList.jsp?sortName=created_date&sort=desc"<%if(sortName.equals("created_date")){%>id="active" <%}%>>등록일순</a></td>
		<td><a  href="allProductList.jsp?sortName=modified_date&sort=desc"<%if(sortName.equals("modified_date")){%>id="active" <%}%>>수정일순</a></td>
		<td><a  href="allProductList.jsp?sortName=price&sort=asc"<%if(sortName.equals("price")&&sort.equals("asc")){%>id="active" <%}%>>낮은 가격순</a></td>
		<td><a 	href="allProductList.jsp?sortName=price&sort=desc"<%if(sortName.equals("price")&&sort.equals("desc")){%>id="active" <%}%>>높은 가격순</a></td>
	</tr>
</table>
