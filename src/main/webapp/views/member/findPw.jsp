<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<STYLE>
	.table {
	border:1px solid lightgray; 
	width:300px; 
	height:300px; 
	padding:30px
	}
	.table TD {
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
	.blue {
		background-color: skyblue;
		color: white; 
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
		width: 160px;
		height: 80px;
		cursor: pointer;
	}	
</STYLE>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="/views/member/memberHeader.jsp" />


<DIV  style="font-size:35px; font-weight: bold; text-align:right; width:930px;">비밀번호 찾기</DIV> <br />

<FORM action="findPw2.jsp" method="post">

<TABLE class="table" align="center">
	<TR>
		<TD colspan="2" style="font-size:25px;" >회원 비밀번호</TD>
	</TR>
	<TR>
		<TD colspan="2">비밀번호를 찾고자하는 아이디와 휴대폰번호를 입력해주세요.</TD>
	</TR>
	<TR>
		<TD><INPUT type="text" name="id" placeholder="아이디" /></TD>
		<TD rowspan="2">
			<INPUT type="submit" class="emphasis" value="비밀번호 변경하기" />
		</TD>
	</TR>
	<TR>
		<TD><INPUT type="text" name="cellphone"	placeholder="휴대폰 번호" /></TD>
	</TR>
	<TR align="center">
		<TD colspan="2">
		<INPUT type="button" value="아이디 찾기" onclick="window.location='findId.jsp'" />
		<INPUT type="button" class="blue" value="로그인하기" onclick="window.location='loginForm.jsp'" />		
		</TD>
	</TR>
</TABLE>
</FORM>