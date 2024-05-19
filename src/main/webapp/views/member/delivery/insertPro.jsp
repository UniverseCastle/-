<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.delivery.DeliveryDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="dto" class="project.bean.delivery.DeliveryDTO" />
<jsp:setProperty name="dto" property="*" />

<%
	int snum = (int)session.getAttribute("snum");
	String pageNum = request.getParameter("pageNum");
	
	DeliveryDAO dao = DeliveryDAO.getInstance();
	int result = dao.insertPro(dto);
	
	if(result == 1) {
%>
		<SCRIPT>
			alert("배송지가 등록되었습니다.");
// 			window.close();
// 			opener.
			window.location="list.jsp?pageNum=<%=pageNum %>";
			
		</SCRIPT>
<% 	}
%>
