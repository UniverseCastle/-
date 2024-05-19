<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "project.bean.contact.VendorQnaDAO"%>
<jsp:useBean id="dto" class="project.bean.contact.VendorQnaDTO"/>
<jsp:setProperty property="*" name="dto"/>
<%@ page import="java.io.File" %>

<%request.setCharacterEncoding("UTF-8");%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String password = request.getParameter("password");
	
	
	
	VendorQnaDAO dao = VendorQnaDAO.getInstance();
	

%>
	<%if(dto.getImg()== null){
			int result = dao.qnaDelete(num,password);
			System.out.println(num);
			System.out.println(password);
			if(result==1){%>

			<script>
				alert("글이 삭제되었습니다.");
				window.location="vendorQnaList.jsp?pageNum=<%=pageNum%>";
			</script>
	<%		}else{ %>
			<script>
				alert("글을 삭제할 수 없습니다.");
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
				window.location="vendorQnaList.jsp?pageNum=<%=pageNum%>";
			</script>
			<%}else{ %>
			<script>
				alert("이미지 게시글을 삭제하지 못했습니다.");
				history.go(-1);
			</script>
			<%} %>			
	<%} %>
