<%@page import="project.bean.enums.MemberStatus"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.admin.AdminDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="project.bean.member.MemberDTO" %>
<%@ page import="project.bean.enums.MemberVendor" %>
<%@ page import="project.bean.enums.MemberStatus" %>
<style>
	.main{
		width :100%;
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;		
	}
	.adminTable{
	  width: 1400px;
	  height: 700px;
	  border-collapse: collapse;
	  text-align: center;
	  font-size: 25px;
	  margin-bottom: 40px;
	}
	.adminTable>td,.tr1,.tr2{
		border-top : 1px solid #ddd;
	}
	.adminTable> .1,.2{
		width : 10%;
	}
</style>
<jsp:include page="../admin/adminHeader.jsp"></jsp:include>
<%	
	AdminDAO dao = AdminDAO.getInstance();
	String del ="";
	String vendor="";
	String svendor="";
	
	if(session.getAttribute("svendor")!=null){
		svendor = (String)session.getAttribute("svendor");
	}
	if(!(svendor.equals("3"))){%>
	<script>
		alert("관리자 권한이 없습니다.");
		location.href="../member/loginForm.jsp";
	</script>
<%	}
	//페이징
	int pageSize = 10;
	
	String pageNum = request.getParameter("pageNum");
	if( pageNum == null ){
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = ( currentPage - 1 ) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int allMemberCount = dao.AllMemberCount();	
	
	List<MemberDTO> list = dao.loadAllMemeber(startRow, endRow);
	
%>

<div class="main">
<div style="text-align: left;width: 1400px;">
<p style="font-size:20px;">전체회원수 <b style="color:skyblue"><%=allMemberCount%></b>명</p>
</div>
<table class="adminTable">
	<tr class="tr1" style="border-top:2px solid black;border-bottom:2px solid black;">
		<th class="1">회원번호</th>
		<th class="2">ID</th>
		<th class="3">회원 권한</th>
		<th class="4">사업자번호</th>
		<th class="5">사업장 명</th>
		<th class="6">회원명</th>
		<th class="7">성별</th>
		<th class="8">회원등급</th>
		<th class="9">탈퇴여부</th>
		<th class="9">회원관리</th>
	</tr>
	<% for(MemberDTO dto : list){ 
		
		vendor = MemberVendor.getNameByVendor(dto.getVendor());
		
		del = MemberStatus.getNameByStatus(dto.getDel()); 
	
	%>
	
	<tr class="tr2" >
		<td class="1"><%=dto.getMember_num() %></td>
		<td class="2"><%=dto.getId()%></td>
		<td class="3"><%=vendor%></td>
		<%if(dto.getBusiness_number()!=null){ %>
		<td class="4"><%=dto.getBusiness_number() %></td>
		<%}else{ %>
			<td><p>없음</p></td>
		<%} %>
		<%if(dto.getBusiness_name()!=null){ %>
		<td class="5"><%=dto.getBusiness_name() %></td>
		<%}else{ %>
			<td><p>없음</p></td>
		<%} %>
		<td class="6"><%=dto.getName() %></td>
		<td class="7"><%=dto.getGender() %></td>
		<td class="8"><%=dto.getGrade() %></td>
		<td class="9"><%=del %></td>
		<td class="9">
			<button type="button" onclick="location.href='memberDetail.jsp?member_num=<%=dto.getMember_num()%>'">관리</button>
		</td>
	</tr>
	<%} %>
</table>

	<%


	if( allMemberCount > 0 ){
		int pageCount = allMemberCount / pageSize +( allMemberCount % pageSize == 0 ? 0 : 1 );
		int startPage = (int)((currentPage-1)/10) * 10 +1;
		int pageBlock = 10;
		
		int endPage = startPage + pageBlock -1;
		if( endPage > pageCount ){
			endPage = pageCount;
		}%>
	<%	if( startPage > 10 ){ %>
			<a href="allMemberList.jsp?pageNum=<%=startPage-10 %>">[이전]</a>
<% 		}
		for( int i = startPage; i <= endPage; i++ ){ %>
			<a href="allMemberList.jsp?pageNum=<%=i%>">[<%=i %>]</a>
<%		}
		if( endPage < pageCount){ %>
			<a href="allMemberList.jsp?pageNum=<%=startPage+10 %>">[다음]</a>
<%		}
	}
	
%>
</div>