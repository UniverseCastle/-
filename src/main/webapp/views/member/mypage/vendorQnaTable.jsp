<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.mypage.MypageDAO" %>
<%@ page import="project.bean.contact.VendorQnaDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>

<% request.setCharacterEncoding("UTF-8"); %>

<link rel="stylesheet" type="text/css" href="/project/views/css/member.css">

<%

	int snum = 0;
	
	if(session.getAttribute("snum")!=null){
		snum = (int)session.getAttribute("snum");
	}
	if(snum ==0){%>
		<script>
			alert("세션 만료 다시 로그인해주세요");
			location.href="/project/views/member/loginForm.jsp"
		</script>
<%	}
	String svendor = (String)session.getAttribute("svendor");
	String start = "";
	String end = "";
	
	if(request.getParameter("start")==null){
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		start =  sdf.format(date);
	}else{	
		start = request.getParameter("start");	//조회 시작 날짜
	}
	
	if(request.getParameter("end")==null){
		Date date = new Date();
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
		end =  sdf2.format(date);
	}else{	
		end = request.getParameter("end");	//조회 시작 날짜
	}
	
	String pageNum = "1";
	
	MypageDAO dao = MypageDAO.getInstance();
	
	int vendor_qna_count = dao.vendor_qna_count(snum, start, end);
	
	ArrayList<VendorQnaDTO> list = dao.vendor_qna(snum, start, end);
%>

<TABLE class="maintable" border="1" width="882px">
	<TR>
		<TD colspan="4"> 1:1문의 내역 총 <%=vendor_qna_count %>건 </TD>
	</TR>
	<TR>
		<TH width="150px">문의날짜</TH>
	 	<TH>제목</TH>
	 	<TH width="150px">문의상태</TH>
	</TR>
<%	if(vendor_qna_count==0) {
%>	
	<TR>
		<TD colspan="3" align="center"> 게시글이 존재하지 않습니다. </TD>
	</TR>
<%	}else {
		for(VendorQnaDTO dto : list) {
			
			//Timestamp형태의 변수를 YYYY-MM-DD 형식으로 변환
			Timestamp timestamp = dto.getReg();
		    // SimpleDateFormat을 사용하여 포맷 지정
		    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		    // format 메서드를 사용하여 Timestamp를 문자열로 변환
		    String formattedDate = sdf.format(timestamp);	
%>
			<TR>
				<TD align="center"> <%=formattedDate %> </TD>
				<TD align="left">
					<DIV style="display:flex; align-items:center; float:left;">
						
<%			if(dto.getSecret_yn().equals("y")){			
%>
						<IMG width="20px" height="20px" style="display:inline-block;margin:0 auto;" 
								src="/project/views/images/security.png"/>&nbsp;
<%			}
%>
						<A href = "/project/views/qna/qnaQuestion.jsp?vendor_qna_num=<%=dto.getVendor_qna_num()%>&pageNum=<%=pageNum %>">	
							<%=dto.getTitle() %>&nbsp;
						</A>
<%			if(dto.getImg()!=null){
%>			
						<IMG width="20px" height="20px" style="display:inline-block;margin:0 auto;" 
								src="/project/views/images/addFile.png"/>
<%			}
%>						
					</DIV>
				</TD>
				<TD align="center">
<%			if(dto.getAnswer() == null) {
%>					
					접수
<%			}else {
%>	
					답변완료
<%			}
%>
				</TD>
			</TR>
<%		}
	}
%>
</TABLE>
