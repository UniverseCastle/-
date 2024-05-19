<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.review.ReviewDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<%	
	int snum = (int)session.getAttribute("snum");
	String svendor = (String)session.getAttribute("svendor");
	String pageNum = request.getParameter("pageNum");
	int review_num = Integer.parseInt(request.getParameter("review_num"));
	
	int pageSize = 5;
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage-1)*pageSize+1;
	int endRow = currentPage*pageSize;
		
	ReviewDAO dao = ReviewDAO.getInstance();
	
	int result = dao.deletePro(review_num);
	
	int reviewCount = dao.countInPage(snum, startRow, endRow);
	
	int ad = 0;
	
	if(request.getParameter("ad")!=null){
		ad = Integer.parseInt(request.getParameter("ad"));
	}
	
	
	if(result == 1 && ad==0) {
		if(reviewCount==0){	//현재 페이지의 배송지 갯수가 0일 경우 이전 페이지로 넘어감
%>
		<SCRIPT>
			alert("리뷰가 삭제되었습니다.");
			window.location="/project/views/member/mypage/review.jsp?pageNum=<%=currentPage-1%>";
		</SCRIPT>
<%		}else {
%>
		<SCRIPT>
			alert("리뷰가 삭제되었습니다.");
			window.location="/project/views/member/mypage/review.jsp?pageNum=<%=currentPage%>";
		</SCRIPT>	
<%		}
%>
<%	}
	if(result == 1 && ad==1) {
%>
		<SCRIPT>
			alert("리뷰가 삭제되었습니다.");
			window.location="/project/views/review/list.jsp";
		</SCRIPT>
<%	}
%>