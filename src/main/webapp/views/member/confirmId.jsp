<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.member.MemberDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="/views/member/memberHeader.jsp" />

<%
	String id = request.getParameter("id");
	
	MemberDAO dao = MemberDAO.getInstance();
	
	boolean result = dao.confirmId(id);
	
	if(result == true) {
%>
	<SCRIPT>
		opener.document.getElementById("confirmResult").innerHTML = 
			"<FONT color='red'>사용 불가능한 아이디입니다.</FONT>"
		//아이디가 중복인 경우 회원가입버튼 비활성화
		opener.document.getElementById("submit").disabled = true;
		self.close();
	</SCRIPT>
<%	}else{
%>
	<SCRIPT>
		opener.document.getElementById("confirmResult").innerHTML =
			"<FONT color='blue'>사용 가능한 아이디입니다.</FONT>"
		//아이디가 중복이 아닌 경우 회원가입버튼 활성화
		opener.document.getElementById("submit").disabled = false;
		self.close();
	</SCRIPT>
<%	}
%>