<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="/views/member/memberHeader.jsp" />
<jsp:include page="fixed.jsp" />

<%
	int snum = (int)session.getAttribute("snum");
	String svendor = (String)session.getAttribute("svendor");
	String pageNum = "1";
%>

<link rel="stylesheet" type="text/css" href="/project/views/css/member.css">

<SCRIPT src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></SCRIPT>

<SCRIPT>
	var previousButtonId = "button1";
	function changeColor(buttonId){		//선택한 버튼만 색이 바뀌도록 함
		var previousButton = document.getElementById(previousButtonId);
        previousButton.style.backgroundColor = "white";
        previousButton.style.color = "gray";
		
		var button = document.getElementById(buttonId);
		button.style.backgroundColor = "gray";
		button.style.color = "white";
	
		previousButtonId = buttonId; 
	}
		
	function setDate(period) {		//선택한 기간을 date형 input 초기값으로 설정
		var today = moment();
		var startDate, endDate;
	    
		switch (period) {
			case 'today':
	            startDate = today;
	            endDate = today;
	            break;
			case '7days':
	            startDate = moment().subtract(7, 'days');
	            endDate = today;
	            break;
			case '15days':
	            startDate = moment().subtract(15, 'days');
	            endDate = today;
	            break;
			case '1month':
	            startDate = moment().subtract(1, 'month').add(1, 'days');
	            endDate = today;
	            break;
			case '3months':
	            startDate = moment().subtract(3, 'months').add(1, 'days');
	            endDate = today;
	            break;
			case '1year':
	            startDate = moment().subtract(1, 'year').add(1, 'days');
	            endDate = today;
	            break;
			default:
				break;
	    }
	    
	    document.getElementById('start').value = startDate.format('YYYY-MM-DD');
	    document.getElementById('end').value = endDate.format('YYYY-MM-DD');
	}
	
	function loadQnaTable(startDate, endDate) {	//submit 되더라도 table페이지로 이동하지 않고 table이 해당페이지에 나타나도록 함
		var xhttp = new XMLHttpRequest();
        xhttp.open("POST", "qnaTable.jsp", true);
        xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xhttp.send("start=" + startDate + "&end=" + endDate);
	}
</SCRIPT>


<DIV style="display:inline-block; font-size:25px; font-weight:bold"> 
	<span style="dispaly:inline-block;">1:1문의</span>
	<span style="display:inline-block; margin-left:702px;">
		<BUTTON class="emphasis" onclick="window.location='/project/views/qna/qnaWriteForm.jsp?pageNum=<%=pageNum %>'"> 문의하기 </BUTTON>
	</span>
</DIV>

<br /><br />
	<DIV style="display:inline-block; border:2px solid lightgray; padding:15px; width:850px; height:37px; ">
		<FONT color="gray"><B>조회기간</B></FONT>
		<BUTTON id="button1" onclick="changeColor('button1'); setDate('today')">오늘</BUTTON>
		<BUTTON id="button2" onclick="changeColor('button2'); setDate('7days')">7일</BUTTON>
		<BUTTON id="button3" onclick="changeColor('button3'); setDate('15days')">15일</BUTTON>
		<BUTTON id="button4" onclick="changeColor('button4'); setDate('1month')">1개월</BUTTON>
		<BUTTON id="button5" onclick="changeColor('button5'); setDate('3months')">3개월</BUTTON>
		<BUTTON id="button6" onclick="changeColor('button6'); setDate('1year')">1년</BUTTON> &nbsp;&nbsp;
		<FORM style="display:inline-block" onsubmit="loadQnaTable(document.getElementById('start').value, document.getElementById('end').value)); return false;">
			<INPUT type="date" id="start" name="start" />~
			<INPUT type="date" id="end" name="end" />&nbsp;&nbsp;
			<INPUT type="submit" class="emphasis" value="조회" />
		</FORM>
	</DIV><br /><br />
<jsp:include page="qnaTable.jsp" />