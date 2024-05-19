<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.member.MemberDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="/views/member/memberHeader.jsp" />
<jsp:include page="mypage/fixed.jsp" />

<jsp:useBean id="dto" class="project.bean.member.MemberDTO" />
<jsp:setProperty name="dto" property="*" />

<link rel="stylesheet" type="text/css" href="/project/views/css/member.css">

<STYLE>
	.hr	{
		margin: 10px 0;
		border: none;
		border-top: 1px solid gray; 
		width: 882px; 
	}
</STYLE>

<%
	
	int snum = (int)session.getAttribute("snum");
	String svendor = (String)session.getAttribute("svendor");
		
	MemberDAO dao = MemberDAO.getInstance();
	
	dto = dao.memberInfo(snum);			//member_num에 해당하는 회원정보
%>

	<DIV style="font-size:35px; font-weight: bold;">회원정보 변경</DIV> <br />
	<HR class="hr">
	<DIV style="display: inline; font-size:25px; font-weight: bold;">기본정보 </DIV>
	<UL style="display: inline-block; list-style-type: square;">
        <LI>표시는 반드시 입력하셔야 하는 항목입니다.</LI>
	</UL>

	<SCRIPT>
		function memCheck(){	//유효성 검사 - 필수 작성 항목
			if(!document.userInput.business_number.value) {
				alert("사업자 등록번호를 입력해 주세요.");
				document.userInput.business_number.focus();
				return false;
			}
			if(!document.userInput.business_name.value) {
				alert("사업자명을 입력해 주세요.");
				document.userInput.business_name.focus();
				return false;
			}
			
			var password = document.userInput.pw.value;
			// 대소문자, 숫자, 특수 기호 모두를 포함하는지 확인
			var regex = /^(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#^()]).{8,}$/;
		    // 최소 8자리 이상인지 확인
		    var minLength = 8;
		    
		    if(password !== "") {
			    if (password.length < minLength) {
			       	alert("비밀번호는 8자리 이상이어야합니다.")
			    	return false;
			    }
			    
			    if (!regex.test(password)) {
			    	alert("소문자, 숫자, 특수 기호를 모두 포함해야 합니다.")
			        return false;
			    }
				
				if(document.userInput.pw.value != document.userInput.pw2.value) {
					alert("비밀번호가 일치하지 않습니다.");
					document.userInput.pw2.focus();
					return false;
				}
			}
		    
			if(!document.userInput.name.value) {
				alert("이름을 입력해 주세요.");
				document.userInput.name.focus();
				return false;
			}
			if(!document.userInput.cellphone.value) {
				alert("휴대폰번호를 입력해 주세요.");
				document.userInput.cellphone.focus();
				return false;
			}
			if(!document.userInput.birth.value) {
				alert("생일을 입력해주세요.");
				return false;
			}
			
			//유효성 검사 - 성인인증
			var birthdateInput = document.getElementById("birth").value;
			var birthdate = new Date(birthdateInput);
			var now = new Date();
			var age = now.getFullYear() - birthdate.getFullYear();
			var monthDiff = now.getMonth() - birthdate.getMonth();
			if (monthDiff < 0 || (monthDiff === 0 && now.getDate() < birthdate.getDate())) {
				age--;
			}
		    
			if (age >= 18) {
				return true;
		    }else {
				alert("만 18세 이상 성인만 가입 가능합니다.")
				return false;
		    }
			
		}
	</SCRIPT>
	
	<FORM action="updatePro.jsp" method="post" name="userInput" onsubmit="return memCheck()">
		<INPUT type="hidden" name=member_num value=<%=snum %> />
		<TABLE class="maintable" border="1">
			<TR>
				<TD width="200px"><UL style="display: inline-block; list-style-type: square;"><LI>아이디</LI></UL></TD>
				<TD>
					<%=dto.getId() %>
					<INPUT type="hidden" name="id" value="<%=dto.getId() %>" />
				</TD>
<%	if (svendor.equals("2")){	//판매자 회원일 때만 표시
%>
		    <TR>
				<TD><UL style="display: inline-block; list-style-type: square;"><LI>사업자 등록번호</LI></UL></TD>
		    	<TD><INPUT type="text" name="business_number" value="<%= (dto.getBusiness_number() == null) ? "" : dto.getBusiness_number() %>" /></TD>
			</TR>
			<TR>
				<TD><UL style="display: inline-block; list-style-type: square;"><LI>사업자명</LI></UL></TD>
				<TD><INPUT type="text" name="business_name" value="<%= (dto.getBusiness_name() == null) ? "" : dto.getBusiness_name() %>" /></TD>
			</TR>	
<%	}
%>
			<TR>
				<TD><UL style="display: inline-block; list-style-type: none;"><LI>비밀번호</LI></UL></TD>
				<TD>
				새 비밀번호		<INPUT type="password" name="pw" id="pw" /> <br />
				새 비밀번호 확인	<INPUT type="password" name="pw2" id="pw2" /> <br />
				</TD>
			</TR>
			
			<TR>
				<TD><UL style="display: inline-block; list-style-type: square;"><LI>이름</LI></UL></TD>
				<TD><INPUT type="text" name="name" value="<%=dto.getName() %>"/></TD>
			</TR>
			<TR>
				<TD><UL style="display: inline-block; list-style-type: none;"><LI>이메일</LI></UL></TD>
				<TD><INPUT type="text" name="email" id="email" value="<%= (dto.getEmail() == null) ? "" : dto.getEmail() %>" />
					<SELECT id="email2">
						<OPTION>직접입력</OPTION>
						<OPTION value = "@naver.com">naver.com</OPTION>
						<OPTION value = "@hanmail.net">hanmail.net</OPTION>
						<OPTION value = "@daum.net">daum.net</OPTION>
						<OPTION value = "@gmail.com">gmail.com</OPTION>
						<OPTION value = "@nate.com">nate.com</OPTION>
					</SELECT> <br/>
					<INPUT type="checkbox" />정보/이벤트 메일 수신에 동의합니다.
				</TD>
			</TR>
			<TR>
				<TD><UL style="display: inline-block; list-style-type: square;"><LI>휴대폰번호</LI></UL></TD>
				<TD><INPUT type="text" name="cellphone" value="<%=dto.getCellphone() %>" /><br />
					<INPUT type="checkbox" />정보/이벤트 SMS 수신에 동의합니다.
				</TD>
			</TR>
			<TR>
				<TD><UL style="display: inline-block; list-style-type: none;"><LI>전화번호</LI></UL></TD>
				<TD><INPUT type="text" name="phone" value="<%= (dto.getPhone() == null) ? "" : dto.getPhone() %>" /></TD>
			</TR>
		</TABLE>
		<br /><br />
		<div class="subtable2">
		<DIV style="display: inline; font-size:25px; font-weight: bold;">부가정보 </DIV><br /><br />
		<TABLE class="maintable" border="1" >
			<TR>
				<TD width="200px"><UL style="display: inline-block; list-style-type: square;"><LI>성별</LI></UL></TD>
				<TD width="200px"><INPUT type="radio" name="gender" value="남자" <% if("남자".equals(dto.getGender())){%> checked <% } %> /> 남 &nbsp;&nbsp;
					<INPUT type="radio" name="gender" value="여자" <% if("여자".equals(dto.getGender())){%> checked <% } %> /> 여
			</TR>
			<TR>
				<TD><UL style="display: inline-block; list-style-type: square;"><LI>생일</LI></UL></TD>
				<TD><INPUT type="date" name="birth" id="birth" value="<%=dto.getBirth() %>" />
			</TR>
			
		</TABLE><br />
		</div>
			<DIV style="margin:auto 650px;">
			<INPUT type="button" value="취소" onclick="window.location='pwCheck.jsp'"/>
			<INPUT type="submit" class="emphasis" value="정보수정" />
			</DIV>	
	</FORM>
		
	<SCRIPT>
	document.getElementById("email2").addEventListener("change", function() {
		var selectedOption = this.options[this.selectedIndex];
		var email = document.getElementById("email");
		
		if(selectedOption.value === "직접입력") {
			email.value = '';	//직접입력 일때는 email 박스에 빈칸으로 둠
		}else {
			email.value = selectedOption.value; // 선택한 항목의 텍스트값을 email 에 표시
		}
	</SCRIPT>