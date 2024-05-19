<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="project.bean.admin.AdminDAO" %>
<%
	AdminDAO dao = AdminDAO.getInstance();
	int result = 0;

	if(request.getParameter("member_num")!=null){
		int	member_num = Integer.parseInt(request.getParameter("member_num"));
		String del = request.getParameter("del");
		result = dao.changeMemberDel(member_num,del);
	}else{%>
		<script>
			alert("회원 시퀀스가 없습니다 코드 확인 요망");
			location.href="memberDetail.jsp";
		</script>	
<%	}
	
	if(result == 1){%>
		<script>
			alert("해당 회원이 강제탈퇴 되었습니다.");
			location.href="allMemberList.jsp";
		</script>	
<%	}else{%>
		<script>
			alert("회원 강제탈퇴 실패");
			location.href="allMemberList.jsp";
		</script>	
<%	}
	
%>