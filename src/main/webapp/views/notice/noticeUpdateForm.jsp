<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/project/views/css/c_style.css">  
<%@ page import="project.bean.contact.NoticeDAO" %>
<%@ page import="project.bean.contact.NoticeDTO" %>
<jsp:include page="../main/header.jsp"/>
<%	
	request.setCharacterEncoding("UTF-8");

	String pageNum = request.getParameter("pageNum");
	int num = Integer.parseInt( request.getParameter("num"));
	
	int snum=0;
	if(session.getAttribute("snum") != null) {
	    snum = (int) session.getAttribute("snum");
	}
	
	NoticeDAO dao = NoticeDAO.getInstance();
	NoticeDTO dto = dao.noticeUpdateForm(num);
	dto.getNotice_num();
	
%>
<div id="contents">
	<div class="sub_content">
		<div class="board_zone_sec">
			<div class="board_zone_tit">
				<h2>공지사항 수정</h2>
			</div>
			<div class="board_view_tit">
				<strong><%=dto.getTitle() %></strong>
			</div>
<form action="noticeUpdatePro.jsp?num=<%=num %>&pageNum=<%=pageNum %>"  method="post">
	<div class="board_write_box">
		<table>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" value="<%=dto.getTitle() %>" /></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea cols="40" rows="10" name="content"><%=dto.getContent() %></textarea></td>
			</tr>
			<tr>
				<th>파일</th>
				<td><input type="file" name="img"/></td>
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