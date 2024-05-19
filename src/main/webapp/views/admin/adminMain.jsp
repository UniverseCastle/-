<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../admin/adminHeader.jsp"></jsp:include>

<%
	int snum = 0;
	String svendor="";
	if(session.getAttribute("snum")!=null){
		snum = (int)session.getAttribute("snum");
	}
	
	if(session.getAttribute("svendor")!=null){
		svendor = (String)session.getAttribute("svendor");
	}
	
	if(!(svendor.equals("3")) && snum == 0){%>
		<script>
			alert("관리자 권한이 없습니다.");
			location.href="../member/loginForm.jsp";
		</script>
<%	}%>
<center>
	<img src="../images/adwel.gif" width="500" height="500">
</center>
