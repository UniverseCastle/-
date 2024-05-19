<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="project.bean.contact.FaqDAO"%>
<jsp:useBean id="dto" class="project.bean.contact.FaqDTO"/>
<jsp:setProperty property="*" name="dto"/>
<%
	FaqDAO dao = FaqDAO.getInstance();
	int result = dao.faqWrite(dto);
	if(result == 1){
%>
	<script>
		alert("작성이 완료되었습니다.");
		window.location="faqList.jsp";
	</script>
<%	}else{%>
	<script>
		alert("작성에 실패했습니다.");
		history.go(-1);
	</script>
<%	} %>