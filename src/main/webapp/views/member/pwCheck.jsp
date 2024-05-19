<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.member.MemberDAO"%> 

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="/views/member/memberHeader.jsp" />
<jsp:include page="mypage/fixed.jsp" />

<link rel="stylesheet" type="text/css" href="/project/views/css/member.css">

<STYLE>
	.hr	{
		margin: 10px 0;
		border: none;
		border-top: 1px solid gray; 
		width: 882px; 
	}
</STYLE>

<%
	int snum = (int)session.getAttribute("snum");
	String svendor = (String)session.getAttribute("svendor");
	String sid = (String)session.getAttribute("sid");
	
	MemberDAO dao = MemberDAO.getInstance();
%>
	
<DIV style="font-size:35px; font-weight: bold;">회원정보 변경</DIV> <br />
<HR class="hr">
<DIV style="font-size:20px;">
	<B>회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한번 확인해 주세요.</B> 
</DIV>	
<br />

<FORM action="memberInfo.jsp" method="post">
	<DIV "style=font-size:16px;">
	아이디	&nbsp; <%=sid %> &nbsp;&nbsp;&nbsp; 
	비밀번호	<INPUT type="password" name="pw" /><br />
	</DIV> </br>
	<INPUT type="button" value="취소" onclick="history.go(-1)" />
	<INPUT type="submit" class="emphasis" value="인증하기" />
</FORM>