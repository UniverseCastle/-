<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.product.ProductDAO" %>
<%
	
	int product_num=0; 
	int ad = 0;
	if(request.getParameter("ad")!=null){
		ad = Integer.parseInt(request.getParameter("ad"));
	}
	
	if(request.getParameter("product_num")!=null){
		product_num = Integer.parseInt(request.getParameter("product_num"));
	}
	ProductDAO dao = ProductDAO.getInstance();
	int result = dao.deleteProduct(product_num);
	
	if(result == 1 && ad == 0){%>
		<script>
			alert('삭제되었습니다');
			location.href="../member/mypage/main.jsp";
		</script>	
<%	}
	if(result == 1 && ad == 1){%>
		<script>
			alert('삭제되었습니다');
			location.href="../adminproduct/allProductList.jsp";
		</script>	
<%	} 
	if(result != 1){	%>
		<script>
			alert('삭제 실패');
			location.href="../member/mypage/main.jsp";
		</script>	
<%	}%>
