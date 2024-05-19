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
		width: 120px;
		height: 80px;
		cursor: pointer;
	}	
	
</STYLE>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="/views/member/memberHeader.jsp" />

<DIV  style="font-size:35px; font-weight: bold; text-align:right;  width:920px;">아이디 찾기</DIV> <br />

<FORM action="findIdPro.jsp" method="post">

<TABLE class="table" align="center">
	<TR>
		<TD colspan="2" style="font-size:25px;" >회원 아이디찾기</TD>
	</TR>
	<TR>
		<TD colspan="2"></TD>
	</TR>
	<TR>
		<TD><INPUT type="text" name="name" placeholder="이름" /></TD>
		<TD rowspan="2">
			<INPUT type="submit" class="emphasis" value="아이디 찾기" />
		</TD>
	</TR>
	<TR>
		<TD><INPUT type="text" name="cellphone" placeholder="가입휴대폰번호" /></TD>
	</TR>
	<TR align="center">
		<TD colspan="2">
		<INPUT type="button" value="비밀번호 찾기" onclick="window.location='findPw.jsp'" />
		<INPUT type="button" value="로그인하기" class="blue" onclick="window.location='loginForm.jsp'" />		
		</TD>
</TABLE>

</FORM>