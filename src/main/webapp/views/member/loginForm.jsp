<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>

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
	.emphasis {
		background-color: gray;
		color: white; 
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
		width: 120px;
		height: 80px;
		cursor: pointer;
	}
</STYLE>

<jsp:include page="/views/member/memberHeader.jsp" />

<DIV style="font-size:35px; font-weight: bold; text-align:right; width:840px;">로그인</DIV> <br />

<%
	String cid = null;
	Cookie[] cookies = request.getCookies();
	if (cookies!=null){
		for (Cookie c : cookies) {
			if(c.getName().equals("cid")){
				cid=c.getValue();
				break;
			}
		}
	}
%>

<FORM action="loginPro.jsp" method="post">
<TABLE class="table" align="center">
	<TR>
		<TD colspan="3" style="font-size:25px;">로그인</TD>
	</TR>
	<TR>
<%	if(cid==null){
	
%>
		<TD colspan="2"><INPUT type="text" name="id" placeholder="아이디" />
<%  }else { 
%>
		<TD colspan="2"><INPUT type="text" name="id" value="<%=cid %>" />	
<% 	}
%>
		<TD rowspan="2"><INPUT type="submit" class="blue" value="로그인" />
	</TR>
	<TR>
		<TD colspan="2"><INPUT type="password" name="pw" placeholder="비밀번호" />
	</TR>
	<TR>
		<TD colspan="3"><INPUT type="checkbox" name="save_id" value="1" id="save_id"/> <label for="save_id">아이디 저장</label>
	</TR>
	<TR>
		<TD><INPUT type="button" class="emphasis" value="회원가입" onclick="window.location='agreement.jsp'" />
		<TD><INPUT type="button" value="아이디찾기" onclick="window.location='findId.jsp'" />
		<TD><INPUT type="button" value="비밀번호찾기" onclick="window.location='findPw.jsp'" />
	</TR>
</TABLE>
</FORM>