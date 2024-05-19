<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.contact.FaqDAO"%>
<%@ page import="project.bean.contact.FaqDTO"%>
<link rel="stylesheet" href="/project/views/css/c_style.css">
<jsp:include page="../main/header.jsp"/>
<%

	int num = Integer.parseInt(request.getParameter("faq_num"));
	String pageNum = request.getParameter("pageNum");
	
	FaqDAO dao = FaqDAO.getInstance();
	FaqDTO dto = dao.faqUpdateForm(num);
	
	int snum=0;
	if(session.getAttribute("snum") != null ){
		snum = (int)session.getAttribute("snum");
	}%>
<div id="contents">
	<div class="sub_content">
		<div class="content">
			<div class="board_zone_sec">
				<div class="board_zone_tit">
					<h2>FAQ 작성</h2>
				</div>
				<div class="board_view_tit">
				</div>
<form action="faqUpdatePro.jsp?faq_num=<%=num %>&pageNum=<%=pageNum %>" method="post">
	<div class="board_write_box">	
		<table class="board_write_table">
			<colgroup>
				<col style="width:15%">
				<col style="width:85%">
			</colgroup>
			<tr>
				<th>분류</th>
				<td>
					<select name="category">
						<option value="회원가입/정보">회원가입/정보</option>
						<option value="결제/배송">결제/배송</option>
						<option value="교환/반품/환불">교환/반품/환불</option>
						<option value="마일리지 적립">마일리지 적립</option>
						<option value="기타">기타</option>
					</select>
				</td>				
			</tr>
			<tr>
				<th>질문</th>
				<td><textarea cols="100" rows="10" name="question"><%=dto.getQuestion() %></textarea></td>
			</tr>
			<tr>
				<th>답변</th>
				<td><textarea cols="100" rows="10" name="answer"><%=dto.getAnswer() %></textarea></td>
			</tr>
		</table>
		<div class="btn_center_box">
			<button type="button" class="btn_before" onclick="history.back()">
				<strong>이전</strong>
			</button>
			<button type="submit" class="btn_write_ok">
				<strong>저장</strong>
			</button>
		</div>
	</div>
</form>
			</div>
		</div>
	</div>
</div>