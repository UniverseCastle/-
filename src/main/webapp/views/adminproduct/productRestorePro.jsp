<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.admin.AdminDAO"%>
<%
	AdminDAO dao = AdminDAO.getInstance();
	int result = 0;

	if(request.getParameter("product_num")!= null){
		int product_num = Integer.parseInt(request.getParameter("product_num"));
		result = dao.restoreProduct(product_num);
	}else{%>
	<script>
		alert("상품 시퀀스 번호가 없음 코드 확인요망");
		location.href="../aminproduct/allProductList.jsp";
	</script>	
<%	}
	
	if(result == 1){%>
		<script>
			alert("상품이 복구되었습니다.");
			location.href="../adminproduct/allProductList.jsp";
		</script>	
<%	}else{%>
		<script>
			alert("상품 복구실패.");
			location.href="../adminproduct/allProductList.jsp";
		</script>	
<%	}
	

%>