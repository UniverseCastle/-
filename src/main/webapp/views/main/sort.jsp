<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.sortTable {
	width: 1000px;
	text-align: center;
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
		<td><a  href="main.jsp?sortName=created_date&sort=desc"<%if(sortName.equals("created_date")){%>id="active" <%}%>>등록일순</a></td>
		<td><a  href="main.jsp?sortName=price&sort=asc"<%if(sortName.equals("price")&&sort.equals("asc")){%>id="active" <%}%>>낮은 가격순</a></td>
		<td><a 	href="main.jsp?sortName=price&sort=desc"<%if(sortName.equals("price")&&sort.equals("desc")){%>id="active" <%}%>>높은 가격순</a></td>
	</tr>
</table>
