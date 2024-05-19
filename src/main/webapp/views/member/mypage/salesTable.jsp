<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.mypage.MypageDAO" %>
<%@ page import="project.bean.mypage.MypageWrapper" %>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="project.bean.img.ImgDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat" %>

<% request.setCharacterEncoding("UTF-8"); %>

<link rel="stylesheet" type="text/css" href="/project/views/css/member.css">

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
	
	int sales_count = dao.sales_count(snum, start, end);
	ArrayList<MypageWrapper> listV =dao.sales(snum,start, end);
%>

<TABLE class="maintable" border="1" width="882px">
	<TR>
		<TD colspan="5"> 판매물품 등록현황 내역 총 <%=sales_count %> 건 </TD>
	</TR>
	<TR>
		<TH width="150px">등록날짜/등록번호</TH>
		<TH>상품명</TH>
		<TH width="100px">상품금액</TH>
		<TH width="100px">판매수량</TH>
		<TH width="100px">총 매출</TH>
	</TR>
	
<%	if(sales_count==0) {
%>
		<TR align="center">
			<TD colspan="5"> 조회내역이 없습니다. </TD>
		</TR>	
<%	}else {
		for(MypageWrapper wrapper : listV) {
				
			ProductDTO productDTO = wrapper.getProductDTO();
			ImgDTO imgDTO = wrapper.getImgDTO();
				
		    // SimpleDateFormat을 사용하여 포맷 지정
		    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		    // format 메서드를 사용하여 Timestamp를 문자열로 변환
		    String formattedDate = sdf.format(productDTO.getModified_date());
		    
		    int first_stock = productDTO.getFirst_stock();
		   	int stock = productDTO.getStock();
		   	int price = productDTO.getPrice();
		   	int sales_number = first_stock-stock;
		   	int sales = sales_number*price;
		   	
		 	// DecimalFormat을 사용하여 포멧 지정
		    DecimalFormat df = new DecimalFormat("#,###");
		    // format 메서드를 사용하여 #,### 형태로 변환
		    String formattedPrice = df.format(productDTO.getPrice());
		    String formattedSales_number = df.format(sales_number);
		    String formattedSales = df.format(sales);
		   	
			%>
			<TR>
				<TD align="center">
					<%=formattedDate %> <br />
					<%=productDTO.getProduct_num() %>
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
				<TD align="center"><%=formattedPrice %></TD>
				<TD align="center"><%=formattedSales_number %></TD>
				<TD align="center"><%=formattedSales %></TD>
			<TR>
<%		}		
	}
%>
</TABLE>		

