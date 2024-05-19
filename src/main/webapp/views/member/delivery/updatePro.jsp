<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "project.bean.delivery.DeliveryDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="dto" class="project.bean.delivery.DeliveryDTO" />
<jsp:setProperty name="dto" property="*" />

<%
	int snum = (int)session.getAttribute("snum");
	String svendor = (String)session.getAttribute("svendor");
	String pageNum = request.getParameter("pageNum");
	int delivery_num = Integer.parseInt(request.getParameter("delivery_num"));
	
	DeliveryDAO dao = DeliveryDAO.getInstance();
	
	String default_address = (dto.getDefault_address() == null ? "1" : dto.getDefault_address());
	
	if(default_address.equals("2")) {	//기본배송지로 선택하면 나머지는 일반배송지로 변경
		dao.resetDefault_address(snum);
	}
	
	int result = dao.updatePro(dto);
	
	if(result==1) {
%>
	<SCRIPT>
		alert("배송지가 수정되었습니다.");
		window.close();
		opener.window.location="list.jsp?pageNum=<%=pageNum %>";
	</SCRIPT>
<%	}
%>