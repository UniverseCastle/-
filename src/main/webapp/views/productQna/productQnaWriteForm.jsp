<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.product.ProductDAO" %>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="project.bean.img.ImgDTO" %>
<%@ page import="project.bean.member.MemberDAO" %>
<%@ page import="project.bean.member.MemberDTO" %>
<%@ page import="java.util.List" %>
<link rel="stylesheet" href="/project/views/css/c_style.css">
<jsp:include page="../main/header.jsp"/>
<%
	ProductDAO daop = ProductDAO.getInstance();
	int product_num = Integer.parseInt( request.getParameter("product_num"));
	
	// 페이징
	int pageSize = 10;
	String pageNum = request.getParameter("pageNum");
	if( pageNum == null ){
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = ( currentPage - 1 ) * pageSize + 1;
	int endRow = currentPage * pageSize;
		
	// 이름 초기화
	String name="";
	// 세션
	int snum=0;
	if(session.getAttribute("snum") != null) {
	    snum = (int) session.getAttribute("snum");
		MemberDAO daom = MemberDAO.getInstance();
		MemberDTO dtom = daom.memberInfo(snum);
		name = dtom.getName();
	}

	
	
	
%>
	

<div id="contents">
	<div class="sub_content">
			<div class="board_zone_sec">
				<div class="board_zone_tit">
					<h2>상품문의 쓰기</h2>
				</div>
				<div class="board_view_tit">
				</div>	
<%		
	List<ProductDTO> list = daop.orderList(product_num);
%>

		<%for (ProductDTO dto : list){ %>
		<%-- 상품에 대한 정보 가져오는 테이블 --%>
		<table class="board_write_table">
			<tr>
				<% for(ImgDTO img : dto.getImages()){ %>
				<td>
					<img src="../upload/<%=img.getImg_name()%>" width="100" height="100"/>
				</td>
<%					} %>				
			</tr>
			<tr>
				<td>
				<%=dto.getCategory_name() %>
				<td>
			</tr>	
			<tr>
				<td>
				<%=dto.getProduct_name() %>
				<td>
			</tr>
			<tr>
				<td>
				<%=dto.getProduct_info() %>
				<td>
			</tr>
<%		} %>
		</table>				
<form action="productQnaWritePro.jsp?pageNum=<%=pageNum%>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="member_num" value="<%=snum %>"/>
	<input type="hidden" name="product_num" value="<%=product_num%>"/>
	<input type="hidden" name="delete_yn" value="n"/>
	<div class="board_write_box">
		

		<table class="board_write_table">
			<colgroup>
				<col style="width:15%"/>
				<col style="width:85%"/>
			</colgroup>
			<tr>
				<th>분류</th>
				<td>
					<select name="category">
						<option value="상품">상품</option>
						<option value="배송">배송</option>
						<option value="반품/환불">반품/환불</option>
						<option value="교환/변경">교환/변경</option>
						<option value="상품">기타</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><%=name %></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" placeholder="제목 입력"/></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="password"/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="question" cols="80" rows="30"></textarea></td>
			</tr>
			<tr>
				<th>비밀글</th>
				<td>
					O<input type="radio" name="secret_yn" value="y" checked/>
					X<input type="radio" name="secret_yn" value="n"/>
				</td>
			</tr>
			<tr>
				<th>파일</th>
				<td><input type="file" name="img"/></td>
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
<script>
</script>
