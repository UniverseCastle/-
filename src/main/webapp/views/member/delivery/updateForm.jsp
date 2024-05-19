<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.delivery.DeliveryDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="/views/member/memberHeader.jsp" />
<jsp:include page="../mypage/fixed.jsp" />

<jsp:useBean id="dto" class="project.bean.delivery.DeliveryDTO" />

<link rel="stylesheet" type="text/css" href="/project/views/css/member.css">

<%
	int snum = (int)session.getAttribute("snum");
	String svendor = (String)session.getAttribute("svendor");
	String pageNum = request.getParameter("pageNum");
	int delivery_num = Integer.parseInt(request.getParameter("delivery_num"));
	
	DeliveryDAO dao = DeliveryDAO.getInstance();
	dto = dao.updateForm(delivery_num);
%>

<SCRIPT>
	function deliveryCheck(){
		//유효성 검사 - 필수 작성 항목
		if(!document.deliveryInput.delivery_name.value) {
			alert("배송지 이름을 입력해 주세요.");
			document.deliveryInput.delivery_name.focus();
			return false;
		}
		if(!document.deliveryInput.name.value) {
			alert("받으실 분을 입력해 주세요.");
			document.deliveryInput.name.focus();
			return false;
		}
		if(!document.deliveryInput.address1.value) {
			alert("받으실 곳을 입력해 주세요.");
			document.deliveryInput.address1.focus();
			return false;
		}
		if(!document.deliveryInput.address2.value) {
			alert("받으실 곳을 입력해 주세요.");
			document.deliveryInput.address2.focus();
			return false;
		}
		if(!document.deliveryInput.address3.value) {
			alert("받으실 곳을 입력해 주세요.");
			document.deliveryInput.address3.focus();
			return false;
		}
		if(!document.deliveryInput.cellphone.value) {
			alert("휴대폰번호를 입력해 주세요.");
			document.deliveryInput.cellphone.focus();
			return false;
		}
	}

		
</SCRIPT>

<FORM action="updatePro.jsp?delivery_num=<%=delivery_num %>&pageNum=<%=pageNum %>" method="post" name="deliveryInput" onsubmit="return deliveryCheck()">
<INPUT type="hidden" name="delivery_num" value="<%=delivery_num %>" />
<TABLE class="maintable" border="1">
	<TR>
		<TD width="150px"><UL style="display: inline-block; list-style-type: square;"><LI>배송지 이름</LI></UL></TD>
		<TD><INPUT type="text" name="delivery_name" value="<%=dto.getDelivery_name() %>" /></TD>
	</TR>
	<TR>
		<TD><UL style="display: inline-block; list-style-type: square;"><LI>받으실 분</LI></UL></TD>
		<TD><INPUT type="text" name="name" value="<%=dto.getName() %>" /></TD>
	</TR>
	<TR>
		<TD><UL style="display: inline-block; list-style-type: square;"><LI>받으실 곳</LI></UL></TD>
		<TD>
			<INPUT type="text" name="address1" value="<%=dto.getAddress1() %>" />
			<INPUT type="button" class="emphasis" value="우편번호 조회" onclick="window.open('https://www.epost.go.kr/search.RetrieveIntegrationNewZipCdList.comm')" /> <br />
			<INPUT type="text" name="address2" value="<%=dto.getAddress2() %>" />
			<INPUT type="text" name="address3" value="<%=dto.getAddress3() %>" />
		</TD>
	</TR>
	<TR>
		<TD><UL style="display: inline-block; list-style-type: none;"><LI>전화번호</LI></UL></TD>
		<TD><INPUT type="text" name="phone" value="<%= (dto.getPhone())==null ? "":dto.getPhone() %>" /></TD>
	</TR>
	<TR>
		<TD><UL style="display: inline-block; list-style-type: square;"><LI>휴대폰번호</LI></UL></TD>
		<TD><INPUT type="text" name="cellphone" value="<%=dto.getCellphone() %>" /></TD>
	</TR>
</TABLE>
	<br />
	<INPUT type="checkbox" name="default_address" value="2" <% if(dto.getDefault_address().equals("2")){ %> checked <% } %> />기본배송지로 설정합니다.<br /><br />
	<INPUT type="button" value="취소" onclick="self.close()" />
	<INPUT type="submit" class="emphasis" value="저장" />

</FORM>