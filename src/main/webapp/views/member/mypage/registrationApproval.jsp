<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.mypage.MypageDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<%
	int snum = (int)session.getAttribute("snum");
	String svendor = (String)session.getAttribute("svendor");
	int product_num = Integer.parseInt(request.getParameter("product_num"));			

	MypageDAO dao = MypageDAO.getInstance();
	int result = dao.registrationApproval(product_num);
	
	if(result==1) {
%>
	<SCRIPT>
		alert("재승인 신청이 완료되었습니다.");
		history.go(-1);
	</SCRIPT>
<%	}
%>
