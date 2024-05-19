<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.io.File" %>
<%@ page import = "project.bean.review.ReviewDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="dto" class="project.bean.review.ReviewDTO" />
<jsp:setProperty name="dto" property="*" />

<%
	int snum = (int)session.getAttribute("snum");
	String svendor = (String)session.getAttribute("svendor");

	String filePath = request.getRealPath("views/upload");
	int max = 1024*1024*5;
	String enc = "UTF-8";
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, filePath, max, enc, dp);
	
	int review_num = Integer.parseInt(mr.getParameter("review_num"));
	int member_num = snum;
	int product_num = Integer.parseInt(mr.getParameter("product_num"));
	String rating = mr.getParameter("rating");
	String content = mr.getParameter("content");
	String orgImg = mr.getParameter("orgImg");
	String img = mr.getFilesystemName("img");
	
	dto.setReview_num(review_num);
	dto.setMember_num(member_num);
	dto.setProduct_num(product_num);
	dto.setRating(rating);
	dto.setContent(content);
	dto.setImg(img); 
	
 	if (img == null || !img.equals(orgImg)) {
	        // 새로운 이미지가 업로드되지 않거나, 이전 이미지와 다를 경우에 이전 이미지를 삭제한다
	File f = new File(filePath+"/"+orgImg);
		if (f.exists()) {
			f.delete(); // 이전 이미지 파일을 삭제한다
		}
 	}
	
	ReviewDAO dao = ReviewDAO.getInstance();
		
	int result = dao.updatePro(dto);
	
	if(result == 1) {
%>
		<SCRIPT>
			alert("후기가 수정되었습니다.");
			window.location="/project/views/member/mypage/review.jsp";
		</SCRIPT>
<%	}
%>	