<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import = "project.bean.contact.FaqDAO" %>
<%@ page import = "project.bean.contact.FaqDTO" %>

<%
	
	int num = Integer.parseInt(request.getParameter("faq_num"));
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) {
        pageNum = "1";
    }
	FaqDAO dao = FaqDAO.getInstance();
	int result = dao.faqDelete(num);
	
	if(result ==1 ){%>
		<script>
			alert("게시글 삭제가 완료되었습니다.");
			window.location="faqList.jsp?pageNum=<%=pageNum%>";
		</script>		
<%	}else{%>
		<script>
			alert("게시글 삭제가 완료되지 않았습니다.");
			history.go(-1);
		</script>
	
<%	} %>

