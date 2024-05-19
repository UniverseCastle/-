<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.delivery.DeliveryDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="/views/member/memberHeader.jsp" />
<jsp:include page="../mypage/fixed.jsp" />

<link rel="stylesheet" type="text/css" href="/project/views/css/member.css">

<%
	String pageNum ="";
	int snum = (int)session.getAttribute("snum");
	String svendor = (String)session.getAttribute("svendor");
	
	if(request.getParameter("pageNum")==null){
		pageNum ="1";
	}else{
		pageNum = request.getParameter("pageNum");
	}
	DeliveryDAO dao = DeliveryDAO.getInstance();
	boolean result = dao.isDefault_address(snum);	//모든 배송지 중에 기본배송지가 있는지 여부
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

<FORM action="insertPro.jsp?pageNum=<%=pageNum %>" method="post" name="deliveryInput" onsubmit="return deliveryCheck()">
<INPUT type="hidden" name=member_num value="<%=snum %>" />
<TABLE class="maintable" border="1">
	<TR>
		<TD width="150px"><UL style="display: inline-block; list-style-type: square;"><LI>배송지 이름</LI></UL></TD>
		<TD><INPUT type="text" name="delivery_name" /></TD>
	</TR>
	<TR>
		<TD><UL style="display: inline-block; list-style-type: square;"><LI>받으실 분</LI></UL></TD>
		<TD><INPUT type="text" name="name" /></TD>
	</TR>
	<TR>
		<TD><UL style="display: inline-block; list-style-type: square;"><LI>받으실 곳</LI></UL></TD>
		<TD>
			<INPUT type="text" name="address1" placeholder="우편번호"/>
			<INPUT type="button" class="emphasis" value="우편번호 조회" onclick="window.open('https://www.epost.go.kr/search.RetrieveIntegrationNewZipCdList.comm')" /> <br />
			<INPUT type="text" name="address2" placeholder="도로명 주소"/>
			<INPUT type="text" name="address3" placeholder="상세 주소"/>
		</TD>
	</TR>
	<TR>
		<TD><UL style="display: inline-block; list-style-type: none;"><LI>전화번호</LI></UL></TD>
		<TD><INPUT type="text" name="phone" /></TD>
	</TR>
	<TR>
		<TD><UL style="display: inline-block; list-style-type: square;"><LI>휴대폰번호</LI></UL></TD>
		<TD><INPUT type="text" name="cellphone" /></TD>
	</TR>
</TABLE>
<br />

<%	if(result==true) {	//배송지 중에 기본배송지가 있다면 기본배송지 설정 버튼 비활성화
%>
	<INPUT type="checkbox" name="default_address" value="2" disabled />기본배송지로 설정합니다.</br>
<%	}else {	//배송지 중에 기본배송지가 없다면 기본배성지 설정 버튼 활성화
%>	
	<INPUT type="checkbox" name="default_address" value="2" />기본배송지로 설정합니다.</br>
<%	}
%>	
	<br />
	<INPUT type="button" value="취소" onclick="history.go(-1)" />
	<INPUT type="submit" class="emphasis" value="저장" />
</FORM>
