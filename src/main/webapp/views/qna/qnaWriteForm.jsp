<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.member.MemberDAO" %>
<%@ page import="project.bean.member.MemberDTO" %>
<%@ page import="project.bean.contact.QnaDAO" %>
<%@ page import="project.bean.contact.QnaDTO" %>
<jsp:include page="../main/header.jsp"/>
<%
	int snum=0;
	String pageNum = "";
	
	String name="";
	
	if(session.getAttribute("snum") != null) {
	    snum = (int) session.getAttribute("snum");
		MemberDAO daom = MemberDAO.getInstance();
		MemberDTO dtom = daom.memberInfo(snum);
		name = dtom.getName();
	}
	
	if(request.getParameter("pageNum")!=null){
		pageNum = request.getParameter("pageNum");
	}
%>
<link rel="stylesheet" href="/project/views/css/c_style.css">

<div id="contents">
	<div class="sub_content">
			<div class="board_zone_sec">
				<div class="board_zone_tit">
					<h2>1:1 문의글 작성</h2>
				</div>
				<div class="board_view_tit">
				</div>
<form action="qnaWritePro.jsp?pageNum=<%= pageNum %>" method="post" enctype="multipart/form-data">
<%	if(snum != 0){%>
	<input type="hidden" name="member_num" value="<%=snum %>"/>	
<%	}else{ %>
	<input type="hidden" name="member_num" value="0"/>
<%	} %>	
	<div class="board_write_box">
		<table class="board_write_table">
			<tr>
				<th scope="row">카테고리</th>
				<td>
					<select name="category">
						<option value="회원/정보관리">회원/정보관리</option>
						<option value="주문/결제">주문/결제</option>
						<option value="배송관련">배송관련</option>
						<option value="반품/환불/교환">반품/환불/교환</option>
						<option value="영수증/증빙서류">영수증/증빙서류</option>
						<option value="상품/이벤트">상품/이벤트</option>
						<option value="기타">기타</option>
					</select>
				</td>
			</tr>
			
			<tr>
				<th scope="row">작성자</th>
				
<%				if(snum !=0){%>
				<td><%=name %>
				<input type="hidden" name="name" value="<%=name%>"/>
				</td>				
<%				}else{ %>
				<td><input type="text" name="writer" value="비회원"/></td>	
<%				} %>
							
			</tr>
			
			<tr>
				<th scope="row">비밀번호</th>
				<td><input type="password" name="password"/></td>
			</tr>
			
			<tr>
				<th scope="row">제목</th>
				<td><input type="text" name="title" placeholder="제목을 입력하세요."/></td>
			</tr>
			
			<tr>
				<th scope="row">본문</th>
				<td><textarea name="question" cols="50" rows="10"></textarea></td>
			</tr>
			
			<tr>
				<th scope="row">첨부파일</th>
				<td><input type="file" name="img"/></td>
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

