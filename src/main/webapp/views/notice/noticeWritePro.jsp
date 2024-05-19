<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File" %>
<%@ page import="project.bean.contact.NoticeDAO"%>
<jsp:useBean id="dto" class="project.bean.contact.NoticeDTO"/>
<jsp:setProperty property="*" name="dto"/>



<%
	//업로드 할 폴더 경로
	String filePath = request.getRealPath("views/upload");
	// 파일 크기
	int max = 1024*1024*5;
	// 인코딩
	String enc = "UTF-8";
	// 덮방
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr 
	   = new MultipartRequest(request, filePath, max, enc, dp);
	
	String title = mr.getParameter("title");
	String content = mr.getParameter("content");
	String img = mr.getFilesystemName("img");
	String fix_yn = mr.getParameter("fix_yn");
	
	dto.setTitle(title);
	dto.setContent(content);
	dto.setImg(img);
	dto.setFix_yn(fix_yn);
	
	
	
	int snum = 0;
	if(session.getAttribute("snum") != null ){
		snum = (int)session.getAttribute("snum");
	}
	String pageNum = request.getParameter("pageNum");
	
	NoticeDAO dao = NoticeDAO.getInstance();
	int result = dao.noticeWrite(dto);
%>
<script>
	alert("공지사항이 정상적으로 등록되었습니다");
	window.location="noticeList.jsp?pageNum<%=pageNum%>";
</script>