<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="project.bean.contact.FaqDAO" %>
<%@ page import="project.bean.contact.FaqDTO" %>
<%@ page import="project.bean.member.MemberDTO" %>
<%@ page import="project.bean.member.MemberDAO" %>
<%@ page import="java.util.ArrayList" %>
<% request.setCharacterEncoding("UTF-8"); %>
<link rel="stylesheet" href="/project/views/css/c_style.css">
<jsp:include page="../main/header.jsp"/>
<%
    int snum = 0;
    if (session.getAttribute("snum") != null) {
        snum = (int) session.getAttribute("snum");
    }
    String svendor="";
    if (session.getAttribute("svendor") != null) {
        svendor = (String)session.getAttribute("svendor");
    }
    FaqDAO dao = FaqDAO.getInstance();
    //페이징
    
    int pageSize = 10;
    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }
    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    int count = dao.boardCount();

    // 선택된 카테고리를 저장할 변수
    String selectedCategory = request.getParameter("category");
%>
<link rel="stylesheet" href="/project/views/css/c_style.css">
<style>
    #tlist {
        display: table-cell;
        vertical-align: inherit;
        border-top: 1px solid #A9A9A9;
        unicode-bidi: isolate;
    }

    a {
        text-decoration: none;
        font-size: 16px;
        cursor: pointer;
        color: #333;
    }
</style>
<div id="contents">
    <div class="distillery_wrap">
        <div class="wrap_box">
            <h3 class="wrap_title">
                자주 묻는 질문
            </h3>
            <ul class="wrap_tab">
                <li><a class="a-main" href="/project/views/notice/noticeList.jsp?pageNum=1">공지사항</a></li>
                <li class="on"><a class="a-main" href="/project/views/faq/faqList.jsp?pageNum=1">자주 묻는 질문</a></li>
                <li><a class="a-main" href="/project/views/qna/qnaList.jsp?pageNum=1">1:1 문의하기</a></li>
                <li><a class="a-main" href="/project/views/review/list.jsp">상품후기</a></li>
                <li><a class="a-main" href="/project/views/vendorQna/vendorQnaList.jsp?pageNum=1">사업자문의</a></li>
                <li><a class="a-main" href="/project/views/productQna/productQnaList.jsp?pageNum=1">상품문의</a></li>
            </ul>
        </div>
    </div>
</div>
<div align="center">
    <a onclick="showCategory('전체')">전체</a>
    |
    <a onclick="showCategory('회원가입/정보')">회원가입/정보</a>
    |
    <a onclick="showCategory('결제/배송')">결제/배송</a>
    |
    <a onclick="showCategory('교환/반품/환불')">교환/반품/환불</a>
    |
    <a onclick="showCategory('마일리지 적립')">마일리지 적립</a>
    |
    <a onclick="showCategory('기타')">기타</a>
</div>
<div class="board_zone_sec">
    <h1>자주 묻는 질문</h1>
</div>


<table class="board_list_table" style="width:100%">
    <colgroup>
        <col style="width:10%">
        <col style="width:10%">
        <col style="width:80%">
    </colgroup>
    <tr>
        <th height="35">번호</th>
        <th height="35">분류</th>
        <th height="35" align="left" style="padding-left:150">내용</th>
    </tr>
    <%
        ArrayList<FaqDTO> list = dao.faqList(startRow, endRow);
        for (FaqDTO dto : list) {
    %>
    <%-- 질문창 --%>
    <tr align="center" class="faq-row" style="height:10px">
        <td id="tlist" height="50" class="number-cell"><%=dto.getNum() %></td>
        <td id="tlist" height="50" class="category-cell"><%=dto.getCategory() %></td>
        <td id="tlist" height="50" align="left">
            <label class="question-label" onclick="toggleAnswer('<%=dto.getNum()%>')">
                <img src="../images/q.png" width="20"/>
                <%=dto.getQuestion() %>
            </label>
        </td>
    </tr>
    <%-- 답변창 --%>
    <tr id="answerRow<%=dto.getNum() %>" class="answer-row" style="display: none;">
        <td id="tlist" colspan="3" align="left" bgcolor="#F2F2F2" style="padding: 50; padding-left: 380;">
            <p><%=dto.getQuestion() %></p><br/>
            <img src="../images/a.png" width="20"/><%=dto.getAnswer() %>
            <%if(svendor.equals("3")){%>
            <button onclick="window.location='faqQuestion.jsp?faq_num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'">
                수정 / 삭제
            </button>	
            <%} %>
        </td>
    </tr>
    <%
        }
    %>
</table>


<%
    if (count > 0) {
        int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
        int startPage = (int) ((currentPage - 1) / 10) * 10 + 1;

        int pageBlock = 10;

        int endPage = startPage + pageBlock - 1;
        if (endPage > pageCount) {
            endPage = pageCount;
        }
%>

<%
        if (startPage > 10) {
%>
<a href="faqList.jsp?pageNum=<%=startPage-10 %>">[이전]</a>
<%
        }
%>
<div class="pagination">
    <ul>
        <%
            for (int i = startPage; i <= endPage; i++) {
        %>
        <li
        <%
            if (i == currentPage) {
        %>
        class="on"<%
            }
        %>>
            <a href="faqList.jsp?pageNum=<%= i %>"><%= i %></a></li>
        <%
            }
        %>
    </ul>
</div>
<%
        if (endPage < pageCount) {
%>
<a href="faqList.jsp?pageNum=<%=startPage+10 %>">[다음]</a>
<%
        }
    }
%>
<%

%>
<div class="btn_right_box">
    <%
        if (svendor.equals("3")) {
    %>
    <button type="submit" class="btn_write" onclick="window.location='faqWriteForm.jsp'">
        <strong>작성</strong>
    </button>
    <%
        }
    %>
     
</div>
<script>
    // FAQ의 답변내용을 숨겨놓고 토글시에 아래에 추가행을 넣어 표시하는 함수
    function toggleAnswer(id) {
        var answerRow = document.getElementById('answerRow' + id);
        var questionLabel = document.getElementById("questionLabel" + id);
        if (answerRow.style.display === "none") {
            answerRow.style.display = "table-row"; // 표의 행으로 표시
        } else {
            answerRow.style.display = "none";
        }
    }

    // 선택 카테고리만 표시하는 함수
    function showCategory(category) {
        var faqRows = document.querySelectorAll('.faq-row');
        faqRows.forEach(function (row) {
            var categoryCell = row.querySelector('.category-cell');
            if (category === '전체' || categoryCell.textContent.trim() === category) {
                row.style.display = 'table-row';
            } else {
                row.style.display = 'none';
            }
        });
    }

    // 삭제 버튼을 클릭하면 deleteForm으로 이동하며 글번호를 매개변수로 전달하는 함수입니다.


    // 선택된 카테고리를 볼드체로 표시하는 함수
    var categoryLinks = document.querySelectorAll('.category-link');
    categoryLinks.forEach(function (link) {
        link.style.fontWeight = 'normal'; // 모든 링크를 기본 스타일로 설정
        if (link.textContent.trim() === category) {
            link.style.fontWeight = 'bold'; // 선택한 카테고리 링크에만 볼드체 스타일 적용
        }
    });
</script>