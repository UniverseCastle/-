<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	request.setCharacterEncoding("UTF-8"); %>

<%
	int snum = 0;
	if(session.getAttribute("snum") != null ){
		snum = (int)session.getAttribute("snum");
	}
	String pageNum = request.getParameter("pageNum");
%>

<link rel="stylesheet" href="/project/views/css/c_style.css">
<jsp:include page="../main/header.jsp"/>
<div id="contents">
	<div class="sub_content">
		<div class="content">
			<div class="board_zone_sec">
				<div class="board_zone_tit">
					<h2>공지사항 작성</h2>
				</div>
				<div class="boadr_view_tit">
				</div>
				
<form action="noticeWritePro.jsp?pageNum=<%=pageNum %>" method="post" enctype="multipart/form-data">
	<div class="board_write_box">	
		<table class="board_write_table">
			<colgroup>
				<col style="width:15%">
				<col style="width:85%">
			</colgroup>
			
			<tr>
				<th scope="row">제목</th>
				<td>
					<input type="text" name="title"/>
				</td>
			</tr>

			<tr>
				<th scope="row">본문</th>
				<td>						
					<textarea name="content" cols="50" rows="10"></textarea>
				</td>
			</tr>
			
			<tr>
				<th scope="row">첨부파일</th>
				<td>
					<input type="file" name="img"/>
				</td>	
			</tr>
			
			<tr>
				<th scope="row">고정글</th>
				<td>
					O<input type="radio" name="fix_yn" value="y"/>
					X<input type="radio" name="fix_yn" value="n" checked/>
				</td>
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
