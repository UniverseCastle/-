<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File" %>
<%@ page import="project.bean.review.ReviewDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="dto" class="project.bean.review.ReviewDTO" />
<jsp:setProperty name="dto" property="*" />"

<%
	int snum = (int)session.getAttribute("snum");
	
	String filePath = request.getRealPath("views/upload");
	int max = 1024*1024*5;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, filePath, max, enc, dp);

	int member_num = Integer.parseInt(mr.getParameter("member_num"));
	int product_num = Integer.parseInt(mr.getParameter("product_num"));
	int category_num = Integer.parseInt(mr.getParameter("category_num"));
	
	
	String rating = mr.getParameter("rating");
	String content = mr.getParameter("content");
	String img = mr.getFilesystemName("img");
	
	dto.setMember_num(member_num);
	dto.setProduct_num(product_num);
	dto.setRating(rating);
	dto.setContent(content);
	dto.setImg(img);
	ReviewDAO dao = ReviewDAO.getInstance();
	int result = dao.writePro(dto);
	
	
	if(result == 1) {
%>
		<SCRIPT>
			alert("리뷰가 등록되었습니다.");
			location.href="../product/productContent.jsp?product_num=<%= product_num %>&category_num=<%= category_num %>";
		</SCRIPT>
<%	}
%>