<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.member.MemberDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<%
	int member_num = Integer.parseInt(request.getParameter("member_num"));

	MemberDAO dao = MemberDAO.getInstance();

	int result = dao.reapply(member_num);
	
	if(result==1) {
%>
		<SCRIPT>
			alert("가입 신청이 완료되었습니다.");
			window.location="../main/introMain.jsp";
		</SCRIPT>
<%	}
%>

