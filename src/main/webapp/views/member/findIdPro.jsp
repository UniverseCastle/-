<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.member.MemberDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<STYLE>
	TABLE {
	border:1px solid lightgray; 
	width:300px; 
	height:300px; 
	padding:30px
	}
	TD {
		padding:10px;
	}
	BUTTON, INPUT {
		background-color: white;
		color: gray; 
		border: 1px solid lightgray;
		border-radius: 0; 
		padding: 5px 10px; 
		font-size: 16px; 
		cursor: pointer;
	}
	.emphasis {
		background-color: gray;
		color: white; 
		border: 1px solid lightgray;
		border-radius: 0; 
		padding: 5px 10px; 
		font-size: 16px; 
		cursor: pointer;
	}	
</STYLE>

<jsp:useBean id="dto" class="project.bean.member.MemberDTO" />
<jsp:setProperty name="dto" property="*" />

<%
	MemberDAO dao = MemberDAO.getInstance();
	
	String id = dao.findId(dto);
%>

<%	if(id == "") {
%>
		<SCRIPT>
			alert("이름 또는 휴대폰 번호를 잘못 입력하셨습니다.");
			history.go(-1);
		</SCRIPT>
<% 	}else {
%>
	<DIV style="font-size:35px; font-weight: bold;">아이디 찾기</DIV> <br />
	<TABLE style="border:1px solid lightgray;">
		<TR align="center">
			<TD colspan="2" rowspan="4" style="font-size:25px;" >
			<%=dto.getName() %> 회원님의 아이디는 <br />
			<B><%=id %></B>입니다.
			</TD>
		</TR>
		<TR></TR>
		<TR></TR>
		<TR></TR>
		<TR align="center">
			<TD colspan="2">
			<INPUT type="button" value="비밀번호 찾기" onclick="window.location='findPw.jsp'" />
			<INPUT type="button" class="emphasis" value="로그인하기" onclick="window.location='loginSelect.jsp'" />		
			</TD>
		</TR>
	</TABLE>
<%	}
%>