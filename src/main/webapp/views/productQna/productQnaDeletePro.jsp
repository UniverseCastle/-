<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "project.bean.contact.ProductQnaDAO"%>
<jsp:useBean id="dto" class="project.bean.contact.ProductQnaDTO"/>
<jsp:setProperty property="*" name="dto"/>
<%@ page import="java.io.File" %>

<%request.setCharacterEncoding("UTF-8");%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String password = request.getParameter("password");
	
	
	
	ProductQnaDAO dao = ProductQnaDAO.getInstance();
	
%>

<%	if (dto.getImg() == null) {
	    int result = dao.qnaDelete(num, password);
	    if (result == 1) {%>
	    	<script>
	    		alert("상품문의글이 삭제되었습니다.");
	    		window.location="productQnaList.jsp?pageNum=<%=pageNum%>"
	    	</script>
<%	    } else { %>
			<script>
	    		alert("상품문의글이 삭제되지 않았습니다.");
	    		history.go(-1);
	    	</script>
<%	    }
	} else { 
	    String deletedImg = dao.delete(num);
	    String filePath = request.getRealPath("views/upload");
	    File f = new File(filePath + "/" + deletedImg);
	    
	    boolean deleteResult = false;
	    if (deletedImg != null) {
	        deleteResult = f.delete();
	    }
	    
	    if (deleteResult) {%>
	    	<script>
	    		alert("상품문의글이 삭제되었습니다.img");
	    		window.location="productQnaList.jsp?pageNum=<%=pageNum%>"
	    	</script>
<%	    } else { %>
			<script>
	    		alert("상품문의글이 삭제되지 않았습니다.img");
	    		history.go(-1);
	    	</script>
<%	    }
	} %>
