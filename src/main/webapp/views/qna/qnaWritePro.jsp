<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
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
	
	dto.setMember_num(member_num);
	dto.setTitle(title);
	dto.setImg(img);
	dto.setPassword(password);
	dto.setCategory(category);
	dto.setQuestion(question);
	dto.setWriter(writer);
	dto.setName(name);
	
	QnaDAO dao = QnaDAO.getInstance();
	
	
	int result = dao.qnaWrite(dto);
	if(result == 1){%>
	<script>
		alert("문의글 작성이 완료되었습니다.");
		window.location="qnaList.jsp?pageNum=<%=pageNum%>";
	</script>
<%	}else{ %>
	<script>
		window.location="qnaList.jsp?pageNum=<%=pageNum%>";
	</script>
<%	} %>