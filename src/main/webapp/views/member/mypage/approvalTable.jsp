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

<%-- 정해진 기간 취소/반품/교환 처리 --%>

<link rel="stylesheet" type="text/css" href="/project/views/css/member.css">

<STYLE>
	BUTTON:disabled {
	    opacity: 0.5;
	    cursor: not-allowed;
	}
</STYLE>

<%-- 취소/교환/반품 처리 --%>
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
	
	int orders_count = dao.approval_count(snum, start, end);
	
	ArrayList<MypageWrapper> list = dao.approval(snum, start, end);
%>

<TABLE class="maintable" border="1" width="882px">
	<TR>
		<TD colspan="5">  취소/반품/교환 내역 총 <%=orders_count %> 건 </TD>
	</TR>
	<TR>
		<TH width="130px">날짜/주문번호</TH>
		<TH>상품명</TH>
		<TH width="120px">상품금액/수량</TH>
		<TH width="100px">처리상태</TH>
		<TH width="80px">승인</TH>
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
		    String orders_status = ordersDTO.getOrders_status();
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
<%			if(request_status.equals("2")&&orders_status.equals("1")) {
%>				
				취소대기
<% 			}else if(request_status.equals("3")&&orders_status.equals("1")) {
%>
				반품대기
<% 			}else if(request_status.equals("4")&&orders_status.equals("1")) {
%>
				교환대기								
<% 			}else if(request_status.equals("2")&&orders_status.equals("2")) {
%>
				취소완료	
<%			}else if(request_status.equals("3")&&orders_status.equals("2")) {
%>	
				반품완료
<%			}else if(request_status.equals("4")&&orders_status.equals("2")) {
%>	
				교환완료
<%			}
%>
				</TD>
				<TD align="center">
					<BUTTON type="button" class="emphasis" onclick="approvalBtn(<%=ordersDTO.getOrders_num() %>, <%=productDTO.getProduct_num()%>)" <%= orders_status.equals("2") ? "disabled" : "" %>>승인</BUTTON><br />
				</TD>
			</TR>
<%		}		
	}
%>
</TABLE>

<SCRIPT>
	function approvalBtn(orders_num, product_num) {
		if(!confirm("정말로 승인 하시겠습니까?")){
			alert("승인이 취소되었습니다.");
		}
		location.href="approvalPro.jsp?orders_num="+orders_num+"&product_num="+product_num;
	}
</SCRIPT>