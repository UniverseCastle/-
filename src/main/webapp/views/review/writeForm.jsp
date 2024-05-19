<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.review.ReviewDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>

<% 
	int snum = 0;
	if(session.getAttribute("snum") != null){
		snum = (int)session.getAttribute("snum"); // 판매자 세션
	}
	String svendor = "";
	if(session.getAttribute("svendor")!=null){
		svendor = (String)session.getAttribute("svendor");
	}
	int product_num = Integer.parseInt(request.getParameter("product_num"));
	String pageNum = "1";

	ReviewDAO dao = ReviewDAO.getInstance();
	boolean isBuyer = dao.checkBuyer(snum, product_num);
	
	int category_num = Integer.parseInt(request.getParameter("category_num"));
	
%>

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
	
	.custom-file {
		background-color: white;
		color: gray; 
		border: 1px solid lightgray;
		border-radius: 0; 
		padding: 5px 10px; 
		font-size: 16px; 
		cursor: pointer;
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
		
		if(!<%=isBuyer %>) {
			alert('구매한 상품에 한하여 리뷰 작성이 가능합니다.');
			return false;
		}
	}
</SCRIPT>

<br />
<DIV style="display:inline-block; font-size:25px; font-weight:bold; margin: auto 520px;"> 상품후기 </DIV>
<!-- <DIV style="display:inline-block; margin-left:1490px">
</DIV> -->
<FORM name="reviewInput" action="../review/writePro.jsp" method="POST" enctype="multipart/form-data" onsubmit="return reviewCheck()">
	<INPUT type="hidden" name="member_num" value=<%=snum %>>
	<INPUT type="hidden" name="product_num" value=<%=product_num %>>
	<INPUT type="hidden" id="ratingInput" name="rating" value="0">
	<INPUT type="hidden" name="category_num" value="<%= category_num %>"	/>
	<DIV class="stars" data-rating="0" style="margin: auto 520px;">
		<span class="star" data-value="1">&#9733;</span>	
		<span class="star" data-value="2">&#9733;</span>
		<span class="star" data-value="3">&#9733;</span>
		<span class="star" data-value="4">&#9733;</span>
		<span class="star" data-value="5">&#9733;</span>
	</DIV>
	<br /><br />	
	<DIV class="center-container">
	<TEXTAREA name="content"> </TEXTAREA> 
	</DIV>
	<br />
	<INPUT type="file" id="file" name="img" style="margin: auto 520px;" />
	<div style="width: 79%; text-align: right;">
 		<INPUT type="submit" class="emphasis" value="리뷰하기" />
		<INPUT type="button" value="전체리뷰" onclick="window.location='/project/views/review/list.jsp?pageNum=<%=pageNum %>'" />
	</div>
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