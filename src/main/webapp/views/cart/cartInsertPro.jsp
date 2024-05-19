<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="project.bean.cart.CartDAO" %>
<jsp:useBean id="cartDto" class="project.bean.cart.CartDTO"	/>
<jsp:useBean id="productDto" class="project.bean.product.ProductDTO"	/>
<jsp:setProperty name="cartDto" property="*"		/>
<jsp:setProperty name="productDto" property="*"				/>


<%
	int snum = (int)session.getAttribute("snum");
	int p_count = Integer.parseInt(request.getParameter("p_count"));		// 히든으로 넘겨받은 상품의 개수
	int product_num = Integer.parseInt(request.getParameter("product_num"));
	CartDAO cartDao = CartDAO.getInstance();
	cartDto = cartDao.cartSelect(product_num, snum);						// 각 상품 개수를 set 하기 위함
	int result = cartDao.cartInsert(cartDto, productDto.getProduct_num(), snum, p_count);		// 마이페이지 & 상품상세페이지 에서 세션 넘겨받아야함
%>
<script>
	if (confirm("장바구니 담기 완료!\n장바구니로 이동하시겠습니까?")) {
		location.href="cartList.jsp?member_num=<%= snum %>";
	}else {
		history.go(-1);
<%-- 		location.href="../product/productContent.jsp/product_num=<%= productDto.getProduct_num() %>&category_num=<%= productDto.getCategory_num() %>"; --%>
	}

	window.location="cartList.jsp";
</script>