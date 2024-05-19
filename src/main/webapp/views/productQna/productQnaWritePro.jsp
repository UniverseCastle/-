<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File" %>
<%@ page import="project.bean.contact.ProductQnaDAO"%>
<jsp:useBean id="dto" class="project.bean.contact.ProductQnaDTO"/>
<jsp:setProperty property="*" name="dto"/>
<%
	String pageNum = request.getParameter("pageNum");
	
	int snum=0;
	if(session.getAttribute("snum") != null) {
	    snum = (int) session.getAttribute("snum");
	}
	

	String filePath = request.getRealPath("views/upload");
	int max = 1024*1024*5;
	String enc = "UTF-8";
	
	
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr 
	= new MultipartRequest(request, filePath, max, enc, dp);
	
	
	int member_num = Integer.parseInt(mr.getParameter("member_num"));
	int product_num = Integer.parseInt(mr.getParameter("product_num"));
	String category = mr.getParameter("category");
	String title = mr.getParameter("title");
	String question = mr.getParameter("question");
	String password = mr.getParameter("password");
	String secret_yn = mr.getParameter("secret_yn");
	String delete_yn = mr.getParameter("delete_yn");
	String img = mr.getFilesystemName("img");
	
	
	dto.setMember_num(member_num);
	dto.setProduct_num(product_num);
	dto.setCategory(category);
	dto.setTitle(title);
	dto.setPassword(password);
	dto.setQuestion(question);
	dto.setSecret_yn(secret_yn);
	dto.setDelete_yn(delete_yn);
	dto.setImg(img);
	
	
	ProductQnaDAO dao = ProductQnaDAO.getInstance();
	
	int result = dao.productQnaWrite(dto);
	
	if(result == 1){%>
		<script>
			alert("상품문의가 정상적으로 등록되었습니다");
			window.location="productQnaList.jsp?pageNum=<%=pageNum%>"
		</script>
<%	}else{%>
		<script>
			alert("상품 문의 등록 실패");
			history.go(-1);
		</script>
<%	}%>
