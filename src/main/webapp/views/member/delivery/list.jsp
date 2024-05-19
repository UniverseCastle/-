<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.delivery.DeliveryDAO" %>
<%@ page import="project.bean.delivery.DeliveryDTO" %>
<%@ page import="java.util.ArrayList" %>

<jsp:include page="/views/member/memberHeader.jsp" />
<jsp:include page="../mypage/fixed.jsp" />

<link rel="stylesheet" type="text/css" href="/project/views/css/member.css">

<%
	int snum = (int)session.getAttribute("snum");
	String svendor = (String)session.getAttribute("svendor");
	
	DeliveryDAO dao = DeliveryDAO.getInstance();
	
	int pageSize = 5;
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage-1)*pageSize+1;
	int endRow = currentPage*pageSize;
	
	int count = dao.count(snum);
	
	ArrayList<DeliveryDTO> list = dao.list(snum, startRow, endRow);
%>
<TABLE class="maintable" width="882px" style="border-top:none;" >
	<TR style="border-left: none; border-right: none;">
		<TD colspan ="4" style="border-left: none; border-right: none;">
		<DIV style="font-size:25px; display:inline-block;">
			<B>배송지 관리</B> 
		</DIV>&nbsp;&nbsp;
		<DIV style="display:inline-block;">
		배송지 관리 내역 총 <%=count %>건
		</DIV>
		</TD>
		<TD style="border-left: none; border-right: none; text-align:right"> 
		<BUTTON class="emphasis" onclick="window.location='insertForm.jsp?pageNum=<%=pageNum %>'">+ 새 배송지 추가
		</BUTTON>
		</TD>
	</TR>
	<TR border="1">
		<TH style="border: 1px solid black;">배송지 이름</TH>
		<TH style="border: 1px solid black;" >받으실 분</TH>
		<TH style="border: 1px solid black;" >주소</TH>
		<TH style="border: 1px solid black;" >연락처</TH>
		<TH style="border: 1px solid black;" >수정/삭제</TH>
<%	if(count==0) {	
%>
	<TR>
		<TD colspan ="5" style="border: 1px solid black;"> 입력된 배송지가 없습니다. </TD>
	</TR>
<%	}else {
		for(DeliveryDTO dto : list) {
%>		<TR >
			<TD align="center" style="border: 1px solid black;">
<%			if(dto.getDefault_address().equals("2")) {
%>
			(기본배송지) <br /> 
			<%=dto.getDelivery_name() %>
<%			}else {
%>
			<%=dto.getDelivery_name() %>			
<%			}
%>
			</TD>
			<TD align="center" style="border: 1px solid black;"> <%=dto.getName() %> </TD>
			<TD style="border: 1px solid black;"> <%=dto.getAddress1() %>, <%=dto.getAddress2() %>, <%=dto.getAddress3() %> </TD>
			<TD style="border: 1px solid black;"> 
<%			if(dto.getPhone()!=null){
%>	
			휴대폰 번호 : <%=dto.getCellphone() %> <br />
			전화번호 : <%=dto.getPhone() %>
<%			}else {
%>
			휴대폰 번호 : <%=dto.getCellphone() %>
<%			}
%>
			</TD>
			<TD width="150px" style="border: 1px solid black; text-align:center" >
				<BUTTON onclick="window.open('updateForm.jsp?delivery_num=<%=dto.getDelivery_num()%>&pageNum=<%=pageNum %>')">수정</BUTTON> &nbsp;
				<BUTTON class="emphasis" onclick="window.location='deletePro.jsp?delivery_num=<%=dto.getDelivery_num()%>&pageNum=<%=pageNum %>'">삭제</BUTTON> <br />
			</TD>
		</TR>
<%		} 
%>
<%	}
%>	
</TABLE>
<br />
<DIV style="margin:auto 880px;">
<%
	int pageCount = count/pageSize + (count%pageSize==0?0:1);
	int pageBlock = 5;
	int startPage = (int)((currentPage-1)/pageBlock)*pageBlock+1;
	int endPage = startPage + pageBlock - 1;
	if(endPage > pageCount) {
		endPage = pageCount;
	}
	if(startPage > pageBlock) {
%>
	<A href = "list.jsp?pageNum=<%=startPage - pageBlock %>">[이전]</A>		
<%	}
	for (int i=startPage; i<=endPage; i++) {
%>
	<A href = "list.jsp?pageNum=<%=i %>">[<%=i %>]</A>	
<%	}
	if(endPage < pageCount) {
%>
	<A href = "list.jsp?pageNum=<%=startPage + pageBlock %>">[다음]</A>
<%	}
%>
</DIV>

