<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.review.ReviewDAO" %>
<%@ page import="project.bean.review.ReviewWrapper" %>
<%@ page import="project.bean.review.ReviewDTO" %>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="project.bean.img.ImgDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>

<jsp:include page="/views/member/memberHeader.jsp" />
<link rel="stylesheet" type="text/css" href="/project/views/css/member.css">

<STYLE>
	.star {
		font-size: 24px;
		cursor: pointer;
		color: #ffcc00;;
		transition: color 0.2s;
	}

</STYLE>

<%

	int snum = 0;
	if(session.getAttribute("snum")!=null){
		snum = (int)session.getAttribute("snum");
	}
	String svendor = "";
	if(session.getAttribute("svendor")!=null){
		svendor = (String)session.getAttribute("svendor");
	}
	ReviewDAO dao = ReviewDAO.getInstance();
	
	int pageSize = 5;
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage-1)*pageSize+1;
	int endRow = currentPage*pageSize;
	
	int count = dao.count();
	
	ArrayList<ReviewWrapper> list = dao.list(startRow, endRow);
%>
<%-- 상단메뉴바 추가시작 --%>
<link rel="stylesheet" href="/project/views/css/c_style.css">
<style>
a {
	text-decoration: none;
	font-size: 16px;
	cursor : pointer;
	color: #333;
}
.tlist {
    display: table-cell;
    vertical-align: inherit;
    border-top: 1px solid #A9A9A9;
    unicode-bidi: isolate;
}
</style>
<body>
	<div id="contents">
		<div class="distillery_wrap">
			<div class="wrap_box">
				<h3 class="wrap_title">
					1:1 문의하기
				</h3>
				<ul class="wrap_tab">
					<li><a class="a-main" href="/project/views/notice/noticeList.jsp?pageNum=<%=pageNum%>">공지사항</a></li>
					<li><a class="a-main" href="/project/views/faq/faqList.jsp?pageNum=<%=pageNum%>">자주 묻는 질문</a></li>
					<li><a class="a-main" href="/project/views/qna/qnaList.jsp?pageNum=<%=pageNum%>">1:1 문의하기</a></li>
					<li class="on"><a class="a-main" href="/project/views/review/list.jsp">상품후기</a></li>
					<li><a class="a-main" href="/project/views/vendorQna/vendorQnaList.jsp?pageNum=<%=pageNum%>">사업자문의</a></li>
					<li><a class="a-main" href="/project/views/productQna/productQnaList.jsp?pageNum=<%=pageNum%>">상품문의</a></li>
				</ul>
			</div>
		</div>
	</div>
</body>
<%-- 상단메뉴바 추가끝 --%>

<DIV style="font-size:35px; font-weight: bold; margin-left:620px">상품후기보기</DIV> <br />
	
<TABLE class="maintable" border="1" align="center" width="882px" style="border-collapse:collapse; border:none">

<%	if(count==0) {
%>
		<TR style="border-top:1px solid black; border-bottom:1px solid black">
			<TD colspan="2"> 게시글이 없습니다. </TD>
		</TR>

<%	}else {
		for(ReviewWrapper wrapper : list) {
		
			ReviewDTO reviewDTO = wrapper.getReviewDTO();
			ProductDTO productDTO = wrapper.getProductDTO();
			ImgDTO imgDTO = wrapper.getImgDTO();
			
			// SimpleDateFormat을 사용하여 포맷 지정
		    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		    // format 메서드를 사용하여 Timestamp를 문자열로 변환
		    String formattedDate = sdf.format(reviewDTO.getReg());
		    
		    String rating = reviewDTO.getRating();
%>
			<TR style="border-top:1px solid black">
				<TD class="tlist" rowspan="2" width="250px" align="center">
					<A href="/project/views/product/productContent.jsp?product_num=<%=productDTO.getProduct_num() %>&pageNum=<%=pageNum %>&category_num=<%=productDTO.getCategory_num() %>">
						<IMG width="200px" height="200px" src="/project/views/upload/<%=imgDTO.getImg_name()%>" />
					</A>
				</TD>
				<TD class="tlist"><B><%=productDTO.getProduct_name() %></B>
				<%if(svendor.equals("3")){ %>
					<INPUT type="button" value="삭제" class="emphasis" onclick="deleteBtn(<%=reviewDTO.getReview_num() %>, <%=pageNum %>)" />
				<%} %>
				</TD>
			</TR>
			<TR>
				<TD class="tlist" rowspan="3" >
					<%=reviewDTO.getContent() %><br />
<%  		if(reviewDTO.getImg() == null) {		//이미지가 없을 때
%>	
<%			}else{	//이미지가 있을 경우
%>				
					<IMG  style="margin-top:40px;" width="100px" height="100px" src="/project/views/upload/<%=reviewDTO.getImg()%>" />
<%			}
%>
				</TD>
			</TR>
			<TR>
				<TD class="tlist" align="center">
<%			if(rating.equals("1")) {
%>
				<span class="star">&#9733;</span>
<%			}else if(rating.equals("2")) {
%>			
				<span class="star">&#9733;</span>
				<span class="star">&#9733;</span>
<%			}else if(rating.equals("3")) {
%>
				<span class="star">&#9733;</span>
				<span class="star">&#9733;</span>
				<span class="star">&#9733;</span>
<%			}else if(rating.equals("4")) {
%>
				<span class="star">&#9733;</span>
				<span class="star">&#9733;</span>
				<span class="star">&#9733;</span>
				<span class="star">&#9733;</span>
<%			}else if(rating.equals("5")) {
%>
				<span class="star">&#9733;</span>
				<span class="star">&#9733;</span>
				<span class="star">&#9733;</span>
				<span class="star">&#9733;</span>
				<span class="star">&#9733;</span>
<%			}
%>
				</TD>
			</TR>
			<TR style="border-bottom:1px solid #A9A9A9">
				<TD class="tlist" align="center"><%=formattedDate %></TD> 
			</TR>
			<TR >
				<TD class="tlist" style="border-style : none;"></TD>
			</TR>
<%		}
	}
%>
</TABLE>

<DIV align="center">
<%
	int pageCount = count/pageSize + (count%pageSize==0?0:1);
	int pageBlock = 5;
	int startPage = (int)((currentPage-1)/pageBlock)*pageBlock+1;
	int endPage = startPage + pageBlock - 1;
	if(endPage > pageCount) {
		endPage = pageCount;
	}
	if(startPage > pageBlock) {
%>
	<A href = "list.jsp?pageNum=<%=startPage - pageBlock %>">[이전]</A>		
<%	}
	for (int i=startPage; i<=endPage; i++) {
%>
	<A href = "list.jsp?pageNum=<%=i %>">[<%=i %>]</A>	
<%	}
	if(endPage < pageCount) {
%>
	<A href = "list.jsp?pageNum=<%=startPage + pageBlock %>">[다음]</A>
<%	}
%>
</DIV>
   
<SCRIPT>
	function deleteBtn(review_num, pageNum) {
		if(!confirm("리뷰를 삭제하시겠습니까?")){
			alert("리뷰 삭제가 취소되었습니다.");
			return false;
		}
		location.href="/project/views/review/deletePro.jsp?ad=1&review_num="+review_num+"&pageNum="+pageNum;
	}
</SCRIPT>
