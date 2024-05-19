<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import = "project.bean.contact.NoticeDAO" %>
<%@ page import = "project.bean.contact.NoticeDTO" %>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	NoticeDAO dao = NoticeDAO.getInstance();
	int result = dao.noticeDelete(num);
%>
<script>
	alert("게시글 삭제가 완료되었습니다.");
	window.location="noticeList.jsp?pageNum=<%=pageNum%>";
</script>