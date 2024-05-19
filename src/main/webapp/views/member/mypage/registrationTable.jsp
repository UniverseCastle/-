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

<%-- 정해진 기간 판매물품 등록 현황 --%>

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
	
	int reg_count = dao.reg_count(snum, start, end);
	ArrayList<MypageWrapper> listV = dao.registration(snum,start, end);
%>

<TABLE class="maintable" border="1" width="882px">
	<TR>
		<TD colspan="6"> 판매물품 등록현황 내역 총 <%=reg_count %> 건 </TD>
	</TR>
	<TR>
		<TH width="140px">등록날짜/등록번호</TH>
		<TH>상품명</TH>
		<TH width="70px">상품금액</TH>
		<TH width="70px">재고현황</TH>
		<TH width="80px">등록승인</TH>
		<TH width="120px">상품수정/삭제</TH>
	</TR>
	
<%	if(reg_count==0) {
%>
		<TR>
			<TD colspan="6" align="center"> 조회내역이 없습니다. </TD>
		</TR>
<%	}else {
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
		    String formattedStock = df.format(productDTO.getStock());
%>	
			
			<TR>
				<TD align="center">
					<%=formattedDate %> <br />
					<%=productDTO.getProduct_num() %>
				</TD>
				<TD>
					<DIV style="display:flex; align-items:center;">
					<%if(productDTO.getStatus().equals("0")) {%>
						<A>
							<IMG width="50px" height="50px" style="display:inline-block;margin:0 auto;" 
										src="/project/views/upload/<%=imgDTO.getImg_name()%>" />
						</A>&nbsp;&nbsp;
					<%}else{	%>				
						<A href="/project/views/product/productContent.jsp?product_num=<%=productDTO.getProduct_num() %>&pageNum=<%=pageNum %>&category_num=<%=productDTO.getCategory_num() %>">
							<IMG width="50px" height="50px" style="display:inline-block;margin:0 auto;" 
										src="/project/views/upload/<%=imgDTO.getImg_name()%>" />
						</A>&nbsp;&nbsp;
					<%	} %>	
						<%if(productDTO.getStatus().equals("0")) {%>
							<%=productDTO.getProduct_name()%>
						
					<%	}else{	%>
						<A href="/project/views/product/productContent.jsp?product_num=<%=productDTO.getProduct_num() %>&pageNum=<%=pageNum %>&category_num=<%=productDTO.getCategory_num() %>">
							<%=productDTO.getProduct_name() %>
						</A>
						<%} %>
					</DIV>
				</TD>
				<TD align="center"><%=formattedPrice %></TD>
				<TD align="center"><%=formattedStock %></TD>
				<TD align="center" >
<%			if(productDTO.getStatus().equals("0")) {
%>	
					승인대기
<%			}else if(productDTO.getStatus().equals("1")) {
%>
					승인				
<%			}else if(productDTO.getStatus().equals("2")) {
%>
					승인거절
					<BUTTON type="button" onclick="approvalBtn(<%=productDTO.getProduct_num() %>)">
						재승인
					</BUTTON>
<%			}
%>
				</TD>				
				
				<TD align="center">
					<INPUT type="button" onclick="window.location='/project/views/product/productUpdateForm.jsp?product_num=<%=productDTO.getProduct_num()%>'" value="수정" />
					<BUTTON type="button" class="emphasis" onclick="deleteProduct(<%=productDTO.getProduct_num()%>)">삭제</BUTTON>
				</TD>
			</TR>
<%		}		
	}
%>
</TABLE>	

<SCRIPT>
	   
	function deleteProduct(product_num) { 
		if(!confirm(product_num +"번 상품을 삭제하시겠습니까?")){
			return false;
		}	
			location.href="/project/views/product/productDeletePro.jsp?product_num="+product_num;
	}
	function approvalBtn(product_num) {
		if(!confirm("재승인 신청을 하시겠습니까?")){
			alert("재승인 신청이 취소되었습니다.");
			return false;
		}
		location.href="registrationApproval.jsp?product_num="+product_num;
	}
</SCRIPT>