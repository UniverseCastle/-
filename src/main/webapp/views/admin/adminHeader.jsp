<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>

@import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable.min.css");

.dropdown{
  position : relative;
  display : inline-block;
}

.dropbtn_icon{
  font-family : 'Material Icons';
}
.dropbtn{
  border-style : none;
  border-radius : 4px;
  background-color: white;
  font-weight: 400;
  color : rgb(37, 37, 37);
  padding : 12px;
  width :300px;
  text-align: left;
  cursor : pointer;
  font-size : 25px;
  padding-left : 50px;
}
.dropdown-content{
  display : none;
  position : absolute;
  z-index : 1; /*다른 요소들보다 앞에 배치*/
  font-weight: 400;
  background-color: #f9f9f9;
  min-width : 200px;
}

.dropdown-content a{
  display : block;
  text-decoration : none;
  color : rgb(37, 37, 37);
  font-size: 12px;
  padding : 12px 20px;
}

.dropdown-content a:hover{
  background-color : #ececec
}

.dropdown:hover .dropdown-content {
  display: block;
}
.headerTable {
	width: 100%;
	height : 100px;
	border-collapse: collapse;
	text-align: center;
}

.h_tr {
	border-bottom: 1px solid #ddd;
}
form{
	display : flex;
	justify-content :center;
	align-items : center;
	height: 100px;
	
}
.search > .text{
	width: 230px;
	margin-right:5px;
}
.search > input:focus{
	outline:none;
}

.search > input {	
	
	height : 35px;
	border-style: none;
} 
.search{
	margin-top: 20px;
	display : flex;
	flex-direction: row;
	align-items : center;
	justify-content : center; 
	width: 300px;
	height : 50px;
	border : 1px solid #ddd;
	border-radius: 70px;
}
.search >.submit{
	background-color: white;
}
</style>

<%
	String svendor = "";
	if (session.getAttribute("svendor") != null) {
		svendor = (String)session.getAttribute("svendor");
	}
	
	if(!svendor.equals("3")){%>
		<script>
			alert("관리자 권한이 없습니다.");
			location.href="../member/loginForm.jsp";
		</script>
<%	}%>

<table class="headerTable">
	<tr class="h_tr">
		<td>
			<a href="../admin/adminMain.jsp"><img src="../images/admin2.png" width="250" height="250"></a>
		</td>
		<td>
			<div class="dropdown">
				<button  class="dropbtn" type="button" onclick="location.href='../adminmember/allMemberList.jsp'">전체 회원관리</button>
				<div class="dropdown-content">
					<a href="../adminmember/sellerJoinList.jsp">판매자 가입 승인대기 목록</a>
				</div>
			</div>
		</td>
		<td>
			<div class="dropdown">
				<button  class="dropbtn" type="button" onclick="location.href='/project/views/adminproduct/allProductList.jsp?sortName=created_date&sort=desc'">전체 상품관리</button>
				<div class="dropdown-content">
					<a href="../adminproduct/productAddList.jsp">판매자 상품등록 승인대기 목록</a>
				</div>
			</div>
		</td>
		<td>
			<div class="dropdown">
				<button class="dropbtn" onclick="location.href='../notice/noticeList.jsp'">문의 게시판</button>
			<div class="dropdown-content">
				<a href="../notice/noticeList.jsp">공지사항</a>
				<a href="../faq/faqList.jsp">자주찾는 질문</a>
				<a href="../qna/qnaList.jsp">1:1문의</a>
				<a href="../vendorQna/vendorQnaList.jsp">사업자문의</a>
				<a href="../productQna/productQnaList.jsp">상품문의</a>
				<a href="../review/list.jsp">상품후기</a>
			</div>
			</div>
		</td>
		<td>
			<button  class="dropbtn" type="button" onclick="location.href='../category/categoryInsertForm.jsp'">카테고리등록</button>
		</td>
		<td>
			<button class="dropbtn" onclick="location.href='../main/main.jsp'">사용자 메인</button>
		</td>
		<td>
			<form id="searchForm" action="../adminproduct/allProductList.jsp" method="get">
				<div class="search">
					<input type="text" class="text" name="keyWord" placeholder="상품명을 검색하세요 ex)대대포막걸리">
					<input type="hidden" name="sortName" value="created_date">
					<input type="hidden" name="sort" value="desc">
					<div>	
						<img id="searchIcon" src="../images/search.png" width="30" height="25" >
					</div>
				</div>	
			</form>
		</td>
	</tr>

</table>
<br>
<br>
<br>

<script>
	const searchIcon = document.getElementById("searchIcon");
	
	searchIcon.addEventListener("click", () => {
		document.getElementById("searchForm").submit();
	});
	

</script>