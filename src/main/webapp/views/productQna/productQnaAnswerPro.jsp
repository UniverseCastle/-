<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="project.bean.contact.ProductQnaDAO"%>
<jsp:useBean id="dto" class="project.bean.contact.ProductQnaDTO"/>
<jsp:setProperty property="*" name="dto"/>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	dto.setProduct_qna_num(num);
	ProductQnaDAO dao = ProductQnaDAO.getInstance();
	dao.productAnswerWrite(dto);
	
	if(dto.getAnswer()!=null){%>
	<script>
	alert("답글이 등록되었습니다.");
	window.location="productQnaQuestion.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
	</script>		
<%	} %>
    