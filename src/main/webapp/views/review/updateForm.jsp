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

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="/views/member/memberHeader.jsp" />
<jsp:include page="/views/member/mypage/fixed.jsp" />
<link rel="stylesheet" type="text/css" href="/project/views/css/member.css">

<STYLE>
	.stars {
		display: inline-block;
	}

	.star {
		font-size: 24px;
		cursor: pointer;
		color: #ccc;
		transition: color 0.2s;
	}

	.star.active {
		color: #ffcc00;
	}
	.center-container {
    	display: flex;
    	justify-content: center;
	}
	
	textarea {
    	width: 50%; 
    	height: 200px; 
	}
</STYLE>

<SCRIPT>
	function reviewCheck(){	//유효성 검사 - 필수 작성 항목
		var ratingInput = document.getElementById('ratingInput');
		if(ratingInput.value === "0") {
			alert("별점을 입력해 주세요");
			return false;
		}
		
		var content = document.reviewInput.content.value.trim();
		if(!content) {
			alert("내용을 입력해 주세요.");
			document.reviewInput.content.focus();
			return false;
		}
	}
</SCRIPT>

<% 
	int snum = (int)session.getAttribute("snum"); 
	String svendor = (String)session.getAttribute("svendor");
	
	int review_num = Integer.parseInt(request.getParameter("review_num"));

	ReviewDAO dao = ReviewDAO.getInstance();
	
	ArrayList<ReviewWrapper> list = dao.updateForm(review_num);
	
%> 
    
<DIV style="font-size:25px; font-weight:bold;" > 상품 후기 수정</DIV> <br />
<FORM name="reviewInput" action="../review/updatePro.jsp" method="POST" enctype="multipart/form-data" onsubmit="return reviewCheck();">
	<INPUT type="hidden" name="review_num" value=<%=review_num %> />
	
<TABLE border="1" width="882px" style="border-collapse:collapse; border:none;">
<%	for(ReviewWrapper wrapper : list) {
	
	ReviewDTO reviewDTO = wrapper.getReviewDTO();
	ProductDTO productDTO = wrapper.getProductDTO();
	ImgDTO imgDTO = wrapper.getImgDTO();
	
	// SimpleDateFormat을 사용하여 포맷 지정
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    // format 메서드를 사용하여 Timestamp를 문자열로 변환
    String formattedDate = sdf.format(reviewDTO.getReg());
    
%>
	<TR style="border-top:1px solid black">
		<TD rowspan="2" width="250px" align="center">
			<IMG width="200px" height="200px" src="/project/views/upload/<%=imgDTO.getImg_name()%>" />
			<INPUT type="hidden" name="product_num" value=<%=reviewDTO.getProduct_num() %> />
		</TD>
		<TD><B><%=productDTO.getProduct_name() %></B></TD>
		<TD align="center" width="50px">
			<INPUT type="submit" class="emphasis" value="수정" /> 
		</TD>
	</TR>
	<TR>
		<TD rowspan="3" colspan="2" style="vertical-align:top">
			<TEXTAREA name="content" style="width:600px; height:100px"> <%=reviewDTO.getContent() %></TEXTAREA> <br />
			<br />
<%  	if(reviewDTO.getImg() == null) {		//이미지가 없을 때
%>	
			<INPUT type="file" name="img" /><br />
<%		}else{	//이미지가 있을 경우
%>
			<INPUT type="file" name="img" /><br />
			<INPUT type="hidden" name="orgImg" value="<%=reviewDTO.getImg() %>" />
			<IMG  width="200px" height="200px" style="display:inline-block;" src = "/project/views/upload/<%=reviewDTO.getImg() %>" />
<%	}
%>
		</TD>
	</TR>
	<TR>
		<TD align="center">
		<INPUT type="hidden" id="ratingInput" name="rating" value="0">
			<DIV class="stars" data-rating="0">
				<span class="star" data-value="1">&#9733;</span>	
				<span class="star" data-value="2">&#9733;</span>
				<span class="star" data-value="3">&#9733;</span>
				<span class="star" data-value="4">&#9733;</span>
				<span class="star" data-value="5">&#9733;</span>
			</DIV>
		</TD>
	</TR>
	<TR>
		<TD align="center"><%=formattedDate %></TD> 
	</TR>
<%	}
%>
</TABLE>
</FORM>

<SCRIPT>
	document.addEventListener('DOMContentLoaded', function () {
		const stars = document.querySelectorAll('.star');

		stars.forEach(star => {
			star.addEventListener('click', function () {
			const rating = parseInt(this.getAttribute('data-value'));
 			document.getElementById('ratingInput').value = rating;

			// 선택한 별 이전의 모든 별에 active 클래스 추가
			this.parentElement.querySelectorAll('.star').forEach(prevStar => {
				prevStar.classList.add('active');
			});

			// 선택한 별부터 뒤의 모든 별에 active 클래스 제거
			let nextStar = this.nextElementSibling;
				while (nextStar) {
					nextStar.classList.remove('active');
					nextStar = nextStar.nextElementSibling;
				}
			});
		});
	});
</SCRIPT>