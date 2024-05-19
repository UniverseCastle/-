<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.member.MemberDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="dto" class="project.bean.member.MemberDTO" />
<jsp:setProperty name="dto" property="*" />

<%
	MemberDAO dao = MemberDAO.getInstance();
	int result = dao.changePw(dto);
	
	if(result == 1) {
%>
	<SCRIPT>
		alert("비밀번호가 변경되었습니다.")
		window.location = "loginForm.jsp";
	</SCRIPT>
<%	}
%>
    