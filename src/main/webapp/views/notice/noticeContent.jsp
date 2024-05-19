<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="project.bean.contact.NoticeDAO" %>
<%@ page import="project.bean.contact.NoticeDTO" %>
<link rel="stylesheet" href="/project/views/css/c_style.css">
<jsp:include page="../main/header.jsp"/>
<% 	
	
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	
	NoticeDAO dao = NoticeDAO.getInstance();
	NoticeDTO dto = dao.readContent(num);
	
	String svendor="";
	if (session.getAttribute("svendor") != null) {
		svendor = (String)session.getAttribute("svendor");
	}
	int snum=0;
	if(session.getAttribute("snum") != null) {
	    snum = (int) session.getAttribute("snum");
	
	}
%>
<div id="contents">
	<div class="sub_content">
		<div class="board_zone_sec">
			<div class="board_zone_tit">
				<h2>공지사항</h2>
			</div>
			<div class=board_zone_cont>
				<div class="board_zone_view">
					<div class="board_view_tit">
						<strong><%=dto.getTitle() %></strong>					
					</div>
					<div class="board_view_info">
						<span class="view_info_id">						
								<strong>관리자</strong>
						</span>
						<span class="view_info_day">
							<%=dto.getReg() %>
						</span>
						<span class="view_info_hits">
							조회수 : <%=dto.getReadCount() %>
						</span>
					</div>
					<div class="board_view_content" align="center">
						<div class="view_goods_select"></div>
						<%if(dto.getImg()!=null){ %>
						<img src="../upload/<%=dto.getImg()%>" width="1350" height="1000"/>
						<%} %>
						<p style="font-size: 16px;"><%=dto.getContent() %><p>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
			
	<div class="btn_center_box">
		<button class="btn_before" onclick="history.back()">
			<strong>이전</strong>
		</button>
		<%if(svendor.equals("3")){ %>
		<button type="submit" class="btn_write_ok" onclick="window.location='noticeUpdateForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
			<strong>수정</strong>
		</button>
		<button class="btn_update" onclick="window.location='noticeDeletePro.jsp?num=<%=dto.getNotice_num()%>&pageNum=<%=pageNum%>'">
			<strong>삭제</strong>
		</button >
		<%} %>
	</div>



