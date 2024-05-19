<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.category.CategoryDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="project.bean.category.CategoryDTO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:include page="../admin/adminHeader.jsp"/>
<%
	int count = Integer.parseInt(request.getParameter("count"));
    CategoryDAO dao = CategoryDAO.getInstance(); 
	int result = 0;
	
	for(int i = 0; i <= count; i++){
		String names = "category_name["+i+"]";
		String category = request.getParameter(names);
		if(category == null|| category.trim().isEmpty()){
			continue;
		}else{
			CategoryDTO dto = new CategoryDTO();
			dto.setCategory_name(category);
			result = dao.categoryAdd(dto);
		}
	}
	if(result == 1){%>
		<script>
			alert("카테고리 등록완");
			location.href="../admin/adminMain.jsp";
		</script>	
<%	}else{%>
		<script>
			alert("카테고리 등록실패");
		</script>	
<%	}%>
	
    	
	



