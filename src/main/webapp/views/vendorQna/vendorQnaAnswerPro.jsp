<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="project.bean.contact.VendorQnaDAO"%>
<jsp:useBean id="dto" class="project.bean.contact.VendorQnaDTO"/>
<jsp:setProperty property="*" name="dto"/>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	dto.setVendor_qna_num(num);
	VendorQnaDAO dao = VendorQnaDAO.getInstance();
	dao.vendorAnswerWrite(dto);
	
	if(dto.getAnswer()!=null){%>
	<script>
	alert("답글이 등록되었습니다.");
	window.location="vendorQnaQuestion.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
	</script>		
<%	} %>
    