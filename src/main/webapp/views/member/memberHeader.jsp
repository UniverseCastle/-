<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="project.bean.category.CategoryDTO"%>
<%@ page import="java.util.List"%>
<%@page import="project.bean.product.ProductDAO"%>
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
  width :200px;
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
.form{
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
.QNABtn{
  border-style : none;
  border-radius : 4px;
  background-color: white;
  font-weight: 400;
  color : rgb(37, 37, 37);
  padding : 12px;
  width :200px;
  text-align: left;
  cursor : pointer;
  font-size : 25px;
  padding-left : 50px;
}
</style>

<%
	String svendor = "";
	if (session.getAttribute("svendor") != null) {
		svendor = (String)session.getAttribute("svendor");
	}

	int snum = 0;
	if (session.getAttribute("snum") != null) {
		snum = (int) session.getAttribute("snum");
	}
	ProductDAO dao = ProductDAO.getInstance();
	List<CategoryDTO> list = dao.loadCategory();
%>

<table class="headerTable">
	<tr class="h_tr">
		<td><a href="/project/views/main/introMain.jsp"><img src="/project/views/images/sooltong.png"
				width="150" height="150"></a></td>
		<td>
			<div class="dropdown">
				<button class="dropbtn" onclick="location.href='/project/views/main/main.jsp'">전체 상품
				</button>
				<div class="dropdown-content">
					<%for (CategoryDTO dto : list) { %> 			
							<a href="/project/views/main/categoryMain.jsp?category_num=<%=dto.getCategory_num()%>"><%=dto.getCategory_name()%></a>
					<%}%>
				</div>
			</div> 
		</td>
		<td>
			<div class="dropdown">
				<button class="dropbtn" onclick="location.href='/project/views/notice/noticeList.jsp'">문의 게시판</button>
			<div class="dropdown-content">
				<a href="/project/views/notice/noticeList.jsp">공지사항</a>
				<a href="/project/views/faq/faqList.jsp">자주찾는 질문</a>
				<a href="/project/views/qna/qnaList.jsp">1:1문의</a>
				<a href="/project/views/vendorQna/vendorQnaList.jsp">사업자문의</a>
				<a href="/project/views/productQna/productQnaList.jsp">상품문의</a>
				<a href="/project/views/review/list.jsp">상품후기</a>
			</div>
			</div>
		</td>
		<%if(svendor.equals("3")){ %>
		<td>
			<button class="dropbtn" onclick="location.href='/project/views/admin/adminMain.jsp'">관리자 모드</button>
		</td>
		<%} %>
		<td>
			<form class="form" id="searchForm"  action="main.jsp" method="get">
				<div class="search">
					<input type="text" class="text" name="keyWord" placeholder="상품명을 검색하세요 ex)대대포막걸리">
					<div>	
						<img id="searchIcon" src="/project/views/images/search.png" width="30" height="25" >
					</div>
				</div>	
			</form>
		</td>
		<td>
			<%
			if (snum != 0) {%>
				<img src="/project/views/images/logout3.png" width="100" height="100" onclick="location.href='/project/views/member/logout.jsp'">	
			 <%
			} else {
				 %> 
				 <img src="/project/views/images/login3.png" width="100" height="80" onclick="location.href='/project/views/member/loginForm.jsp'">
			
		<% } %>


		</td>
	
		<td>
			<% if (snum != 0) {%>
			<a href="/project/views/cart/cartList.jsp?member_num=<%= snum %>"><img src="/project/views/images/cart.png"></a>
			<%}else {%>
			<a href="#"><img src="/project/views/images/cart.png" onclick="cartImg()"></a>
			<%}%>
		</td>
		<td><a href="/project/views/member/mypage/main.jsp"><img
				src="/project/views/images/myinfo.png" width="25" height="25"></a></td>


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
	
	function cartImg(){
		alert("로그인 후 이용해주세요.");
		location.href="/project/views/member/loginForm.jsp";
	}

</script>