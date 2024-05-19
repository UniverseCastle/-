<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "project.bean.member.MemberDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="dto" class="project.bean.member.MemberDTO" />
<jsp:setProperty name="dto" property="*" />

<%
	int snum = (int)session.getAttribute("snum");
	String svendor = (String)session.getAttribute("svendor");
	
	MemberDAO dao = MemberDAO.getInstance();
			
	int result = dao.updatePro(dto);
	
	if(result==1){
%>
	<SCRIPT>
		alert("개인정보가 수정되었습니다.");
		window.location="pwCheck.jsp";
	</SCRIPT>		
<%	}
%>
