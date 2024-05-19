<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "project.bean.contact.QnaDAO"%>
<jsp:useBean id="dto" class="project.bean.contact.QnaDTO"/>
<jsp:setProperty property="*" name="dto"/>
<%@ page import="java.io.File" %>

<%request.setCharacterEncoding("UTF-8");%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String password = request.getParameter("password");
	
	
	
	QnaDAO dao = QnaDAO.getInstance();
	

%>
	<%if(dto.getImg()== null){
			int result = dao.qnaDelete(num,password);
			if(result==1){%>

			<script>
				alert("글이 삭제되었습니다.");
				window.location="qnaList.jsp?pageNum=<%=pageNum%>";
			</script>
	<%		}else{ %>
			<script>
				alert("글을 삭제할 수 없습니다. 비밀번호를 확인해주세요");
				history.go(-1);
			</script>
	<%			} %>
	<%}else{ 
			String img = dao.delete(num);
			String filePath = request.getRealPath("views/upload");
			File f = new File(filePath+"/"+img);
			boolean result = f.delete();
			
			if(result == true){%>
			<script>
				alert("이미지 게시글을 삭제하였습니다.");
				window.location="qnaList.jsp?pageNum=<%=pageNum%>";
			</script>
			<%}else{ %>
			<script>
				alert("이미지 게시글을 삭제하지 못했습니다.");
				history.go(-1);
			</script>
			<%} %>			
	<%} %>
