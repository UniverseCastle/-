<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.mypage.MypageDAO" %>

<%-- 반품 처리 --%>

<%
	int snum = (int)session.getAttribute("snum");
	String vendor = (String)session.getAttribute("svendor");
	String selectedOrdersString = request.getParameter("selectedOrders");
	String[] selectedOrders = selectedOrdersString.split(",");
	int[] selectedOrdersNums = new int[selectedOrders.length];
	for (int i=0; i<selectedOrders.length; i++) {
		selectedOrdersNums[i] = Integer.parseInt(selectedOrders[i]);
	}
	
	MypageDAO dao = MypageDAO.getInstance();
	
	int result = dao.returnPro(selectedOrdersNums);
	
	if(result!=0) {
%>
		<SCRIPT>
			alert("반품 신청이 완료되었습니다.");
			window.location="orders.jsp";
		</SCRIPT>	
<%	}
%>

