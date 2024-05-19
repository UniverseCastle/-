<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="project.bean.contact.QnaDAO"%>
<jsp:useBean id="dto" class="project.bean.contact.QnaDTO"/>
<jsp:setProperty property="*" name="dto"/>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	dto.setQna_num(num);
	QnaDAO dao = QnaDAO.getInstance();
	dao.answerWrite(dto);
	
	if(dto.getAnswer()!=null){%>
	<script>
	alert("답글이 등록되었습니다.");
	window.location="qnaQuestion.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
	</script>		
<%	} %>



