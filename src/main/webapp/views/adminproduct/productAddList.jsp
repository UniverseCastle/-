<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.admin.AdminDAO" %>
<%@ page import="project.bean.enums.ProductStatus" %>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="project.bean.img.ImgDTO" %>
<%@ page import="project.bean.search.SearchDTO" %>

<style>
	a {
  		text-decoration-line: none;
  		color: #888;
  	}
	.main{
		width :100%;
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;		
	}
	.adminTable{
	  width: 1800px;
	  height: 700px;
	  border-collapse: collapse;
	  text-align: center;
	  font-size: 25px;
	  margin-bottom: 40px;
	  margin-top: 40px;
	}
	.adminTable>td,.tr1,.tr2{
		border-top : 1px solid #ddd;
	}
	
	#pageActive{
		color: skyblue; /* 선택된 링크의 색상 */
		font-weight: bold; /* 선택된 링크의 텍스트를 굵게 표시 */
	}
</style>
<jsp:include page="../admin/adminHeader.jsp"></jsp:include>
<%
	AdminDAO dao = AdminDAO.getInstance();
	String status ="";
	String keyWord ="";
	String sortName="";
	String sort="";
	String svendor="";	
	int snum = 0;
	
	if(session.getAttribute("svendor")!=null){
		svendor = (String)session.getAttribute("svendor");
	}
	if(session.getAttribute("snum")!=null){
		snum = (int)session.getAttribute("snum");
	}
	if(!(svendor.equals("3")) && snum == 0){%>
		<script>
			alert("관리자 권한이 없습니다.");
			location.href="../member/loginForm.jsp";
		</script>
<%	}
	
	if(request.getParameter("keyWord")!=null){
		 keyWord = request.getParameter("keyWord");
	}
	
	if(request.getParameter("sortName")!=null){
		sortName = request.getParameter("sortName");
	}else{
		sortName = "created_date";
	}
	
	if(request.getParameter("sort")!=null){
		sort = request.getParameter("sort");
	}else{
		sort = "desc";
	}	
	
	//페이징
	int pageSize = 10;
	
	String pageNum = request.getParameter("pageNum");
	if( pageNum == null ){
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = ( currentPage - 1 ) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int productAddCount = dao.productAddCount();

	SearchDTO searchDto = new SearchDTO(startRow,endRow,keyWord,sortName,sort);
	
	List<ProductDTO> list = dao.loadProductwaitList(searchDto);
%>
<div class="main">
<div style="text-align: left;width: 1800px;">
<p style="font-size:20px;">전체회원수 <b style="color:skyblue"><%=productAddCount%></b>명</p>
</div>
<table class="adminTable">
	<tr class="tr1" style="border-top:2px solid black;border-bottom:2px solid black;">
		<th class="1">상품번호</th>
		<th class="2">대표이미지</th>
		<th class="3">상품명</th>
		<th class="4">상품가격</th>
		<th class="5">상품설명</th>
		<th class="6">제조사</th>
		<th class="7">사업자 번호</th>
		<th class="8">등록일</th>
		<th class="9">상품 등록 상태</th>
		<th class="10">상품삭제여부</th>
		<th class="11">승인/거절</th>
	</tr>
	<% for(ProductDTO dto : list){ 
		
		String business_name = dao.findBusinessName(dto.getMember_num());
		String business_number = dao.findBusinessNumber(dto.getMember_num());
		status = ProductStatus.getNameByProductStatus(dto.getStatus());
	%>
	
	<tr class="tr2" >
		<td class="1"><%=dto.getProduct_num() %></td>
		<% for(ImgDTO imgDto : dto.getImages()){ %>
			<td class="2"><img src="../upload/<%=imgDto.getImg_name()%>" width="100" height="100"></td>
		<% } %>
		<td class="3"><%=dto.getProduct_name()%></td>
		<td class="4"><%=dto.getPrice() %></td>
		<td class="5"><%=dto.getProduct_info()%></td>
		<td class="6"><%=business_name%></td>
		<td class="7"><%=business_number%></td>
		<td class="8"><%=dto.getCreated_date()%></td>
		<td class="9"><%=status%></td>
		<td class="10"><%=dto.getDelete_yn()%></td>
		<td class="11">
			<button type="button" onclick="approval(<%=dto.getProduct_num()%>)">승인</button>
			<button type="button" onclick="refuse(<%=dto.getProduct_num()%>)">거절</button>
		</td>
	</tr>
	<%} %>
</table>

	<%


	if( productAddCount > 0 ){
		int pageCount = productAddCount / pageSize +( productAddCount % pageSize == 0 ? 0 : 1 );
		int startPage = (int)((currentPage-1)/10) * 10 +1;
		int pageBlock = 10;
		
		int endPage = startPage + pageBlock -1;
		if( endPage > pageCount ){
			endPage = pageCount;
		}%>
	<%	if( startPage > 10 ){ %>
			<a href="../main/main.jsp?pageNum=<%=startPage-10 %>">[이전]</a>
<% 		}
		for( int i = startPage; i <= endPage; i++ ){ %>
			<a href="../main/main.jsp?pageNum=<%=i%>">[<%=i %>]</a>
<%		}
		if( endPage < pageCount){ %>
			<a href="../main/main.jsp?pageNum=<%=startPage+10 %>">[다음]</a>
<%		}
	}
	
%>
</div>

<script>
	function approval(product_num){
		if(!confirm("상품 등록을 승인하시겠습니까?")){
			return false;
		}
		location.href="productApprovalPro.jsp?status=1&product_num="+product_num;
	}
	function refuse(product_num){
		if(!confirm("상품 등록을 거절 하시겠습니까?")){
			return false;
		}
		location.href="productRefusePro.jsp?status=2&product_num="+product_num;
	}
</script>