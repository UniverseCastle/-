<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File" %>
<%@ page import="project.bean.contact.QnaDAO" %>
<jsp:useBean id="dto" class="project.bean.contact.QnaDTO"/>
<jsp:setProperty property="*" name="dto"/>
<%
	
	int snum=0;
	if(session.getAttribute("snum") != null) {
	    snum = (int) session.getAttribute("snum");
	}
	
// 	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	String filePath = request.getRealPath("views/upload");
	int max = 1024*1024*5;
	String enc = "UTF-8";
	
	
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr 
	= new MultipartRequest(request, filePath, max, enc, dp);


	int member_num = Integer.parseInt(mr.getParameter("member_num")); 
	String title = mr.getParameter("title");
	String img = mr.getFilesystemName("img");
	String password = mr.getParameter("password");
	String category = mr.getParameter("category");
	String question = mr.getParameter("question");
	String writer = mr.getParameter("writer");
	String name = mr.getParameter("name");
	int num = Integer.parseInt(mr.getParameter("num"));
	
	dto.setMember_num(member_num);
	dto.setTitle(title);
	dto.setImg(img);
	dto.setPassword(password);
	dto.setCategory(category);
	dto.setQuestion(question);
	dto.setWriter(writer);
	dto.setName(name);
	dto.setQna_num(num);

	QnaDAO dao = QnaDAO.getInstance();
	int result = dao.qnaUpdatePro(dto, num);
// 	System.out.println(num);
	
	if(result == 1){%>
	<script>
		alert("글이 수정되었습니다.");
		window.location="qnaList.jsp?pageNum=<%=pageNum%>";
	</script>
<%	}else{%>
	<script>
		alert("비밀번호가 맞지 않습니다.");
		history.go(-1);
	</script>
<%	} %>

	
