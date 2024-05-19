<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.admin.AdminDAO"%>
<%
	AdminDAO dao = AdminDAO.getInstance();
	int result = 0;
	
	if(request.getParameter("product_num")!=null){
		int	product_num = Integer.parseInt(request.getParameter("product_num"));
		String status = request.getParameter("status");
		result = dao.changeProductStatus(status, product_num);
	}else{%>
		<script>
			alert("상품 시퀀스가 없습니다 코드 확인 요망");
			location.href="productAddList.jsp";
		</script>	
<%	}
	
	if(result == 1){%>
		<script>
			alert("해당 상품의 등록이 승인 되었습니다.");
			location.href="productAddList.jsp";
		</script>	
<%	}else{%>
		<script>
			alert("상품 등록승인 실패");
			location.href="productAddList.jsp";
		</script>	
<%	}%>
	