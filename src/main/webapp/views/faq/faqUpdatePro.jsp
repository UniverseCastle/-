<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import = "project.bean.contact.FaqDAO" %>
<jsp:useBean id="dto" class="project.bean.contact.FaqDTO"/>
<jsp:setProperty property="*" name="dto"/>
<%
	
	int faq_num = Integer.parseInt(request.getParameter("faq_num"));
	String pageNum = request.getParameter("pageNum");
	int snum=0;
	if(session.getAttribute("snum") != null ){
		snum = (int)session.getAttribute("snum");
	}
	
	System.out.println(faq_num);
	System.out.println(pageNum);
	System.out.println(snum);
	System.out.println(dto.getAnswer());
	System.out.println(dto.getCategory());
	System.out.println(dto.getQuestion());
	
	if (pageNum == null) {
        pageNum = "1";
    }
	FaqDAO dao = FaqDAO.getInstance();
	int result = dao.faqUpdatePro(dto, faq_num);
	
	if(result == 1){%>
	<script>
		alert("수정이 완료되었습니다.");
		window.location="faqList.jsp?pageNum=<%=pageNum%>";
	</script>
<%	}else{%>
	<script>
		alert("수정이 실패했습니다.");
		history.go(-1);
	</script>
<%} %> 

	