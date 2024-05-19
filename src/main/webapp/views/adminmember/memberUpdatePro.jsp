<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="project.bean.admin.AdminDAO" %>
<%	request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="dto" class="project.bean.member.MemberDTO"></jsp:useBean>
<jsp:setProperty property="*" name="dto"/>

<%
	AdminDAO dao = AdminDAO.getInstance();
	int result = dao.updateMember(dto);
	
	if(result == 1){%>
		<script>
			alert("수정완료");
			location.href="allMemberList.jsp";
		</script>		
<%	}else{%>
		<script>
			alert("수정실패");
			location.href="allMemberList.jsp";
		</script>
<%	}
%>