<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="/views/member/memberHeader.jsp" />
<jsp:include page="mypage/fixed.jsp" />

<link rel="stylesheet" type="text/css" href="/project/views/css/member.css">

<DIV style="font-size:35px; font-weight: bold;">회원탈퇴</DIV> <br />
<HR class="hr">
<br /><br />

<%
	int snum = (int)session.getAttribute("snum"); 
	String svendor = (String)session.getAttribute("svendor");
%>

<DIV style="font-size:25px; font-weight: bold;">01. 회원탈퇴 안내</DIV><br />
<DIV style="font-size:16px; display:inline-block; width:858px; border:1px solid lightgray; padding:10px;">
	<B>술통마켓 탈퇴 안내</B><br /><br />
	
	회원 탈퇴시 회원님의 정보는 상품 반품 및 A/S를 위해 전자상거래 등에서의 소비자 보호에 관한 법률에 의거한 고객정보 보호정책에따라 관리됩니다. <br />
</DIV><br /><br /><br />

<DIV style="font-size:25px; font-weight: bold;">02. 회원탈퇴 하기</DIV><br />

<FORM action="deletePro.jsp" method="post">
	비밀번호	<INPUT type="password" name="pw" />
			<INPUT type="submit" class="emphasis" value="탈퇴하기" />
</FORM>