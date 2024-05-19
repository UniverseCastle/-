<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="/views/member/memberHeader.jsp" />

<link rel="stylesheet" type="text/css" href="/project/views/css/member.css">

<STYLE>
	.hr	{
		margin: 10px 0;
		border: none;
		border-top: 1px solid gray; 
		width: 882px; 
	}
</STYLE>

<DIV style="display: inline; font-size:35px; font-weight: bold;">회원가입</DIV>
<DIV style="display: inline; font-size:15px; font-weight: bold;">
	01약관동의><FONT color	= skyblue>02정보입력</FONT>>03가입완료</DIV>
<HR class="hr">
<br />
<DIV style="display: inline; font-size:25px; font-weight: bold;">기본정보 </DIV>
<UL style="display: inline-block; list-style-type: square;">
        <LI>표시는 반드시 입력하셔야 하는 항목입니다.</LI>
</UL>

<SCRIPT>
	function memCheck(){	//유효성 검사 - 필수 작성 항목
		if(!document.userInput.id.value) {
			alert("아이디를 입력해 주세요.");
			document.userInput.id.focus();
			return false;
		}
		
		if(document.userInput.vendor.checked) {
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
		}
	
		if(!document.userInput.pw.value) {
			alert("비밀번호를 입력해 주세요.");
			document.userInput.pw.focus();
			return false;
		}
		
		var password = document.userInput.pw.value;
		// 소문자, 숫자, 특수 기호 모두를 포함하는지 확인
		var regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#^()]).{8,}$/;
	    // 최소 8자리 이상인지 확인
	    var minLength = 8;
	    
	    if(password.length < minLength) {
	       	alert("비밀번호는 8자리 이상이어야합니다.")
	    	return false;
	    }
	    
	    if(!regex.test(password)) {
	    	alert("대소문자, 숫자, 특수 기호를 모두 포함해야 합니다.")
	        return false;
	    }
	    
		if(!document.userInput.pw2.value) {
			alert("비밀번호를 한번 더 확인해 주세요.");
			document.userInput.pw2.focus();
			return false;
		}
		if(document.userInput.pw.value != document.userInput.pw2.value) {
			alert("비밀번호가 일치하지 않습니다.");
			document.userInput.pw2.focus();
			return false;
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
	
	//아이디 중복 확인
	function idCheck() {
		var id = document.getElementById("id").value;
		open("confirmId.jsp?id="+id);
	}

	//판매자 회원가입 선택 시 추가될 항목
	document.addEventListener("DOMContentLoaded", function() {
		var vendorCheckbox = document.getElementById("vendor");
		var additionalTable1 = document.getElementById("additionalTable1");
		var additionalTable2 = document.getElementById("additionalTable2");

		vendorCheckbox.addEventListener('change', function() {
			if (this.checked) {
			// 추가 테이블의 내용
				var additionalTableHTML1 = '\
    				<TR>\
						<TD><UL style="display: inline-block; list-style-type: square;"><LI>사업자 등록번호</LI></UL></TD>\
        				<TD><INPUT type="text" name="business_number" /></TD>\
   					</TR>\
				';
   				var additionalTableHTML2 = '\
   					<TR>\
						<TD><UL style="display: inline-block; list-style-type: square;"><LI>사업자명</LI></UL></TD>\
						<TD><INPUT type="text" name="business_name" /></TD>\
					</TR>\
				';
            // 추가 테이블 삽입
            	additionalTable1.innerHTML = additionalTableHTML1;
            	additionalTable2.innerHTML = additionalTableHTML2;
			}else {
				// 추가 표 삭제
				additionalTable1.innerHTML = '';
				additionalTable2.innerHTML = '';
			}
		});
	});
	
</SCRIPT>

<FORM action="insertPro.jsp" method="post" name="userInput" onsubmit="return memCheck()">
<TABLE class="maintable" border="1">
	<TR>
		<TD width="200px"><UL style="display: inline-block; list-style-type: square;"><LI>아이디</LI></UL></TD>
		<TD style="vertical-align:bottom;">
			<INPUT type="text" name="id" id="id"/>&nbsp;&nbsp;
			<INPUT type="button" value="중복확인" onclick="idCheck();" />
			<%--일반회원일때 vendor값 null 판매자회원 가입일때 vendor값 0 (관리자 승인 시 2로 변함)--%>
			<INPUT type="checkbox" name="vendor" value="0" id="vendor" /> <B>판매자 회원가입</B><br/> 	
			<DIV id="confirmResult" >&nbsp;</DIV>
		</TD>
	</TR>	
	<TR id="additionalTable1" >
	</TR>
	<TR id="additionalTable2" >
	</TR>
	<TR>
		<TD><UL style="display: inline-block; list-style-type: square;"><LI>비밀번호</LI></UL></TD>
		<TD><INPUT type="password" name="pw" />&nbsp;영어 대소문자, 숫자, 특수기호 포함 8자리 이상</TD>
	</TR>
	<TR>
		<TD><UL style="display: inline-block; list-style-type: square;"><LI>비밀번호 확인</LI></UL></TD>
		<TD><INPUT type="password" name="pw2" /></TD>
	</TR>
	<TR>
		<TD><UL style="display: inline-block; list-style-type: square;"><LI>이름</LI></UL></TD>
		<TD><INPUT type="text" name="name" /></TD>
	</TR>
	<TR>
		<TD><UL style="display: inline-block; list-style-type: none;"><LI>이메일</LI></UL></TD>
		<TD><INPUT type="text" name="email" id="email" />
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
		<TD><INPUT type="text" name="cellphone" /><br />
			<INPUT type="checkbox" />정보/이벤트 SMS 수신에 동의합니다.
		</TD>
	</TR>
	<TR>
		<TD><UL style="display: inline-block; list-style-type: none;"><LI>전화번호</LI></UL></TD>
		<TD><INPUT type="text" name="phone" /></TD>
	</TR>
</TABLE>
<br /><br />

<DIV style="display: inline; font-size:25px; font-weight: bold;">부가정보 </DIV><br /><br />
<TABLE class="maintable" border="1">
	<TR>
		<TD width="200px"><UL style="display: inline-block; list-style-type: square;"><LI>성별</LI></UL></TD>
		<TD width="200px"><INPUT type="radio" name="gender" value="남자" checked /> 남 &nbsp;&nbsp;
			<INPUT type="radio" name="gender" value="여자" /> 여
	</TR>
	<TR>
		<TD><UL style="display: inline-block; list-style-type: square;"><LI>생일</LI></UL></TD>
		<TD><INPUT type="date" name="birth" id="birth"/>
	</TR>
	
</TABLE><br />
	<INPUT type="button" value="취소" onclick="window.location='main.jsp'" />
	<INPUT type="submit" class="emphasis" value="회원가입" id="submit"/>
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
	});	
</SCRIPT>
