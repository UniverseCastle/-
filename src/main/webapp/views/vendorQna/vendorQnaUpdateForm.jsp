<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.member.MemberDAO" %>
<%@ page import="project.bean.member.MemberDTO" %>
<%@ page import="project.bean.contact.VendorQnaDAO" %>
<%@ page import="project.bean.contact.VendorQnaDTO" %>
<jsp:include page="../main/header.jsp"/>
<%
	int snum = (int)session.getAttribute("snum");
	int num = Integer.parseInt(request.getParameter("num")); 
	String pageNum = "";
	String business_name="";
	
	if(session.getAttribute("snum") != null) {
	    snum = (int) session.getAttribute("snum");
		MemberDAO daom = MemberDAO.getInstance();
		MemberDTO dtom = daom.memberInfo(snum);
		business_name = dtom.getBusiness_name();
	}
	
	
	if(request.getParameter("pageNum")!=null){
		pageNum = request.getParameter("pageNum");
	}
	
	try{
		VendorQnaDAO dao = VendorQnaDAO.getInstance();
		VendorQnaDTO dto = dao.vendorQnaUpdateForm(num);
		if(dto.getAnswer() != null){%>
		<script>
			alert("답글이 작성된 글은 수정할 수 없습니다.");
			history.go(-1);
		</script>
	<%	}else{%>
<link rel="stylesheet" href="/project/views/css/c_style.css">
<div id="contents">
	<div class="sub_content">
		<div class="content">
				<div class="board_zone_sec">
					<div class="board_zone_tit">
							<h2>사업자 문의글 수정</h2>
					</div>
					<div class="board_view_tit"></div>

<form action="vendorQnaUpdatePro.jsp?num=<%=num%>&pageNum=<%=pageNum %>" method="post" enctype="multipart/form-data">
<%
	if(snum != 0){%>
		<input type="hidden" name="member_num" value="<%=snum%>"/>
		<input type="hidden" name="delete_yn" value="n"/>
<%	} %>
	<input type="hidden" name="delete_yn" value="n"/>
	<input type="hidden" name="member_num" value="<%=snum%>"/>  
	<div class="board_write_box">	
		<table class="board_write_table">
			<colgroup>
				<col style="width:15%">
				<col style="width:85%">
			</colgroup>
			<tr>
				<th scope="row">작성자</th>
				<td>
					<%=business_name %>
				</td>
			</tr>
			<tr>
				<th scope="row">비밀번호</th>
				<td>
					<input type="password" name="password"/>
				</td>
			</tr>
			<tr>
				<th scope="row">제목</th>
				<td>
					<input type="text" name="title" value="<%=dto.getTitle()%>"/>
				</td>
			</tr>
			<tr>
				<th scope="row">비밀글</th>
				<td>
					O<input type="radio" name="secret_yn" value="y"/>
					X<input type="radio" name="secret_yn" value="n" checked/>
				</td>
			</tr>
			<tr>
				<th scope="row">본문</th>
				<td>						
					<textarea name="question" cols="30" rows="10"><%=dto.getQuestion()%></textarea>
				</td>
			</tr>
			<tr>
				<th scope="row">첨부파일</th>
				<td>
					<input type="file" name="img"/>
				</td>	
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
</div>
 
<%}	}catch(Exception e){
	
} %>