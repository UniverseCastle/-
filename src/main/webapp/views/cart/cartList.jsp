<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.cart.CartDAO" %>
<%@ page import="project.bean.cart.CartDTO" %>
<%@ page import="project.bean.product.ProductDAO" %>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="project.bean.img.ImgDTO" %>
<%@ page import="project.bean.delivery.DeliveryDTO" %>
<%@ page import="project.bean.delivery.DeliveryDAO" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.DecimalFormat" %>
    
<%
	int snum = (int)session.getAttribute("snum");
	CartDAO cartDao = CartDAO.getInstance();
	ProductDAO productDao = ProductDAO.getInstance();
	ArrayList<CartDTO> cartList = cartDao.cartList(snum);
	
	DecimalFormat formatter = new DecimalFormat("#,###");
%>
    						<%-- 리스트에서 상품 수량 품절 체크! --%>
<style>
	table {
		text-align: center;
		width:1200;
	}

	a {
    	text-decoration: none;
	}
	
	.btn_submit {
	 	background-image: url('../images/결제하기.png');
	    background-position:  0px 0px;
	    background-repeat: no-repeat;
	    width: 300px;
	    height: 60px;
	    border: 0px;
		cursor:pointer;
		outline: 0;
	}
</style>
    
    <jsp:include page="../main/header.jsp"/>
<center>

<form action="../orders/orderForm.jsp" method="post" id="cartForm">
	<input type="hidden" name="orderPath" value="2">
	
<TABLE>
	<TR>
		<TD align="left" width="350">
			<div><font size="6"><B>장바구니</B></font></div>
		</TD>
		<TD align="right">
			<div style="width:800;">
				<font size="2"><B><span style="color: #6B66FF;">01 장바구니</span> <span style="color: red;">≫</span> 02 주문서작성/결제 ≫ 03 주문완료</B></font>
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

<TABLE style="border: 1px solid gray; border-left:hidden; border-right:hidden; border-bottom:1px solid #EAEAEA;" cellspacing="0" cellpadding="0">
	<TR bgcolor="#EAEAEA">
		<TH colspan="1" style="border-bottom:1px solid #BDBDBD;">
			<input type="checkbox" id="chkAll"	/>
		</TH>
		<TH colspan="2" width="240" style="border-right:hidden; border-bottom:1px solid #BDBDBD;">상품/옵션 정보</TH>
		<TH style="border-left:hidden; border-right:hidden; border-bottom:1px solid #BDBDBD;">수량</TH>
		<TH style="border-left:hidden; border-right:hidden; border-bottom:1px solid #BDBDBD;">상품금액</TH>
		<TH style="border-left:hidden; border-right:hidden; border-bottom:1px solid #BDBDBD;">합계금액</TH>
		<TH style="border-left:hidden; border-bottom:1px solid #BDBDBD;">배송비</TH>
		<script>
			document.querySelector('#chkAll');
			chkAll.addEventListener('click', function(){
				const isChecked = chkAll.checked;
				if (isChecked){
					const checkboxes = document.querySelectorAll('.chk');
					for (const checkbox of checkboxes){
						checkbox.checked = true;
					}
				}else {
					const checkboxes = document.querySelectorAll('.chk');
					for (const checkbox of checkboxes){
						checkbox.checked = false;
					}
				}
			})
			const checkboxes = document.querySelectorAll('.chk');
			for(const checkbox of checkboxes){
    			checkbox.addEventListener('click', function(){
       				const totalCnt = checkboxes.length;
        			const checkedCnt = document.querySelectorAll('.chk:checked').length;
       				if(totalCnt == checkedCnt){
           				document.querySelector('#chkAll').checked = true;
        			}else {
            			document.querySelector('#chkAll').checked = false;
        			}
    			});
			}
		</script>
	</TR>

<%
	int sumCount = 0;
	int sumTotalPrice = 0;		// 상품개수 * 상품금액 총합
	int sumProductDelivery = 0;	// (할인된) 배송비 합
	for (CartDTO cartDto : cartList) {						// cart 리스트
		int product_num = cartDto.getProduct_num();
		ArrayList<ProductDTO> productList = productDao.productInfo(product_num);
	
		if (cartList != null) {
			for (ProductDTO productDto : productList) {		// product 리스트
				if (productList != null) {
					String fmPrice = formatter.format(productDto.getPrice());
					String fmTotalPrice = formatter.format(productDto.getPrice() * cartDto.getProduct_count());
					String fmDeliveryPrice = formatter.format(productDto.getDelivery_price());
					for (ImgDTO imgDto : productDto.getImages()){	// 썸네일을 뽑기위한 for문
						sumCount += cartDto.getProduct_count();
						sumTotalPrice += (productDto.getPrice() * cartDto.getProduct_count());
						
						DeliveryDAO deliveryDao = DeliveryDAO.getInstance();
						DeliveryDTO deliveryDto = deliveryDao.deliveryNum(snum);
						
%>
	<TR>
		<TD width="50" height="65" style="border-right:hidden; border-bottom:1px solid #EAEAEA;">
<%

%>
			<input type="checkbox" name="product_num" class="chk" id="chk" value="<%= product_num %>"	/>
			<input type="hidden" name="category_num" value="<%= productDto.getCategory_num() %>">
			<input type="hidden" name="product_count" value="<%= cartDto.getProduct_count() %>">
			<input type="hidden" name="img_num" value="<%= imgDto.getImg_num() %>">
			<input type="hidden" name="delivery_num" value="<%= deliveryDto.getDelivery_num() %>">
			<input type="hidden" name="count" value="<%= cartDto.getProduct_count() %>">
<%-- 			<input type="hidden" name="product_num" value="<%= productDto.getProduct_num() %>"> --%>

		</TD>
		<TD width="50" height="65" style="border-right:hidden; border-bottom:1px solid #EAEAEA;">
			
			<A href="#"><img src="../upload/<%= imgDto.getImg_name() %>" width="40" height="40" onclick="window.location='../product/productContent.jsp?product_num=<%= productDto.getProduct_num() %>&category_num=<%= productDto.getCategory_num() %>'"	/></A>
		</TD>
		<TD align="left" colspan="1" style="border-left:hidden; border-right:hidden; border-bottom:1px solid #EAEAEA;">
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
				<B><%= cartDto.getProduct_count() %>개</B>
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
				int productDelivery = productDao.productDelivery(product_num);
				sumProductDelivery += productDelivery;
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
		}
	}
%>
</TABLE>
<br />
<A href="../main/main.jsp">
	<div align="left" style="width:1195"><font size="2"><U>≪ 쇼핑 계속하기</U></font></div>	
</A>

<br /><br />
<%
	String fmCount = formatter.format(sumCount);
	String fmTotalPrice = formatter.format(sumTotalPrice);
	String fmSumProductDelivery = formatter.format(sumProductDelivery);
	String fmFinalPrice = formatter.format(sumTotalPrice + sumProductDelivery);
%>
<TABLE style="border: 2px solid #BDBDBD;" cellspacing="0" cellpadding="0" height="150">
	<TR>
		<TD style="width:750; border-right:hidden;"></TD>
		<TD style="text-align:center; border-left:hidden; border-right:hidden;">
			<div style="text-align:right;">총 <B><%= fmCount %></B> 개의 상품금액</div>
			<div style="text-align:right;"><font color="#6799FF"><B><%= fmTotalPrice %>원</B></font></div>
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
<br />
<div align="left" style="width:1195">
	<input type="button" value="선택 상품 삭제" onclick="submitCheckedProducts()"	/>
</div>	
<div align="right" style="width:1195">
<%-- 	<input type="button" value="선택 상품 주문" onclick="submitSelectedProducts()"	/>	--%>
	<button type="button" onclick="submitSelectedProducts()">선택 상품 주문</button>
	<button type="button" onclick="submitAllProducts()">전체 상품 주문</button>
<!-- 	<input type="submit" value="전체 상품 주문"	/> -->
</div>
</form>
</center>

<script>
function submitAllProducts() {
    var checkboxes = document.querySelectorAll('input[type="checkbox"]');
    checkboxes.forEach(function(checkbox) {
        checkbox.checked = true; // 모든 체크박스를 선택합니다.
    });
    let chk = document.getElementById("chk");
    if(chk === null){
    	alert("장바구니에 상품이 없습니다.");
    	return;
    }else{
    	document.getElementById('cartForm').submit(); // 폼을 제출합니다.
    }
    
}
</script>

<form action="deleteCartPro.jsp" id="btn_delete" method="post">

</form>

<script>
	function submitSelectedProducts(){
		let checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');
	    let chk = document.getElementById("chk");
	    if(chk === null){
	    	alert("장바구니에 상품이 없습니다.");
	    	return;
	    }
	    if(checkboxes.length === 0){
	    	alert("선택한 상품이 없습니다.");
	    	return;
	    }else{
	    	document.getElementById('cartForm').submit(); // 폼을 제출합니다.
	    }
	}



	function submitCheckedProducts() {
	    var checkedValues = []; // 체크된 체크박스 값들을 저장할 배열
	
	    // 클래스명이 'chk'인 모든 체크박스 선택
	    var checkboxes = document.querySelectorAll('.chk');
	    
	    // 각 체크박스의 체크 여부를 확인하여 체크된 경우에만 값을 배열에 추가
	    checkboxes.forEach(function(checkbox) {
	        if (checkbox.checked) {
	            checkedValues.push(checkbox.value);
	        }
	    });
	
	    // 체크된 항목이 있는 경우에만 서브밋
	    if (checkedValues.length > 0) {
	        // form 엘리먼트 생성
	        var form = document.createElement('form');
	        form.setAttribute('method', 'post');
	        form.setAttribute('action', 'deleteCartPro.jsp');
	
	        // 각 체크된 값들을 hidden input으로 추가
	        checkedValues.forEach(function(value) {
	            var input = document.createElement('input');
	            input.setAttribute('type', 'hidden');
	            input.setAttribute('name', 'product_num');
	            input.setAttribute('value', value);
	            form.appendChild(input);
	        });
	
	        // form을 body에 추가하고 submit
	        document.body.appendChild(form);
	        form.submit();
	    } else {
	        alert('선택된 상품이 없습니다.');
	    }
	}
</script>