<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.mypage.MypageDAO" %>
<%@ page import="project.bean.mypage.MypageWrapper" %>
<%@ page import="project.bean.orders.OrdersDTO" %>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="project.bean.img.ImgDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DecimalFormat" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="/views/member/memberHeader.jsp" />

<jsp:include page="fixed.jsp" />


<link rel="stylesheet" type="text/css" href="/project/views/css/member.css">

<%
	int snum = 0;
	String svendor="";
	
	if(session.getAttribute("snum")!=null) {
		snum = (int)session.getAttribute("snum");	
	}
	if(session.getAttribute("svendor")!=null) {
		svendor = (String)session.getAttribute("svendor");
	}
	if(snum==0) {
%>
		<SCRIPT>
			alert("로그인 해 주세요.");
			window.location="/project/views/member/loginForm.jsp"
		</SCRIPT>
<%	}
	
	MypageDAO dao = MypageDAO.getInstance();
	
	int pageSize = 5;
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage-1)*pageSize+1;
	int endRow = currentPage*pageSize;
	
	int orders_count = dao.orders_count_main(snum);
	int reg_count = dao.reg_count_main(snum);
	
	ArrayList<MypageWrapper> list = dao.orders_main(snum, startRow, endRow);
	ArrayList<MypageWrapper> listV = dao.registration_main(snum,startRow, endRow);
%>


<%	if(svendor.equals("1")) {	//30일간의 주문/배송현황
%>
		<TABLE class="maintable" width=882px style="border-top:none;">
			<TR style="border-left: none; border-right: none;">
			<TD colspan ="3" style="border-left: none; border-right: none;">
				<DIV style="font-size:25px; display:inline-block;">
					<B>최근 주문 정보</B> 
				</DIV>
				<DIV style="display:inline-block;">
				최근 30일 내에 주문하신 내역입니다.
				</DIV>
			</TD>
			<TD align="center" style="border-left: none; border-right: none; text-align:right">
				<INPUT type="button" class="emphasis" onclick="window.location='orders.jsp'" value="+더보기" />
			</TD>
			</TR>
			<TR>
				<TH width="120px" style="border: 1px solid black;">날짜/주문번호</TH>
				<TH style="border: 1px solid black;">상품명</TH>
				<TH width="80px" style="border: 1px solid black;">상품금액/수량</TH>
				<TH width="100px" style="border: 1px solid black;">배송상태</TH>
			</TR>
<%		if(orders_count==0) {
%>
			<TR>
				<TD colspan="4" style="border: 1px solid black;"> 조회내역이 없습니다. </TD>
			</TR>
<%		}else {
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
			    
%>	
				<TR>
					<TD align="center" style="border: 1px solid black;">
						<%=formattedDate %> <br />
						<%=ordersDTO.getOrders_num() %>
					</TD>
					<TD style="border: 1px solid black;">	
						<DIV style="display:flex; align-items:center;">
							<A href="/project/views/product/productContent.jsp?product_num=<%=productDTO.getProduct_num() %>&pageNum=<%=pageNum %>&category_num=<%=productDTO.getCategory_num() %>">
								<IMG width="50px" height="50px" style="display:inline-block;margin:0 auto;" 
											src="/project/views/upload/<%=imgDTO.getImg_name()%>" />
							</A>&nbsp;&nbsp;
							<A href="/project/views/product/productContent.jsp?product_num=<%=productDTO.getProduct_num() %>&pageNum=<%=pageNum %>&category_num=<%=productDTO.getCategory_num() %>">
								<%=productDTO.getProduct_name() %>
							</A>
						</DIV>
					<TD align="center" style="border: 1px solid black;">
						<%=formattedPrice %> <br/>
						<%=ordersDTO.getCount() %>
					</TD>
					<TD align="center" style="border: 1px solid black;">
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
				</TR>
<%			}		
		}
%>	
			</TABLE>
<% 	}else {	//30일 간의 판매등록 현황
%>
		<TABLE class="maintable" width="882px" style="border-top:none;">
			<TR style="border-left: none; border-right: none;">	
				<TD colspan ="3" style="border-left: none; border-right: none;">
					<DIV style="font-size:25px; display:inline-block;">
						<B>최근 판매 등록</B> 
					</DIV>&nbsp;&nbsp;
					<DIV style="display:inline-block;">
						최근 30일 내에 등록하신 내역입니다.
					</DIV>
				</TD>
				<TD align="center" style="border-left: none; border-right: none; text-align:right">
					<INPUT class="emphasis" type="button" onclick="window.location='registration.jsp'" value="+더보기" />
				</TD>
			</TR>
			<TR>
				<TH width="140px" style="border: 1px solid black;">등록날짜/등록번호</TH>
				<TH style="	border: 1px solid black;">상품명</TH>
				<TH width="80px"style="border: 1px solid black;">상품금액</TH>
				<TH width="80px"style="border: 1px solid black;">재고현황</TH>
			</TR>
<%		if(reg_count==0) {
%>
			<TR>
				<TD colspan="5" style="border: 1px solid black;"> 조회내역이 없습니다.</TD>
			</TR>
		
<%		}else {
			for(MypageWrapper wrapper : listV) {
	
				ProductDTO productDTO = wrapper.getProductDTO();
				ImgDTO imgDTO = wrapper.getImgDTO();
					
			    // SimpleDateFormat을 사용하여 포맷 지정
			    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			    // format 메서드를 사용하여 Timestamp를 문자열로 변환
			    String formattedDate = sdf.format(productDTO.getModified_date());
			    // DecimalFormat을 사용하여 포멧 지정
			    DecimalFormat df = new DecimalFormat("#,###");
			    // format 메서드를 사용하여 #,### 형태로 변환
			    String formattedPrice = df.format(productDTO.getPrice());
%>	
				<TR>
					<TD align="center" style="border: 1px solid black;">
						<%=formattedDate %> <br />
						<%=productDTO.getProduct_num() %>
					</TD>
					<TD style="border: 1px solid black;">
						<DIV style="display:flex; align-items:center;">
							<A href="/project/views/product/productContent.jsp?product_num=<%=productDTO.getProduct_num() %>&category_num=<%=productDTO.getCategory_num() %>&pageNum=<%=pageNum %>">
								<IMG width="50px" height="50px" style="display:inline-block;margin:0 auto;" 
										src="/project/views/upload/<%=imgDTO.getImg_name()%>" />
							</A>&nbsp;&nbsp;
							<A href="/project/views/product/productContent.jsp?product_num=<%=productDTO.getProduct_num() %>&pageNum=<%=pageNum %>&category_num=<%=productDTO.getCategory_num() %>">
								<%=productDTO.getProduct_name() %>
							</A>
						</DIV>
					</TD>
					<TD align="center" style="border: 1px solid black;"><%=formattedPrice %></TD>
					<TD align="center" style="border: 1px solid black;"><%=productDTO.getStock() %></TD>
				</TR>
<%			}		
		}
%>
		</TABLE>
<%	}		
%>		
	
<DIV style="margin-left:43%; margin-top : 20px;">
<%
	int pageCount = 0;
	if(svendor.equals("1"))	{
		pageCount = orders_count/pageSize + (orders_count%pageSize==0?0:1);
	}else {
		pageCount = reg_count/pageSize + (reg_count%pageSize==0?0:1);
	}	
	int pageBlock = 5;
	int startPage = (int)((currentPage-1)/pageBlock)*pageBlock+1;
	int endPage = startPage + pageBlock - 1;
	if(endPage > pageCount) {
		endPage = pageCount;
	}
	if(startPage > pageBlock) {
%>

	<A href = "main.jsp?pageNum=<%=startPage - pageBlock %>">[이전]</A>		
<%	}
	for (int i=startPage; i<=endPage; i++) {
%>
	<A href = "main.jsp?pageNum=<%=i %>">[<%=i %>]</A>	
<%	}
	if(endPage < pageCount) {
%>
	<A href = "main.jsp?pageNum=<%=startPage + pageBlock %>">[다음]</A>
<%	}
%>
</DIV>
