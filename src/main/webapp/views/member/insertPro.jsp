<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.member.MemberDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<link rel="stylesheet" type="text/css" href="/project/views/css/member.css">

<STYLE>
	.hr	{
		margin: 10px 0;
		border: none;
		border-top: 1px solid gray; 
		width: 882px; 
	}
</STYLE>

<jsp:useBean id="dto" class="project.bean.member.MemberDTO" />
<jsp:setProperty name="dto" property="*" />

<DIV style="display: inline; font-size:35px; font-weight: bold;">회원가입</DIV>
<DIV style="display: inline; font-size:15px; font-weight: bold;">
	01약관동의>02정보입력><FONT color	= skyblue>03가입완료</FONT></DIV>
<HR class="hr">

<%
	MemberDAO dao = MemberDAO.getInstance();
	int result = dao.insertPro(dto);
	if(result==1){
%>
	<H1>회원 가입이 완료되었습니다.</H1>
	<DIV><B><%=dto.getId() %></B>님 회원가입을 축하합니다.</DIV><br />
		<INPUT type="button" value="메인으로 가기" onclick="window.location='../main/introMain.jsp'" />
		<INPUT type="button" class="emphasis" value="로그인" onclick="window.location='loginForm.jsp'" />
<% }
%>