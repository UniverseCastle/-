<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.mypage.MypageDAO" %>
<%@ page import="project.bean.mypage.MypageWrapper" %>
<%@ page import="project.bean.img.ImgDTO" %>
<%@ page import="project.bean.member.MemberDTO" %>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="project.bean.orders.OrdersDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.DecimalFormat" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="/views/member/memberHeader.jsp" />
<jsp:include page="fixed.jsp" />

<link rel="stylesheet" type="text/css" href="/project/views/css/member.css">

<%-- 전체 판매 현황 --%>

<%
	int snum = (int)session.getAttribute("snum");
	String svendor = (String)session.getAttribute("svendor");
	
	MypageDAO dao = MypageDAO.getInstance();
	
	int pageSize = 5;
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage-1)*pageSize+1;
	int endRow = currentPage*pageSize;
	
	int wholeSales_count = dao.wholeSales_count(snum);
	
	ArrayList<MypageWrapper> listV = dao.wholeSales(snum, startRow, endRow );
%>

<DIV style="font-size:25px; font-weight:bold"> 전체 판매 현황</DIV> <br />

<TABLE class="maintable" border="1" width="882px">
	<TR>
		<TD colspan="5"> 판매물품 등록현황 내역 총 <%=wholeSales_count %> 건 </TD>
	</TR>
	<TR>
		<TH>상품명</TH>
		<TH width="80x">상품금액</TH>
		<TH width="80x">주문수량</TH>
		<TH width="80x">판매금액</TH>
		<TH width="80x">구매자</TH>
	</TR>
	
<%	if(wholeSales_count==0) {
%>
		<TR>
			<TD colspan="5"> 조회내역이 없습니다. </TD>
		</TR>
<%	}else {
		for(MypageWrapper wrapper : listV) {
			
			ImgDTO imgDTO = wrapper.getImgDTO();
			MemberDTO memberDTO = wrapper.getMemberDTO();
			ProductDTO productDTO = wrapper.getProductDTO();
			OrdersDTO ordersDTO = wrapper.getOrdersDTO();
			
			int price = productDTO.getPrice();
			int count = ordersDTO.getCount();
			int sales_price = price * count;
			
			// DecimalFormat을 사용하여 포멧 지정
		    DecimalFormat df = new DecimalFormat("#,###");
		    // format 메서드를 사용하여 #,### 형태로 변환
		    String formattedPrice = df.format(productDTO.getPrice());
		    String formattedSales_price = df.format(sales_price);
%>	
			<TR>
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
				<TD align="center"><%=formattedPrice %></TD>
				<TD align="center"><%=ordersDTO.getCount() %></TD>
				<TD align="center"><%=formattedSales_price %></TD>
				<TD align="center"><%=memberDTO.getId() %></TD>
			</TR>
<%		}		
	}
%>
</TABLE>
	
<DIV style="margin:auto 880px;">
<%
	int pageCount = wholeSales_count/pageSize + (wholeSales_count%pageSize==0?0:1);
	int pageBlock = 5;
	int startPage = (int)((currentPage-1)/pageBlock)*pageBlock+1;
	int endPage = startPage + pageBlock - 1;
	if(endPage > pageCount) {
		endPage = pageCount;
	}
	if(startPage > pageBlock) {
%>
	<A href = "wholeSales.jsp?pageNum=<%=startPage - pageBlock %>">[이전]</A>		
<%	}
	for (int i=startPage; i<=endPage; i++) {
%>
	<A href = "wholeSales.jsp?pageNum=<%=i %>">[<%=i %>]</A>	
<%	}
	if(endPage < pageCount) {
%>
	<A href = "wholeSales.jsp?pageNum=<%=startPage + pageBlock %>">[다음]</A>
<%	}
%>
</DIV>