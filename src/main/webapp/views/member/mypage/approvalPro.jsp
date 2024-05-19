<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.mypage.MypageDAO" %>

<%-- 취소/반품/교환 승인 --%>

<%
	int snum = (int)session.getAttribute("snum");
	String vendor = (String)session.getAttribute("svendor");
	int orders_num = Integer.parseInt(request.getParameter("orders_num"));
	int product_num = Integer.parseInt(request.getParameter("product_num"));
	
	MypageDAO dao = MypageDAO.getInstance();
	
	int result = dao.approvalPro(orders_num, product_num);
	
	if(result==1) {
%>
		<SCRIPT>
			alert("승인이 완료되었습니다.");
			location.href="approval.jsp";
		</SCRIPT>	
<%	}
%>