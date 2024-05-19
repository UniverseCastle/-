<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.orders.OrdersDAO" %>
<%@ page import="project.bean.product.ProductDAO" %>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="project.bean.member.MemberDAO" %>
<%@ page import="project.bean.member.MemberDTO" %>
<%@ page import="project.bean.delivery.DeliveryDAO" %>
<%@ page import="project.bean.delivery.DeliveryDTO" %>
<%@ page import="project.bean.cart.CartDAO" %>
<%@ page import="project.bean.cart.CartDTO" %>
<%@ page import="project.bean.img.ImgDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>
<jsp:include page="../main/header.jsp"/>
<style>
	table {
		text-align: center;
		width:1200;
	}

	a {
    	text-decoration: none;
	}
	
	.btn_submit {
	 	background-image: url('../images/cash.png');
	    background-position:  0px 0px;
	    background-repeat: no-repeat;
	    width: 300px;
	    height: 60px;
	    border: 0px;
		cursor:pointer;
		outline: 0;
	}
</style>
<%
	int orderPath = Integer.parseInt(request.getParameter("orderPath"));	// 상품상세 에서 넘어오면 값 "1"
	int snum = (int)session.getAttribute("snum");
	int category_num = Integer.parseInt(request.getParameter("category_num"));
	int count = Integer.parseInt(request.getParameter("count"));
	int product_num = Integer.parseInt(request.getParameter("product_num"));
	
	OrdersDAO ordersDao = OrdersDAO.getInstance();
	ProductDAO productDao = ProductDAO.getInstance();
	MemberDAO memberDao = MemberDAO.getInstance();
	DeliveryDAO deliveryDao = DeliveryDAO.getInstance();
	CartDAO cartDao = CartDAO.getInstance();
	List<ProductDTO> list = ordersDao.orderProduct(product_num);
	List<CartDTO> cartList = cartDao.cartList(snum);
	
// 	System.out.println("오더패스"+orderPath);
// 	System.out.println("상품번호"+product_num);
// 	System.out.println("카테고리"+category_num);
// 	System.out.println("카운트"+count);
	
	
	DecimalFormat formatter = new DecimalFormat("#,###");

	int img_num = Integer.parseInt(request.getParameter("img_num"));
// 	System.out.println(img_num);
	
	int delivery_num = Integer.parseInt(request.getParameter("delivery_num"));
%>
<center>
<TABLE>
	<TR>
		<TD align="left" width="350">
			<div><font size="6"><B>주문서작성/결제</B></font></div>
		</TD>
		<TD align="right">
			<div style="width:800;">
				<font size="2"><B>01 장바구니 ≫ <span style="color: #6B66FF;">02 주문서작성/결제</span> <span style="color: red;">≫</span> 03 주문완료</B></font>
			</div>
		</TD>
	</TR>
	<TR>
		<TD colspan="2">
	<HR align="center" width="100%" size="1"	/>
	<br /><br />
		</TD>
	</TR>
	<TR>
		<TD colspan="2">
			<div align="center" style="width:115"><font size="4"> <B>주문상세내역</B></font></div>	
		</TD>
	</TR>
</TABLE>

<%-- productContent 에서 오면 1, cartList 에서 오면 2 --%>

<TABLE style="border: 1px solid gray; border-left:hidden; border-right:hidden; border-bottom:1px solid #EAEAEA;" cellspacing="0" cellpadding="0">
	<TR bgcolor="#EAEAEA">
		<TH colspan="3" width="240" style="border-right:hidden; border-bottom:1px solid #BDBDBD;">상품/옵션 정보</TH>
		<TH style="border-left:hidden; border-right:hidden; border-bottom:1px solid #BDBDBD;">수량</TH>
		<TH style="border-left:hidden; border-right:hidden; border-bottom:1px solid #BDBDBD;">상품금액</TH>
		<TH style="border-left:hidden; border-right:hidden; border-bottom:1px solid #BDBDBD;">합계금액</TH>
		<TH style="border-left:hidden; border-bottom:1px solid #BDBDBD;">배송비</TH>
	</TR>

<%
	int totalPrice = 0;
	int sumCount = 0;
	int sumTotalPrice = 0;		// 상품개수 * 상품금액 총합
	int sumProductDelivery = 0;	// (할인된) 배송비 합
	int productsNum = 0;

	if (orderPath == 1) {
		for (ProductDTO productDto : list) {
			for (ImgDTO imgDto : productDto.getImages()) {
				int product_delivery = productDao.productDeliveryOne(product_num, count);
				sumCount += count;
				sumTotalPrice += count * productDto.getPrice();
				sumProductDelivery += product_delivery;
				String fmCount = formatter.format(count);
				String fmPrice = formatter.format(productDto.getPrice());
				String fmTotalPrice = formatter.format(count * productDto.getPrice());
				String fmDeliveryPrice = formatter.format(product_delivery);
				DeliveryDTO deliveryDto = deliveryDao.deliveryNum(snum);
// 				System.out.println("폼 상품번호 "+product_num);
// 				System.out.println("폼 오더패스 "+orderPath);
%>
		<TR>
			<TD width="50" height="65" style="border-right:hidden;">
				<A href="#"><img src="../upload/<%= imgDto.getImg_name() %>" width="40" height="40" onclick="window.location='../product/productContent.jsp?product_num=<%= product_num %>&category_num=<%= category_num %>'"	/></A>
			</TD>
			<TD align="left" colspan="2" style="border-left:hidden; border-right:hidden;">
				<A href="../product/productContent.jsp?product_num=<%= product_num %>&category_num=<%= category_num %>">
					<span style="line-height: 30px;">
						<font size="2">
							<B><%= productDto.getProduct_name() %></B>
<%-- 							<input type="hidden" name="product_num" value="<%= productDto.getProduct_num() %>"> --%>
<%-- 							<input type="hidden" name="img_num" value="<%= imgDto.getImg_num() %>"> --%>
<%-- 							<input type="hidden" name="delivery_num" value="<%= deliveryDto.getDelivery_num() %>"> --%>
						</font>
					</span>
				</A>
			</TD>
			<TD style="border-left:1px solid #EAEAEA; border-right:1px solid #EAEAEA;">
				<font size="2">
					<B><%= fmCount %>개</B>
				</font>
			</TD>
			<TD style="">
				<font size="2">
					<B><%= fmPrice %>원</B>
				</font>
			</TD>
			<TD style="border-left:1px solid #EAEAEA; border-right:1px solid #EAEAEA;">
				<font size="2">
					<B><%= fmTotalPrice %>원</B>
				</font>
			</TD>
			<TD style="">
				<font size="2">
					<B><%= fmDeliveryPrice %>원</B>
				</font>
			</TD>
		</TR>
<%
			}
		}
%>
</TABLE>
<%
	}else if (orderPath == 2){
		String[] productNumArr = request.getParameterValues("product_num");
		int[] products = new int[productNumArr.length];
		for (int i=0; i<productNumArr.length; i++) {
			products[i] = Integer.parseInt(productNumArr[i]);
// 			System.out.println(product_num);
			int product_count = Integer.parseInt(request.getParameter("product_count"));
// 			for (CartDTO cartDto : cartList) {						// cart 리스트
// 				List<ProductDTO> orderList = ordersDao.orderProduct(products[i]);
	// 			product_num = cartDto.getProduct_num();
				CartDTO cartDto = cartDao.cartSelect(products[i], snum);
				List<ProductDTO> productList = productDao.productInfo(products[i]);
// 				int productDelivery = productDao.deleteProduct(products[i]);
				if (cartList != null) {
					for (ProductDTO productDto : productList) {		// product 리스트
						if (productList != null) {
							for (ImgDTO imgDto : productDto.getImages()){	// 썸네일을 뽑기위한 for문
								sumCount += cartDto.getProduct_count();
								totalPrice = (productDto.getPrice() * cartDto.getProduct_count());
								sumTotalPrice += totalPrice;
								int productDelivery = productDao.productDelivery(products[i]);
								sumProductDelivery += productDao.productDelivery(products[i]);
								
								String fmCount = formatter.format(cartDto.getProduct_count());
								String fmPrice = formatter.format(productDto.getPrice());
								String fmTotalPrice = formatter.format(totalPrice);
								productsNum++;
%>
	<TR>
		<TD width="50" height="65" style="border-right:hidden; border-bottom:1px solid #EAEAEA;">
			<input type="hidden" name="category_num" value="<%= productDto.getCategory_num() %>">
<%-- 			<input type="hidden" name="count" value="<%= product_count %>"> --%>
<%-- 			<input class="img_class" type="hidden" name="img_num" id="h_img" value="<%= imgDto.getImg_num() %>"> --%>
<%-- 			<input type="hidden" name="product_num" value="<%= products[i] %>"> --%>
		</TD>
		<TD width="50" height="65"  colspan="1" style="border-right:hidden; border-bottom:1px solid #EAEAEA;">
			
			<A href="#"><img src="../upload/<%= imgDto.getImg_name() %>" width="40" height="40" onclick="window.location='../product/productContent.jsp?product_num=<%= productDto.getProduct_num() %>&category_num=<%= productDto.getCategory_num() %>'"	/></A>
		</TD>
		<TD align="left" style="border-left:hidden; border-right:hidden; border-bottom:1px solid #EAEAEA;">
			<A href="../product/productContent.jsp?product_num=<%= productDto.getProduct_num() %>&category_num=<%= productDto.getCategory_num() %>">
				<span style="line-height: 30px;">
					<font size="2">
						<B><%= productDto.getProduct_name() %></B>
					</font>
				</span>
			</A>
		</TD>
		<TD style="border-left:1px solid #EAEAEA; border-right:1px solid #EAEAEA; border-bottom:1px solid #EAEAEA;">
			<font size="2">
				<B><%= fmCount %>개</B>
			</font>
		</TD>
		<TD style="border-bottom:1px solid #EAEAEA;">
			<font size="2">
				<B><%= fmPrice %>원</B>
			</font>
		</TD>
		<TD style="border-left:1px solid #EAEAEA; border-right:1px solid #EAEAEA; border-bottom:1px solid #EAEAEA;">
			<font size="2">
				<B><%= fmTotalPrice %>원</B>
			</font>
		</TD>
		<TD style="">
			<font size="2">
<%
// 					int productDelivery = productDao.productDelivery(product_num);
// 					sumProductDelivery += productDelivery;
					String fmProductDelivery = formatter.format(productDelivery);
%>
				<B><%= fmProductDelivery %>원</B>
			</font>
		</TD>
	</TR>
<%

							}
						}
					}
// 				}
			}
		}
	}
%>
</TABLE>

<%-- 까지 수정해야함 장바구니 불러올 반복문 --%>

<br />
<A href="../cart/cartList.jsp">
	<div align="left" style="width:1195"><font size="2"><U>≪ 장바구니 가기</U></font></div>	
</A>
<%
		ProductDTO dto = productDao.productContent(product_num);

		String fmSumCount = formatter.format(sumCount);
		String fmSumTotalPrice = formatter.format(sumTotalPrice);
		String fmSumProductDelivery = formatter.format(sumProductDelivery);
		String fmFinalPrice = formatter.format(sumTotalPrice + sumProductDelivery);
%>
<br /><br />
<TABLE style="border: 2px solid #BDBDBD;" cellspacing="0" cellpadding="0" height="150">
	<TR>
		<TD style="width:750; border-right:hidden;"></TD>
		<TD style="text-align:center; border-left:hidden; border-right:hidden;">
			<div style="text-align:right;">총 <B><%= fmSumCount  %></B> 개의 상품금액</div>
			<div style="text-align:right;"><font color="#6799FF"><B><%= fmSumTotalPrice %>원</B></font></div>
		</TD>
		<TD style="border-left:hidden; border-right:hidden; width:50;">
			<img src="../images/plus.png" width="30" height="30"	/>
		</TD>
		<TD style="border-left:hidden; border-right:hidden;">
			<div style="text-align:right;">배송비</div>
			<div style="text-align:right;"><font color="#6799FF"><B><%= fmSumProductDelivery %>원</B></font></div>
		</TD>
		<TD style="border-left:hidden; border-right:hidden; width:50;">
			<img src="../images/equal.png" width="15" height="15"	/>
		</TD>
		<TD style="border-left:hidden;">
			<div style="text-align:right;">합계</div>
			<div style="text-align:right;"><font color="#6799FF"><B><%= fmFinalPrice %>원</B></font></div>
		</TD>
		<TD style="padding:20;"></TD>
	</TR>
</TABLE>

<br /><br />

<%
	MemberDTO memberDto = memberDao.memberInfo(snum);
	List<DeliveryDTO> deliveryList = deliveryDao.addressInfo(snum);
%>
<form action="orderPro.jsp" method="post" name="orders_form" id="orderForm">
	<input type="hidden" name="member_num" value="<%= snum %>"	/>
<%-- 	<input type="hidden" name="product_num" value="<%= product_num %>"	/> --%>
<%-- 	<input type="hidden" name="img_num" value="<%= img_num %>"	/> --%>
<%-- 	<input type="hidden" name="count" value="<%= count %>"> --%>
<%-- 	<input type="hidden" name="final_price" value="<%= (count * dto.getPrice()) + dto.getDelivery_price() %>"> --%>
	
<%
	if (orderPath == 1) {
		for (ProductDTO productDto : list) {
			for (ImgDTO imgDto : productDto.getImages()) {
%>
		<input type="hidden" name="orderPath" value="<%= orderPath %>"	/>
		<input type="hidden" name="product_num" value="<%= productDto.getProduct_num() %>"	/>
		<input type="hidden" name="img_num" value="<%= imgDto.getImg_num() %>"	/>
		<input type="hidden" name="count" value="<%= count %>"	/>
		<input type="hidden" name="final_price" value="<%= productDto.getPrice() * count + productDto.getDelivery_price() %>"	/>
<%-- 		<input type="hidden" name="delivery_num" value="<%= .getProduct_num() %>"	/> --%>
<%
			}
		}
	}else if (orderPath == 2) {
%>
		<input type="hidden" name="orderPath" value="<%= orderPath %>"	/>
		<input type="hidden" name="productsNum" value="<%= productsNum %>"	/>
<%
		String[] productNumArr = request.getParameterValues("product_num");
		int[] products = new int[productNumArr.length];
		for (int i=0; i<productNumArr.length; i++) {
			products[i] = Integer.parseInt(productNumArr[i]);
			CartDTO cartDto = cartDao.cartSelect(products[i], snum);
%>
<%
			List<ProductDTO> productList = productDao.thumbnail(products[i]);
// 			System.out.println("프로덕트"+products[i]);
			int productDelivery = productDao.productDelivery(products[i]);
			ProductDTO productsDto = productDao.productContent(products[i]);
			DeliveryDTO deliveryDto = deliveryDao.deliveryNum(snum);
			for (ProductDTO productDto : productList) {
				for (ImgDTO imgDto : productDto.getImages()) {
// 					System.out.println(productsDto.getPrice());
// 					System.out.println(cartDto.getProduct_count());
// 					System.out.println(productDelivery);
					
%>

			<input type="hidden" name="product_num" value="<%= products[i] %>">
			<input type="hidden" name="count" value="<%= cartDto.getProduct_count() %>">
			<input type="hidden" name="final_price" value="<%= productsDto.getPrice() * cartDto.getProduct_count() + productDelivery %>">
			<input type="hidden" name="img_num" value="<%= imgDto.getImg_num() %>">
			<input type="hidden" name="delivery_num" value="<%= deliveryDto.getDelivery_num() %>">
<%
// 			System.out.println("gg"+deliveryDto.getDelivery_num());
				}
			}
		}
%>
<%
	}
	for (DeliveryDTO deliveryDto : deliveryList) {
%>
	<input type="hidden" name="delivery_name" id="delivery_name" value="<%= deliveryDto.getDelivery_name() %>">
	<input type="hidden" name="name" value="<%= deliveryDto.getName() %>">	<%-- delivery 테이블의 name, orders 테이블의 orders_name 컬럼명 불일치로 dao.addressInfo()에서 가져옴 --%>
<%
	}
%>
<TABLE style="border: 1px solid gray; border-left:hidden; border-right:hidden; border-top:hidden; border-bottom:1px solid #EAEAEA;" cellspacing="0" cellpadding="0">
	<TR>
		<TD colspan="3">
			<div align="center" style="width:90"><font size="3"> <B>주문자 정보</B></font></div>
			<HR align="center" width="100%" size="1"	/>
		</TD>
	</TR>
	<TR>
		<TD width="1%" style="border-bottom:1px solid #EAEAEA;">
			<img src="../images/reddot.png" width="5" height="5"	/>
		</TD>
		<TD width="200" height="50" style="border-bottom:1px solid #EAEAEA;">
			<div style="width:83; float:left;">
				<font size="2"><B>주문하시는 분</B></font>
			</div>
		</TD>
		<TD align="left" style="border-bottom:1px solid #EAEAEA;">
			<input type="text" name="orders_name" id="orders_name" value="<%= memberDto.getName() %>"	/>
		</TD>
	</TR>
	<TR>
		<TD width="1%" style="border-bottom:1px solid #EAEAEA;">
			<img src="" width="5" height="5"	/>
		</TD>
		<TD width="200" height="50" style="border-bottom:1px solid #EAEAEA;">
			<div style="width:26; ">
				<font size="2"><B>주소</B></font>
			</div>
		</TD>
		<TD align="left" style="border-bottom:1px solid #EAEAEA;">
		
			<select name="delivery_num" style="width:280;" id="delivery_num">
<%
	for (DeliveryDTO deliveryDto : deliveryList) {
%>
			<option value="<%= deliveryDto.getDelivery_num() %>">[<%= deliveryDto.getAddress1() %>] <%= deliveryDto.getAddress2() %> <%= deliveryDto.getAddress3() %></option>
<%
	}
%>
			</select>
		</TD>
	</TR>
	<TR>
		<TD width="1%" style="border-bottom:1px solid #EAEAEA;">
			<img src="" width="5" height="5"	/>
		</TD>
		<TD width="200" height="50" style="border-bottom:1px solid #EAEAEA;">
			<div style="width:53; float:left;">
				<font size="2"><B>전화번호</B></font>
			</div>
		</TD>
		<TD align="left" style="border-bottom:1px solid #EAEAEA;">
<%
	if (memberDto.getPhone() != null){
%>
			<input type="text" name="m_phone" value="<%= memberDto.getPhone() %>"	/>
			
<%
	}else {
%>
			<input type="text" name="m_phone" id="o_phone"  value="" />
			
<%
	}
%>
		</TD>	<%-- 깡통 text 박스. 배송정보의 phone 이 회원 테이블의 phone 으로 업데이트되어야함. (AJAX) --%>
	</TR>
	<TR>
		<TD width="1%" style="border-bottom:1px solid #EAEAEA;">
			<img src="../images/reddot.png" width="5" height="5"	/>
		</TD>
		<TD width="200" height="50" style="border-bottom:1px solid #EAEAEA;">
			<div style="width:70; float:left;">
				<font size="2"><B>휴대폰 번호</B></font>
			</div>
		</TD>
		<TD align="left" style="border-bottom:1px solid #EAEAEA;">
<%
	if (memberDto.getCellphone() != null){
%>
			<input type="text" name="m_cellphone" id="m_cellphone" value="<%= memberDto.getCellphone() %>"	/>
<%
	}else {
%>
			<input type="text" name="m_cellphone" value=""	/>
<%
	}
%>
		</TD>						<%-- 깡통 text 박스 --%>
	</TR>
	<TR>
		<TD width="1%" style="border-bottom:1px solid #EAEAEA;">
			<img src="" width="5" height="5"	/>
		</TD>
		<TD width="200" height="50" style="border-bottom:1px solid #EAEAEA;">
			<div style="width:39;">
				<font size="2"><B>이메일</B></font>
			</div>
		</TD>
		<TD align="left" style="border-bottom:1px solid #EAEAEA;">
<%
	if (memberDto.getEmail() != null){
%>
			<input type="text" name="email" id="email" value="<%= memberDto.getEmail() %>"	/>
<%
	}else {
%>
			<input type="text" id="email">
			<input type="hidden" name="email" id="h_email" value="none">
<%
	}
%>
			<select name="email" id="email_select" onchange="updateEmail()">
				<option>직접입력</option>						<%-- 스크립트 나중에 만들어보기 -완- --%>
				<option value="@naver.com">naver.com</option>
				<option value="@hanmail.net">hanmail.net</option>
				<option value="@daum.net">daum.net</option>
				<option value="@nate.com">nate.com</option>
				<option value="@hotmail.com">hotmail.com</option>
				<option value="@gmail.com">gmail.com</option>
				<option value="@icloude.com">icloude.com</option>
			</select>
			<script>
				function updateEmail() {								// 이메일 선택 상자가 변경될 때 호출되는 함수
					var emailInput = document.getElementById("email");	// 이메일 입력 필드와 이메일 선택 상자의 값을 가져옴
					var emailSelect = document.getElementById("email_select");
					var selectedDomain = emailSelect.value;
					if (selectedDomain === "직접입력") {					// 직접입력이 선택된 경우, 이메일 입력 필드를 빈 값으로 설정
						emailInput.value = "";
					} else {
						emailInput.value = selectedDomain;				// 선택된 도메인을 이메일 입력 필드에 추가
					}
				}
				document.getElementById('email').addEventListener('input', function() {
					let email_value = document.getElementById('email').value;
					document.getElementById('h_email').value = email_value;
				});
			
			</script>
		</TD>
	</TR>
</TABLE>
<br /><br />

<%
	DeliveryDTO defaultValDto = deliveryDao.defaultVal(snum);	// 배송지 확인 체크여부에따라 값 나오게 -완-
%>

<TABLE style="border: 1px solid gray; border-left:hidden; border-right:hidden; border-top:hidden; border-bottom:1px solid #EAEAEA;" cellspacing="0" cellpadding="0">
	<TR>
		<TD colspan="3">
			<div align="center" style="width:75"><font size="3"> <B>배송 정보</B></font></div>
			<HR align="center" width="100%" size="1"	/>
		</TD>
	</TR>
	<TR>
		<TD width="1%" style="border-bottom:1px solid #EAEAEA;">
			<img src="" width="5" height="5"	/>
		</TD>
		<TD width="200" height="50" style="border-bottom:1px solid #EAEAEA;">
			<div style="width:70; float:left;">
				<font size="2"><B>배송지 확인</B></font>
			</div>
		</TD>
		<TD align="left" style="border-bottom:1px solid #EAEAEA;">	<%-- 수정) 직접 입력 일 때 값 "" (공백) if 걸어서 서밋 못하게 + alert 창 --%>
		
<%-- <% 
	if (defaultValDto.getAddress3() == null) {--%>
<%-- %> --%>
<%-- 			<input type="radio" name="default_address" id="defualt" value="2" onclick="return false"			/><font size="2">기본 배송지</font>			value 보내야함 --%>
<!-- 			&nbsp;&nbsp;&nbsp; -->
<!-- 			<input type="radio" name="default_address" id="direct" value="1" onclick="getDelivery(event)" checked	/><font size="2">직접 입력</font> -->
<!-- 			&nbsp;&nbsp;&nbsp; -->
<!-- 			<input type="radio" name="default_address" id="equal" value="0" onclick="return false"			/><font size="2">주문자정보와 동일</font> -->
<!-- 			&nbsp;&nbsp;&nbsp; -->
<%-- <% --%>
<!-- 	} -->
<%
	System.out.println(defaultValDto.getDefault_address());
	System.out.println(snum);

	if (defaultValDto.getDefault_address().equals("2")) {
%>
			<input type="radio" name="default_address" id="default" value="2" onclick="getDelivery(event)"			/><font size="2">기본 배송지</font>			<%-- value 보내야함 --%>
			&nbsp;&nbsp;&nbsp;
<%	}else{ %>
			<input type="radio" name="default_address" id="default" value="2" onclick="nodefault()"					/><font size="2">기본 배송지</font>			<%-- value 보내야함 --%>
			&nbsp;&nbsp;&nbsp;
			
<%	} %>
			<input type="radio" name="default_address" id="direct" value="1" onclick="getDelivery(event)" checked	/><font size="2">직접 입력</font>
			&nbsp;&nbsp;&nbsp;
			<input type="radio" name="default_address" id="equal" value="0" onclick="getDelivery(event)"			/><font size="2">주문자정보와 동일</font>
			&nbsp;&nbsp;&nbsp;	
																				<%-- 주문자정보와 동일은 0으로 값 지정함 --%>
			<script>
			function nodefault(){
				let radio = document.getElementById("default");
				let direct = document.getElementById("direct");
				alert("기본배송지가 없습니다.");
				radio.disabled=true ;
				direct.checked=true;
			}
			
			
			
			function getDelivery(event) {					// 클릭된 라디오 버튼의 값을 가져옴
				var selectedValue = event.target.value;		// 조건에 따라 input 태그의 value 속성에 값을 넣음
			
				if (selectedValue === "2") {				// 기본 배송지일 때
					document.getElementById("receiver_name").value = "<%= defaultValDto.getName() %>";
				}
				if (selectedValue === "2") {
					document.getElementById("address1").value = "<%= defaultValDto.getAddress1() %>";
				}
				if (selectedValue === "2") {
					document.getElementById("address2").value = "<%= defaultValDto.getAddress2() %>";
				}
				if (selectedValue === "2") {
					document.getElementById("address3").value = "<%= defaultValDto.getAddress3() %>";
				}
				if (<%= defaultValDto.getPhone() != null %>) {
					if (selectedValue === "2") {
						document.getElementById("phone").value = "<%= defaultValDto.getPhone() %>";
					}
				}else {
					if (selectedValue === "2") {
						document.getElementById("phone").value = "";
					}
				}
				if (selectedValue === "2") {
					document.getElementById("cellphone").value = "<%= defaultValDto.getCellphone() %>";
				}
// 				--------------------

				if (selectedValue === "1") {				// 직접 입력일 때
					document.getElementById("receiver_name").value = "";
				}
				if (selectedValue === "1") {
					document.getElementById("address1").value = "";
				}
				if (selectedValue === "1") {
					document.getElementById("address2").value = "";
				}
				if (selectedValue === "1") {
					document.getElementById("address3").value = "";
				}
				if (selectedValue === "1") {
					document.getElementById("phone").value = "";
				}
				if (selectedValue === "1") {
					document.getElementById("cellphone").value = "";
				}
// 				--------------------

				if (selectedValue === "0") {				// 주문자정보와 동일할 때
					document.getElementById("receiver_name").value = "<%= memberDto.getName() %>";				// 회원 테이블에 있는 컬럼만 memberDTO에서 꺼내옴
				}
				if (selectedValue === "0") {												
					document.getElementById("address1").value = "<%= defaultValDto.getAddress1() %>";	// 회원가입할때 배송지 안받아서 member테이블에서 꺼내올 수 없음
				}
				if (selectedValue === "0") {
					document.getElementById("address2").value = "<%= defaultValDto.getAddress2() %>";
				}
				
				if (selectedValue === "0") {
					document.getElementById("address3").value = "<%= defaultValDto.getAddress3() %>";
				}
				if (<%= memberDto.getPhone() == null %>){
					if (selectedValue === "0") {
						document.getElementById("phone").value = document.getElementById('o_phone').value;
					}
				}else {
					if (selectedValue === "0") {
						document.getElementById("phone").value = "<%= memberDto.getPhone() %>";
					}
				}
				
		
				if (selectedValue === "0") {
					document.getElementById("cellphone").value = "<%= memberDto.getCellphone() %>";
				}
			}
			</script>
			
			<input type="button" value="배송지 관리" onclick="clickDelivery();"	/>
			<script>
				function clickDelivery() {
					window.open("../member/delivery/list.jsp", 'popup', 'width=1300, height=600, resizable=yes');	// delivery 배송지관리 팝업창 띄워줌 -완-
				}
			</script>
		</TD>
	</TR>
	
	<TR>
		<TD width="1%" style="border-bottom:1px solid #EAEAEA;">
			<img src="../images/reddot.png" width="5" height="5"	/>
		</TD>
		<TD width="200" height="50" style="border-bottom:1px solid #EAEAEA;">
			<div style="width:53; ">
				<font size="2"><B>받으실분</B></font>
			</div>
		</TD>
		<TD align="left" style="border-bottom:1px solid #EAEAEA;">
			<input type="text" name="receiver_name" id="receiver_name"	/>
		</TD>
	</TR>
	<TR>
		<TD width="1%" style="border-bottom:1px solid #EAEAEA;">
			<img src="../images/reddot.png" width="5" height="5"	/>
		</TD>
		<TD width="200" height="50" style="border-bottom:1px solid #EAEAEA;">
			<div style="width:57; float:left;">
				<font size="2"><B>받으실 곳</B></font>
			</div>
		</TD>
		<TD align="left" style="border-bottom:1px solid #EAEAEA;">
			<input type="text" name="address1" id="address1"	/> <input type="button" value="우편번호 검색" onclick="window.open('https://www.epost.go.kr/search.RetrieveIntegrationNewZipCdList.comm')"	/>	<br />
			<input type="text" name="address2" id="address2" style="width:330;"	/>
			<input type="text" name="address3" id="address3"	/>
		</TD>
	</TR>
	<TR>
		<TD width="1%" style="border-bottom:1px solid #EAEAEA;">
			<img src="" width="5" height="5"	/>
		</TD>
		<TD width="200" height="50" style="border-bottom:1px solid #EAEAEA;">
			<div style="width:53; float:left;">
				<font size="2"><B>전화번호</B></font>
			</div>
		</TD>
		<TD align="left" style="border-bottom:1px solid #EAEAEA;">
			<input type="text" id="phone"	/>
			<input type="hidden" name="phone" id="h_phone" value="none">	
		<script>
			document.getElementById('phone').addEventListener('input', function() {
				let phone_value = document.getElementById('phone').value;
				if(phone_value !== ""){
					document.getElementById('h_phone').value = phone_value;
				}else{
					document.getElementById('h_phone').value = "none";
				}		
			});
		</script>
		</TD>
	</TR>
	<TR>
		<TD width="1%" style="border-bottom:1px solid #EAEAEA;">
			<img src="../images/reddot.png" width="5" height="5"	/>
		</TD>
		<TD width="200" height="50" style="border-bottom:1px solid #EAEAEA;">
			<div style="width:70; float:left;">
				<font size="2"><B>휴대폰 번호</B></font>
			</div>
		</TD>
		<TD align="left" style="border-bottom:1px solid #EAEAEA;">
			<input type="text" name="cellphone" id="cellphone"	/>
<%-- 			<input type="hidden" name="cellphone" value="<%= defaultValDto.getCellphone() %>"	/> --%>
		</TD>
	</TR>
<TR>
		<TD width="1%">
			<img src="" width="5" height="5"	/>
		</TD>
		<TD width="200" height="50">
			<div style="width:83; float:left;">
				<font size="2"><B>회원정보 반영</B></font>
			</div>
		</TD>
		<TD align="left">
<%
		if (defaultValDto.getAddress3() == null) {
%>
			<input type="checkbox" value="1" checked onclick="return false;"		/>
			<input type="hidden" name="deliveryInsert" value="1"		/>
			<font size="2" color="#6799FF">나의 배송지에 자동 추가됩니다.</font>	<br />
			<input type="checkbox" name="memberUpdate" value="1"		/>
			<font size="2">위 내용을 회원정보에 반영합니다. (전화번호/휴대폰번호)</font>
<%
		}else {
%>
			<input type="checkbox" name="deliveryInsert" value="1"		/>				<%-- /delivery/deliveryInsert.jsp / pro 에서 파라미터 받아야함 -완- --%>
			<font size="2" color="#6799FF">나의 배송지에 추가합니다.</font>	<br />
			<input type="checkbox" name="memberUpdate" value="1"		/>				<%-- /member/memberUpdate.jsp / pro 에서 파라미터 받아야함 -완- --%>
			<font size="2">위 내용을 회원정보에 반영합니다. (전화번호/휴대폰번호)</font>		<%-- 어떻게 넘길지 구상 -완- --%>
<%
		}
%>
		</TD>	<%-- 주소/전화번호/휴대폰번호 였으나, 회원가입 시 주소를 안받는 관계로 주소 지움 (member 테이블에 주소 컬럼 없음) --%>
	</TR>
</TABLE>
<br /><br />

<TABLE style="border: 1px solid gray; border-left:hidden; border-right:hidden; border-top:hidden; border-bottom:1px solid #EAEAEA;" cellspacing="0" cellpadding="0">
	<TR>
		<TD colspan="3">
			<div align="center" style="width:75"><font size="3"> <B>결제 정보</B></font></div>
			<HR align="center" width="100%" size="1"	/>
		</TD>
	</TR>
	<TR>
		<TD width="1%" style="border-bottom:1px solid #EAEAEA;">
			<img src="" width="5" height="5"	/>
		</TD>
		<TD width="200" height="50" style="border-bottom:1px solid #EAEAEA;">
			<div style="width:88; float:left;">
				<font size="2"><B>상품 합계 금액</B></font>
			</div>
		</TD>
		<TD align="left" style="border-bottom:1px solid #EAEAEA;">
			<font size="4"><B><%= fmSumTotalPrice %>원</B></font>
		</TD>
	</TR>
	<TR>
		<TD width="1%" style="border-bottom:1px solid #EAEAEA;">
			<img src="" width="5" height="5"	/>
		</TD>
		<TD width="200" height="50" style="border-bottom:1px solid #EAEAEA;">
			<div style="width:39; ">
				<font size="2"><B>배송비</B></font>
			</div>
		</TD>
		<TD align="left" style="border-bottom:1px solid #EAEAEA;">
			<font size="2"><%= fmSumProductDelivery %>원</font>
		</TD>
	</TR>
	<TR>
		<TD width="1%">
			<img src="" width="5" height="5"	/>
		</TD>
		<TD width="200" height="50">
			<div style="width:88; float:left;">
				<font size="2"><B>최종 결제 금액</B></font>
			</div>
		</TD>
		<TD align="left">
			<font size="4"><B><%= fmFinalPrice %>원</B></font>
		</TD>
	</TR>
</TABLE>
<br /><br />

<TABLE style="border: 1px solid gray; border-left:hidden; border-right:hidden; border-top:hidden; border-bottom:1px solid #EAEAEA;" cellspacing="0" cellpadding="0">
	<TR>
		<TD colspan="3">
			<div align="center" style="width:160"><font size="3"> <B>결제수단 선택 / 결제</B></font></div>
			<HR align="center" width="100%" size="1"	/>
		</TD>
	</TR>
	<TR>
		<TD width="1%">
			<img src="" width="5" height="5"	/>
		</TD>
		<TD width="200" height="80">
			<div style="width:57; float:left;">
				<font size="2"><B>일반 결제</B></font>
			</div>
		</TD>
		<TD align="left">
			<input type="radio" name="payment_option" value="1" checked	/><font size="2">신용카드</font>	&nbsp;&nbsp;
			<input type="radio" name="payment_option" value="2"			/><font size="2">계좌이체</font>	&nbsp;&nbsp;
			<input type="radio" name="payment_option" value="3"			/><font size="2">가상계좌</font>	&nbsp;&nbsp;
			<input type="radio" name="payment_option" value="4"			/><font size="2">카카오페이</font>
		</TD>
	</TR>
</TABLE>
<br /><br />

<TABLE style="border: 2px solid #BDBDBD;" cellspacing="0" cellpadding="0" height="100">
	<TR>
		<TD style="width:850;"></TD>
		<TD>
			<div style="text-align:right;"><font size="2"><B>최종 결제 금액</B></font></div>
		</TD>
		<TD>
			<div style="text-align:right;"><font size="6" color="#6799FF"><B><%= fmFinalPrice %>원</B></font></div>
		</TD>
		<TD style="padding:20;"></TD>
	</TR>
</TABLE>
<br /><br />

<input type="checkbox" name="lastCheck" id="lastCheck" value="1"	/>

<font size="2"><span style="color:#6799FF;"><B>(필수)</B></span> 구매하실 상품의 결제정보를 확인하였으며, 구매진행에 동의합니다.</font>
<br /><br />
<input type="button" value="" id="btn_submit" class="btn_submit"	/>


<script>
document.getElementById("btn_submit").addEventListener("click", function(event) {
	var lastCheck = document.getElementById("lastCheck");
	var orders_nameValue = document.getElementById("orders_name").value;
	var m_cellphoneValue = document.getElementById("m_cellphone").value;
// 	var emailValue = document.getElementById("email").value;		 !emailValue 이메일 필수아님
	var receiver_nameValue = document.getElementById("receiver_name").value;
	var address1Value = document.getElementById("address1").value;
	var address2Value = document.getElementById("address2").value;
	var address3Value = document.getElementById("address3").value;
	var cellphoneValue = document.getElementById("cellphone").value;
	
	var errorMessage = "";
	if (!orders_nameValue || !m_cellphoneValue || !receiver_nameValue || !address1Value || !address2Value || !address3Value || !cellphoneValue) {
		errorMessage = "모든 필수 정보를 입력하세요.";
	}else if (!lastCheck.checked) {
		errorMessage = "청약의사 재확인을 동의해 주셔야 주문을 진행하실 수 있습니다.";
	}
	if (errorMessage) {					// 값이 비어있지 않다면
		alert(errorMessage);			// 경고창에 변수로 지정한 error메세지 표시
		event.preventDefault();			// submit 중지
	}else if (<%= orderPath != 0 %>) {
		document.getElementById("orderForm").submit();
	}
});
</script>
</form>
</center>