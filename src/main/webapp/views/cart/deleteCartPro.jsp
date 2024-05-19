<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.cart.CartDAO" %>
<%

	CartDAO cartDao = CartDAO.getInstance();
	
	String[] productNumArr = request.getParameterValues("product_num");
	int[] products = new int[productNumArr.length];
	for (int i=0; i<productNumArr.length; i++) {
		products[i] = Integer.parseInt(productNumArr[i]);
		cartDao.deleteCart(products[i]);
	}
%>
<script>
	alert("장바구니에서 삭제되었습니다.");
	window.location="cartList.jsp?member_num=snum";
</script>