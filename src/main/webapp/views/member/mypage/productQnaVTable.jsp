<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.mypage.MypageDAO" %>
<%@ page import="project.bean.mypage.MypageWrapper" %>
<%@ page import="project.bean.contact.ProductQnaDTO" %>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>

<% request.setCharacterEncoding("UTF-8"); %>

<%-- 정해진 기간동안 상품 문의 갯수 (판매자) --%>

<link rel="stylesheet" type="text/css" href="/project/views/css/member.css">

<STYLE>
	BUTTON:disabled {
	    opacity: 0.5;
	    cursor: not-allowed;
	}
</STYLE>

<%
	int snum = (int)session.getAttribute("snum");
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
	
	int product_qnaV_count = dao.product_qnaV_count(snum, start, end);
	
	ArrayList<MypageWrapper> list = dao.product_qnaV(snum, start, end);
%>

<TABLE class="maintable" border="1" width="882px">
	<TR>
		<TD colspan="5"> 상품문의 내역 총 <%=product_qnaV_count %>건 </TD>
	</TR>
	<TR>
		<TH width="100px">문의날짜</TH>
	 	<TH width="80px">카테고리</TH>
	 	<TH>상품명/제목</TH>
	 	<TH width="100px">문의상태</TH>
	 	<TH width="100px">답변하기</TH>
	</TR>
<%	if(product_qnaV_count==0) {
%>	
	<TR>
		<TD colspan="5" align="center"> 게시글이 존재하지 않습니다. </TD>
	</TR>
<%	}else {
		for(MypageWrapper wrapper : list) {
			ProductQnaDTO productQnaDTO = wrapper.getProductQnaDTO();
			ProductDTO productDTO = wrapper.getProductDTO();
			//Timestamp형태의 변수를 YYYY-MM-DD 형식으로 변환
			Timestamp timestamp = productQnaDTO.getReg();
		    // SimpleDateFormat을 사용하여 포맷 지정
		    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		    // format 메서드를 사용하여 Timestamp를 문자열로 변환
		    String formattedDate = sdf.format(timestamp);	
%>
			<TR>
				<TD align="center"> <%=formattedDate %> </TD>
				<TD align="center"> <%=productQnaDTO.getCategory() %> </TD>
				<TD>
					<A href = "/project/views/product/productContent.jsp?product_num=<%=productDTO.getProduct_num() %>&pageNum=<%=pageNum %>&category_num=<%=productDTO.getCategory_num() %>">
							<%=productDTO.getProduct_name() %>
						</A> <br /><br />
					<DIV style="display:flex; align-items:center; float:left;">
<%			if(productQnaDTO.getSecret_yn().equals("y")){			
%>
						<IMG width="20px" height="20px" style="display:inline-block;margin:0 auto;" 
								src="/project/views/images/security.png"/>&nbsp; 
<%			}
%>												
						<A href = "/project/views/productQna/productQnaQuestion.jsp?num=<%=productQnaDTO.getProduct_qna_num()%>&pageNum=<%= pageNum%>">	
							<%=productQnaDTO.getTitle() %> &nbsp;
						</A>
<%			if(productQnaDTO.getImg()!=null){
%>			
						<IMG width="16px" height="16px" style="display:inline-block;margin:0 auto;" 
								src="/project/views/images/addfile.png"/>
<%			}
%>					
					</DIV>		
				</TD>
				<TD align="center">
<%			if(productQnaDTO.getAnswer() == null) {
%>					
					접수
<%			}else {
%>	
					답변완료
<%			}
%>
				</TD>
				<TD align="center">
					<BUTTON class="emphasis" onclick="window.open('/project/views/productQna/productQnaAnswerForm.jsp?num=<%=productQnaDTO.getProduct_qna_num()%>&pageNum=<%=pageNum %>')" <%= productQnaDTO.getAnswer() != null ? "disabled" : ""%>>답변하기</BUTTON>
				</TD>
			</TR>
<%		}
	}
%>
</TABLE>