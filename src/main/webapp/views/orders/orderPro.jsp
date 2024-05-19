<%@page import="java.util.ArrayList"%>
<%@page import="project.bean.orders.OrdersDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="project.bean.orders.OrdersDAO" %>
<%-- <%@ page import="project.bean.orders.OrdersDTO" %> --%>
<%@ page import="project.bean.product.ProductDAO" %>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="project.bean.delivery.DeliveryDAO" %>
<%@ page import="project.bean.member.MemberDAO" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%-- <jsp:useBean id="productDto" class="project.bean.product.ProductDTO"	/> --%>
<jsp:useBean id="deliveryDto" class="project.bean.delivery.DeliveryDTO"	/>
<jsp:useBean id="memberDto" class="project.bean.member.MemberDTO"	/>
<jsp:useBean id="ordersDto" class="project.bean.orders.OrdersDTO"	/>
<%-- <jsp:setProperty name="productDto" property="*"						/> --%>
<jsp:setProperty name="deliveryDto" property="*"						/>
<jsp:setProperty name="memberDto" property="*"						/>
<jsp:setProperty name="ordersDto" property="*"						/>


<%
	int orderPath = Integer.parseInt(request.getParameter("orderPath"));
// 	System.out.println("오더패스"+orderPath);
	
	// img_num 넘기는거까지 성공하고 껐음
	int snum = (int)session.getAttribute("snum");
	int product_num = Integer.parseInt(request.getParameter("product_num"));
	int delivery_num = 0;
	int img_num = Integer.parseInt(request.getParameter("img_num"));
// 	int count = Integer.parseInt(request.getParameter("count"));
	int final_price = Integer.parseInt(request.getParameter("final_price"));
	DecimalFormat formatter = new DecimalFormat("#,###");
// 	String fmFinalPrice = formatter.format(final_price);
	String deliveryInsert = request.getParameter("deliveryInsert");
	String memberUpdate = request.getParameter("memberUpdate");
	String payment_option = request.getParameter("payment_option");
	

	String orders_name = request.getParameter("orders_name");
	String receiver_name = request.getParameter("receiver_name");
// 	String name = request.getParameter("receiver_name");	// 이런식으론 값 안들어감
	String email = request.getParameter("email");
	String address1 = request.getParameter("address1");
	String address2 = request.getParameter("address2");
	String address3 = request.getParameter("address3");
// 	String default_address = request.getParameter("default_address");	// DeliveryDAO - deliveryInsert 에서 체크시 기본값1로 설정
	String delivery_name = request.getParameter("delivery_name");
	String name = request.getParameter("name");

	String phone = request.getParameter("phone");
	String cellphone = request.getParameter("cellphone");
	
// 	System.out.println(delivery_num);
// 	System.out.println(phone);
// 	System.out.println("전번"+request.getParameterValues("phone"));
// 	System.out.println("폰번"+request.getParameterValues("cellphone"));
// 	System.out.println("주소1"+request.getParameterValues("address1"));
// 	System.out.println("주소2"+request.getParameterValues("address2"));
// 	System.out.println("주소3"+request.getParameterValues("address3"));
// 	String[] strs = request.getParameterValues("delivery_num");
	
// 	for (String str : strs) {
// 		System.out.println(str);
// 	}
	
	
	// deliveryInsert - 1 조건문 걸기
	// memberUpdate - 1 조건문 걸기
	OrdersDAO ordersDao = OrdersDAO.getInstance();
	ProductDAO productDao = ProductDAO.getInstance();
	DeliveryDAO deliveryDao = DeliveryDAO.getInstance();
	MemberDAO memberDao = MemberDAO.getInstance();
	if (deliveryInsert != null) {
// 		System.out.println(category_num);
// 		System.out.println(snum);
		deliveryDao.deliveryInsert(deliveryDto, snum);
	}
	if (memberUpdate != null) {
		memberDao.memberUpdate(memberDto, snum);
	}
	int sumPrice = 0;
	int result = 0;
	if (orderPath == 1) {
// 		int product_num = Integer.parseInt(request.getParameter("product_num"));
// 		int img_num = Integer.parseInt(request.getParameter("img_num"));
		delivery_num = Integer.parseInt(request.getParameter("delivery_num"));
// 		System.out.println(snum);
// 		System.out.println(product_num);
// 		System.out.println(delivery_num);
// 		System.out.println(img_num);
		ArrayList<ProductDTO> productList = productDao.productInfo(product_num);
		for (ProductDTO productDto : productList){
			result = ordersDao.orderInsert(ordersDto, productDto);
			sumPrice += final_price;
		}
	}else if (orderPath == 2) {
		int productsNum = Integer.parseInt(request.getParameter("productsNum"));	// 선택한 상품 반복할 개수
		delivery_num = Integer.parseInt(request.getParameter("delivery_num"));
// 		System.out.println("딜리버리넘"+delivery_num);
		
		String[] products = request.getParameterValues("product_num");
		int[] productNum = new int[products.length];
		for(int i=0; i<products.length; i++){
			productNum[i] = Integer.parseInt(products[i]);
			
// 			System.out.println("상품번호"+productNum[i]);
		}
		String[] imgs = request.getParameterValues("img_num");
		int[] imgNum = new int[imgs.length];
		for(int i=0; i<imgs.length; i++){
			imgNum[i] = Integer.parseInt(imgs[i]);
// 			System.out.println("이미지번호"+imgNum[i]);
		}
		String[] counts = request.getParameterValues("count");
		int[] countNum = new int[counts.length];
		for(int i=0; i<counts.length; i++){
			countNum[i] = Integer.parseInt(counts[i]);
		}
		String[] prices = request.getParameterValues("final_price");
		int[] priceNum = new int[prices.length];
		for(int i=0; i<prices.length; i++){
			priceNum[i] = Integer.parseInt(prices[i]);
		}
		
		
//	 	System.out.println(ordersDto.getMember_num());
		ArrayList<OrdersDTO> list = new ArrayList<>();
		
		for(int i=0; i<productsNum; i++){
			ordersDto = new OrdersDTO();
			ordersDto.setMember_num(snum);				// x
			ordersDto.setProduct_num(productNum[i]);  	// 배열
			ordersDto.setDelivery_num(delivery_num);	// x
// 			System.out.println("반복딜리버리넘"+delivery_num);
			ordersDto.setImg_num(imgNum[i]);			// 배열
			ordersDto.setCount(countNum[i]);			// 배열
			ordersDto.setOrders_name(orders_name);		// x
			ordersDto.setReceiver_name(receiver_name);	// x
			ordersDto.setPhone(phone);					// x
			ordersDto.setCellphone(cellphone);			// x
			ordersDto.setEmail(email);					// x
			ordersDto.setAddress1(address1);			// x
			ordersDto.setAddress2(address2);			// x
			ordersDto.setAddress3(address3);			// x
			ordersDto.setFinal_price(priceNum[i]);		// x
			ordersDto.setPayment_option(payment_option);	// x
			list.add(ordersDto);
			sumPrice += ordersDto.getFinal_price();
		}
		result = ordersDao.orderInsertList(list);
	}
	if (result > 0) {
%>
	<script>
		alert("<%= result %>건의 주문이 완료되었습니다.");
	</script>
	
<CENTER>

<TABLE>
	<TR>
		<TD align="left" width="350">
			<div><font size="6"><B>주문완료</B></font></div>
		</TD>
		<TD align="right">
			<div style="width:800;">
				<font size="2"><B>01 장바구니 ≫ 02 주문서작성/결제 ≫ <span style="color: #6B66FF;">03 주문완료</span></B></font>
			</div>
		</TD>
	</TR>
	<TR>
		<TD colspan="2">
	<HR align="center" width="100%" size="1"	/>
	<br /><br />
		</TD>
	</TR>

</TABLE>

<%
		String fmSumPrice = formatter.format(sumPrice);
		switch (payment_option) {
			case "1":
%>
				<H1><font color="#F15F5F">신용카드</font></H1>
<%
				break;
			case "2":
%>
				<H1><font color="#6B66FF">계좌이체</font></H1>
<%
				break;
			case "3":
%>
				<H1><font color="#476600">가상계좌</font></H1>
<%
				break;
			case "4":
%>
				<H1><font color="#CC723D">카카오페이</font></H1>
<%
				break;
		}
%>
				<H2><font size="6" color="#002266"><%= fmSumPrice %></font>원 결제 -완-</H2>
<%
	}
%>
</CENTER>

<%-- 
<% 
	String deliveryInsert = request.getParameter("deliveryInsert");		// 값이 넘어오면 1
	String deliveryUpdate = request.getParameter("deliveryUpdate");		// 값이 넘어오면 1
	int delivery_num = Integer.parseInt(request.getParameter("delivery_num"));
	OrdersDAO dao = OrdersDAO.getInstance();
	int result = dao.orderInsert(dto);
	
	if (result == 1) {
	}
%>
--%>
<script>
//5초 후에 다른 페이지로 이동하는 함수
function redirectToNextPage() {
    // 이동할 페이지의 URL
    var nextPageUrl = "/project/views/main/main.jsp";

    // 5초 후에 nextPageUrl로 이동
    setTimeout(function() {
        window.location.href = nextPageUrl;
    }, 5000); // 5000 밀리초 = 5초
}

// 페이지 로드 시에 redirectToNextPage 함수 호출
window.onload = redirectToNextPage;
</script>

