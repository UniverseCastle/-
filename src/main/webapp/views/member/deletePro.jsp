<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.member.MemberDAO" %>

<% request.setCharacterEncoding("UTF-8");%>

<%
	int snum = (int)session.getAttribute("snum");
	String pw = request.getParameter("pw");
	
	MemberDAO dao = MemberDAO.getInstance();
	
	int result = dao.deletePro(snum, pw);

	if(result==1) {
		// 쿠키 삭제
		Cookie[] cookies = request.getCookies();
		for( Cookie c : cookies ){
			if( c.getName().equals("cid")){
				c.setMaxAge(0);
				response.addCookie(c);
			}
		}
		
		// 세션 삭제
		session.invalidate();	
%>	
	<SCRIPT>
		alert("정상적으로 탈퇴되었습니다.");
		window.location="../main/introMain.jsp"
	</SCRIPT>
<%	}else{
%>
	<SCRIPT>
		alert("비밀번호를 확인하세요.");
		history.go(-1);
	</SCRIPT>	
<%	}
%>
