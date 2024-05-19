<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% 
	int totalStatus = (int)request.getAttribute("totalStatus");

	if(totalStatus == 1){%>
		<script>
			alert("등록되었습니다");
			location.href="/project/views/member/mypage/registration.jsp";
		</script>	
<%	}else{%>
		<script>
			alert("등록에 실패하였습니다.");
			location.href="/project/views/main/main.jsp";
		</script>	
	
	<%}%>

