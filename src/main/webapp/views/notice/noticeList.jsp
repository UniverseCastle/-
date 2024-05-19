<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import="project.bean.contact.NoticeDTO" %>
<%@ page import="project.bean.contact.NoticeDAO" %>
<%@ page import="java.util.ArrayList" %>
<link rel="stylesheet" href="/project/views/css/c_style.css">
<jsp:include page="../main/header.jsp"/>
<%
	int snum = 0;
	if(session.getAttribute("snum") != null ){
		snum = (int)session.getAttribute("snum");
	}
	
	String svendor="";
	if (session.getAttribute("svendor") != null) {
		svendor = (String)session.getAttribute("svendor");
	}
	
	NoticeDAO dao = NoticeDAO.getInstance();

	int pageSize=10;
	String pageNum = request.getParameter("pageNum");
	if(pageNum==null){
		pageNum="1";
	}
	
	int currentPage=Integer.parseInt(pageNum);
	int startRow = (currentPage-1)*pageSize+1;
	int endRow = currentPage*pageSize;
	int count = dao.boardCount();
	

%>
<style>
.tlist {
    display: table-cell;
    vertical-align: inherit;
    border-top: 1px solid #A9A9A9;
    unicode-bidi: isolate;
}
a {
	text-decoration: none;
	font-size: 16px;
	cursor : pointer;
	color: #333;
}
 .fixed_row {
        background-color: #F6D8CE;
        font-weight: bold;
    }
</style>
<link rel="stylesheet" href="/project/views/css/c_style.css">
<body>
	<div id="contents">
		<div class="distillery_wrap">
			<div class="wrap_box">
				<h3 class="wrap_title">
					공지사항
				</h3>
				<ul class="wrap_tab">
					<li class="on"><a class="a-main"href="/project/views/notice/noticeList.jsp?pageNum=1">공지사항</a></li>
					<li><a class="a-main" href="/project/views/faq/faqList.jsp?pageNum=1">자주 묻는 질문</a></li>
					<li><a class="a-main" href="/project/views/qna/qnaList.jsp?pageNum=1">1:1 문의하기</a></li>
					<li><a class="a-main" href="/project/views/review/list.jsp">상품후기</a></li>
					<li><a class="a-main" href="/project/views/vendorQna/vendorQnaList.jsp?pageNum=1">사업자문의</a></li>
					<li><a class="a-main" href="	/project/views/productQna/productQnaList.jsp?pageNum=1">상품문의</a></li>
				</ul>
			</div>
		</div>
	</div>
</body>
<div class="board_zone_sec">
<h1>공지사항</h1>
</div>
<table class="board_list_table" style="width:100%">
    <colgroup>
        <col style="width:10%">
        <col style="width:10%">
        <col style="width:30%">
        <col style="width:10%">
        <col style="width:10%">
        <col style="width:10%">
    </colgroup>
    <tr>
        <th height="35">번호</th>
        <th height="35">분류</th>
        <th height="35">제목</th>
        <th height="35">작성자</th>
        <th height="35">날짜</th>
        <th height="35">조회수</th>
    </tr>
    <%
    ArrayList<NoticeDTO> list = dao.noticeList(startRow, endRow);
    for(NoticeDTO dto : list){
        String fix = (dto.getFix_yn().equals("y")) ? "fixed_row" : "";
    %>
    <tr align="center" style="height:10px" class="<%=fix%>">
        <td height="50" class="tlist"><%=dto.getNotice_num() %></td>
        <td height="50" class="tlist">공지사항</td>    
        <td height="50" class="tlist" align="left" style=" padding-left: 100;">
            <%if(dto.getFix_yn().equals("y")){%>
                📌      <% } %>
            <a href="noticeContent.jsp?num=<%=dto.getNotice_num()%>&pageNum=<%=pageNum%>">
                <%=dto.getTitle() %></a>
            <%if(dto.getImg() != null){%>
			<img src="../images/image_file_icon.png" width="15"/>	            	
            <%} %>
        </td>
        <td height="50" class="tlist">관리자</td>
        <td height="50" class="tlist"><%=dto.getReg() %></td>
        <td height="50" class="tlist">
            <%=dto.getReadCount() %>
            <%if(dto.getReadCount() >= 30){ %>
            			💥
            			<%} %>
        </td>
    </tr>
    <% } %>
</table>

<% 
	if( count > 0 ){
		int pageCount = count / pageSize +( count % pageSize == 0 ? 0 : 1 );
		int startPage = (int)((currentPage-1)/10) * 10 +1;
		
		int pageBlock = 10;
		
		int endPage = startPage + pageBlock -1;
		if( endPage > pageCount ){
			endPage = pageCount;
		}%>

		
<%		if( startPage > 10 ){ %>
			<a href="noticeList.jsp?pageNum=<%=startPage-10 %>">[이전]</a>
<% 		}%>
			<div class="pagination">
				<ul>
<%		for( int i = startPage; i <= endPage; i++ ){ %>
			<li 
			<% if (i == currentPage) { %>
			class="on"<% } %>>
			<a href="noticeList.jsp?pageNum=<%= i %>"><%= i %></a></li>
<%		}%>
				</ul>
			</div>
<%		if( endPage < pageCount){ %>
			<a href="noticeList.jsp?pageNum=<%=startPage+10 %>">[다음]</a>
<%		}
	}
%>
<div class="btn_right_box">	

<%	if(svendor.equals("3")){%>
	<button type="submit" class="btn_write" onclick="window.location='noticeWriteForm.jsp?pageNum=<%=pageNum%>'">
	<strong>작성</strong>
	</button>
<%} %>
</div>
