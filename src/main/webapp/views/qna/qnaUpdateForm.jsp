<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.member.MemberDAO" %>
<%@ page import="project.bean.member.MemberDTO" %>    
<%@ page import="project.bean.contact.QnaDAO" %>
<%@ page import="project.bean.contact.QnaDTO" %>

<link rel="stylesheet" href="/project/views/css/c_style.css">
<jsp:include page="../main/header.jsp"/>
<%
	
	int snum=0;
	String pageNum = "";
	int num = Integer.parseInt(request.getParameter("num"));
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
	
	try{
		QnaDAO dao = QnaDAO.getInstance();
		QnaDTO dto = dao.qnaUpdateForm(num);
		
		if(dto.getAnswer() != null){%>
		<script>
			alert("답글이 작성된 글은 수정할 수 없습니다.");
			history.go(-1);
		</script>
	<%	}else{%>
	<div id="contents">
	<div class="sub_content">
		<div class="content">
			<div class="board_zone_sec">
				<div class="board_zone_tit"><h2>1:1 문의글 수정</h2></div>
				<div class="board_view_tit">
					<strong><%=dto.getTitle()%></strong>
				</div>
<form action="qnaUpdatePro.jsp?num=<%=num %>&pageNum=<%= pageNum %>" method="post" enctype="multipart/form-data">
<%	if(snum != 0){%>
	<input type="hidden" name="member_num" value="<%=snum %>"/>	
	<input type="hidden" name="writer" value="<%=dto.getWriter()%>"/>
	<input type="hidden" name="name" value="<%=name%>"/>
<%	}else{ %>
	<input type="hidden" name="member_num" value="0"/>
	<input type="hidden" name="writer" value="<%=dto.getWriter()%>"/>
	<input type="hidden" name="name" value="<%=name%>"/>
<%	} %>	
	<div class="board_write_box">
		<table class="board_write_table">
			<tr>
				<th scope="row">카테고리</th>
				<td>
					<select name="category">
						<option value="선택안함">문의내용</option>
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
				</td>				
<%				}else{ %>
				<td><%=dto.getWriter() %></td>	
				
<%				} %>
							
			</tr>
			
			<tr>
				<th scope="row">비밀번호</th>
				<td><input type="password" name="password"/>
				</td>
			</tr>
			
			<tr>
				<th scope="row">제목</th>
				<td><input type="text" name="title" value="<%=dto.getTitle()%>"/></td>
			</tr>
			
			<tr>
				<th scope="row">본문</th>
				<td><textarea name="question" cols="50" rows="10"><%=dto.getQuestion() %></textarea></td>
			</tr>
			
			<tr>
				<th scope="row">첨부파일</th>
				<td><input type="file" name="img" value=""/></td>
			</tr>
			
		</table>
				<div class="btn_center_box">
					<button type="button" class="btn_before" onclick="history.back()">
						<strong>이전</strong>
					</button>
					<button type="submit" class="btn_write_ok">
						<strong>수정</strong>
					</button>
				</div>
	</div>	 
</form>
			</div>
		</div>
	</div>
</div>
	
<%}	}catch(Exception e){
	
} %>