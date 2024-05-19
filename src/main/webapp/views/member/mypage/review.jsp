<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.mypage.MypageDAO" %>
<%@ page import="project.bean.mypage.MypageWrapper" %>
<%@ page import="project.bean.review.ReviewDTO" %>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="project.bean.img.ImgDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>

<% request.setCharacterEncoding("UTF-8"); %>

<%-- 나의 후기 --%>

<jsp:include page="/views/member/memberHeader.jsp" />
<jsp:include page="fixed.jsp" />

<link rel="stylesheet" type="text/css" href="/project/views/css/member.css">

<STYLE>
	.star {
		font-size: 24px;
		cursor: pointer;
		color: #ffcc00;
		transition: color 0.2s;
	}

</STYLE>

<%
	int snum = (int)session.getAttribute("snum");
	String svendor = (String)session.getAttribute("svendor");
	
	MypageDAO dao = MypageDAO.getInstance();
	
	int pageSize = 5;
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage-1)*pageSize+1;
	int endRow = currentPage*pageSize;
	
	int count = dao.review_count(snum);
	
	ArrayList<MypageWrapper> list = dao.review(snum, startRow, endRow);
%>
	
<DIV style="font-size:25px; font-weight:bold"> 나의 상품 후기</DIV> <br />

<TABLE class="maintable" border="1" width="882px" style="border-collapse:collapse; border:none;">

<%	if(count==0) {
%>
		<TR>
			<TD colspan="3"> 게시글이 없습니다. </TD>
		</TR>

<%	}else {
		for(MypageWrapper wrapper : list) {
		
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
				<TD rowspan="2" width="250px" align="center">
					<A href="/project/views/product/productContent.jsp?product_num=<%=productDTO.getProduct_num() %>&pageNum=<%=pageNum %>&category_num=<%=productDTO.getCategory_num() %>">  
						<IMG width="200px" height="200px" src="/project/views/upload/<%=imgDTO.getImg_name()%>" />
					</A>
				</TD>
				<TD>
					<B><%=productDTO.getProduct_name() %></B>
				</TD>
				<TD width="150px" align="center">
					<INPUT type="button" value="수정" onclick="window.location='/project/views/review/updateForm.jsp?review_num=<%=reviewDTO.getReview_num() %>'" />
					<INPUT type="button" value="삭제" class="emphasis" onclick="deleteBtn(<%=reviewDTO.getReview_num() %>, <%=pageNum %>)" />
				</TD>
			</TR>
			<TR>
				<TD rowspan="3" colspan="2">
					<%=reviewDTO.getContent() %><br />
<%  		if(reviewDTO.getImg() == null) {		//이미지가 없을 때
%>	
<%			}else{	//이미지가 있을 경우
%>				
					<IMG style="margin-top:40px;" width="100px" height="100px" src="/project/views/upload/<%=reviewDTO.getImg()%>" />
<%			}
%>
				</TD>
			</TR>	
			<TR>
				<TD align="center">
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
			<TR style="border-bottom:1px solid black">
				<TD align="center"><%=formattedDate %></TD> 
			</TR>
<%		}
	}
%>
</TABLE>

<SCRIPT>
	function deleteBtn(review_num, pageNum) {
		if(!confirm("리뷰를 삭제하시겠습니까?")){
			alert("리뷰 삭제가 취소되었습니다.");
			return false;
		}
		location.href="/project/views/review/deletePro.jsp?review_num="+review_num+"&pageNum="+pageNum;
	}
</SCRIPT>

<DIV style="margin:auto 880px;">
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
	<A href = "reivew.jsp?pageNum=<%=startPage - pageBlock %>">[이전]</A>		
<%	}
	for (int i=startPage; i<=endPage; i++) {
%>
	<A href = "review.jsp?pageNum=<%=i %>">[<%=i %>]</A>	
<%	}
	if(endPage < pageCount) {
%>
	<A href = "review.jsp?pageNum=<%=startPage + pageBlock %>">[다음]</A>
<%	}
%>
</DIV>
