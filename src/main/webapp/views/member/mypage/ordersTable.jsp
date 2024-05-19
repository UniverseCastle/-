<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.mypage.MypageDAO" %>
<%@ page import="project.bean.mypage.MypageWrapper" %>
<%@ page import="project.bean.orders.OrdersDTO" %>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="project.bean.img.ImgDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat" %>

<% request.setCharacterEncoding("UTF-8"); %>

<%-- 정해진 기간 주문/배송 현황 --%>

<link rel="stylesheet" type="text/css" href="/project/views/css/member.css">

<STYLE>
	INPUT[type="checkbox"]:disabled {
    	cursor: not-allowed;
	}
</STYLE>

<%
	int snum = (int)session.getAttribute("snum");
	String svendor = (String)session.getAttribute("svendor");
	String start = "";
	String end = "";
	
	if(request.getParameter("start")==null){
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		start =  sdf.format(date);
	}else{	
		start = request.getParameter("start");	//조회 시작 날짜
	}
	
	if(request.getParameter("end")==null){
		Date date = new Date();
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
		end =  sdf2.format(date);
	}else{	
		end = request.getParameter("end");	//조회 시작 날짜
	}
	
	String pageNum = "1";
	
	MypageDAO dao = MypageDAO.getInstance();
	
	int orders_count = dao.orders_count(snum, start, end);
	
	ArrayList<MypageWrapper> list = dao.orders(snum, start, end);
%>

<TABLE class="maintable" border="1" width="882px">
	<TR>
		<TD colspan="5"> 주문목록/배송조회 내역 총 <%=orders_count %> 건 </TD>
	</TR>
	<TR>
		<TH width="120px">날짜/주문번호</TH>
		<TH>상품명</TH>
		<TH width="80px">상품금액/수량</TH>
		<TH width="100px">배송상태</TH>
		<TH width="80px">취소/반품/교환신청</TH>
	</TR>
	
<%	if(orders_count==0) {
%>
		<TR>
			<TD colspan="5"> 조회내역이 없습니다. </TD>
		</TR>	
<%	}else {
		for(MypageWrapper wrapper : list) {
			OrdersDTO ordersDTO = wrapper.getOrdersDTO();
			ProductDTO productDTO = wrapper.getProductDTO();
			ImgDTO imgDTO = wrapper.getImgDTO();
				
			// SimpleDateFormat을 사용하여 포맷 지정
		    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		    // format 메서드를 사용하여 Timestamp를 문자열로 변환
		    String formattedDate = sdf.format(ordersDTO.getOrders_date());
		    
		    // DecimalFormat을 사용하여 포멧 지정
		    DecimalFormat df = new DecimalFormat("#,###");
		    // format 메서드를 사용하여 #,### 형태로 변환
		    String formattedPrice = df.format(productDTO.getPrice());
		    
		    String request_status = ordersDTO.getRequest_status();
%>	
			<TR>
				<TD align="center">
					<%=formattedDate %> <br />
					<%=ordersDTO.getOrders_num() %>
				</TD>
				<TD>
					<DIV style="display:flex; align-items:center;">
						<A href="/project/views/product/productContent.jsp?product_num=<%=productDTO.getProduct_num() %>&pageNum=<%=pageNum %>&category_num=<%=productDTO.getCategory_num() %>">
							<IMG width="50px" height="50px" style="display:inline-block;margin:0 auto;" 
								src="/project/views/upload/<%=imgDTO.getImg_name()%>" />
						</A>&nbsp;&nbsp;
						<A href="/project/views/product/productContent.jsp?product_num=<%=productDTO.getProduct_num() %>&pageNum=<%=pageNum %>&category_num=<%=productDTO.getCategory_num() %>">	
							<%=productDTO.getProduct_name() %>
						</A>
					</DIV>
				</TD>
				<TD align="center">
					<%=formattedPrice %> <br/>
					<%=ordersDTO.getCount() %>
				</TD>
				<TD align="center">
<%				if(ordersDTO.getDelivery_status().equals("1")) {
%>
						배송 준비중
<%				}else if(ordersDTO.getDelivery_status().equals("2")) {
%>
						배송중
<%				}else if(ordersDTO.getDelivery_status().equals("3")) {
%>						배송 완료		
<%				}
%>
				</TD>
				<TD align="center">
					<INPUT type="checkbox" name="selectedOrders" style="transform:scale(1.5);" value=<%=ordersDTO.getOrders_num() %> <%=!request_status.equals("1") ? "disabled" : "" %>>
				</TD>
			</TR>
<%		}		
	}
%>
	<TR style="border:none;">
		<TD colspan="5" align="right">
			<BUTTON type="button" class="emphasis" onclick="cancellBtn()">취소</BUTTON>
			<BUTTON type="button" class="emphasis" onclick="returnBtn()">반품</BUTTON>
			<BUTTON type="button" class="emphasis" onclick="exchageBtn()">교환</BUTTON>
		</TD>	
	</TR>
</TABLE>


<SCRIPT>
	function cancellBtn() {
		var selectedOrders = [];
		var checkboxes = document.querySelectorAll('input[type="checkbox"]');
		for (var i = 0; i < checkboxes.length; i++) {
			if (checkboxes[i].checked) {
				selectedOrders.push(checkboxes[i].value);
			}
		}
		if (selectedOrders.length === 0) {
			alert("취소할 주문을 선택하세요.");
			return;
		}
		if(!confirm("선택한 주문을 취소하시겠습니까?")){
			alert("취소 신청이 취소되었습니다.");
			return false;
		}
		var selectedOrdersString = selectedOrders.join(",");
		location.href = "cancellationPro.jsp?selectedOrders=" + selectedOrdersString;
	}
	
	function returnBtn() {
		var selectedOrders = [];
		var checkboxes = document.querySelectorAll('input[type="checkbox"]');
		for (var i = 0; i < checkboxes.length; i++) {
			if (checkboxes[i].checked) {
				selectedOrders.push(checkboxes[i].value);
			}
		}
		if (selectedOrders.length === 0) {
			alert("반품할 상품을 선택하세요.");
			return;
		}
		if(!confirm("선택한 상품을 반품하시겠습니까?")){
			alert("반품 신청이 취소되었습니다.");
			return false;
		}
		var selectedOrdersString = selectedOrders.join(",");
		location.href = "returnPro.jsp?selectedOrders=" + selectedOrdersString;
	}
	

	function exchageBtn() {
		var selectedOrders = [];
		var checkboxes = document.querySelectorAll('input[type="checkbox"]');
		for (var i = 0; i < checkboxes.length; i++) {
			if (checkboxes[i].checked) {
				selectedOrders.push(checkboxes[i].value);
			}
		}
		if (selectedOrders.length === 0) {
			alert("교환할 상품을 선택하세요.");
			return;
		}
		if(!confirm("선택한 상품을 교환하시겠습니까?")){
			alert("교환 신청이 취소되었습니다.");
			return false;
		}
		var selectedOrdersString = selectedOrders.join(",");
		location.href = "exchangePro.jsp?selectedOrders=" + selectedOrdersString;
	}	
</SCRIPT>