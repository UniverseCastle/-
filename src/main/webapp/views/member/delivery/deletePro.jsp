<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.delivery.DeliveryDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<%	
	int snum = (int)session.getAttribute("snum");
	String svendor = (String)session.getAttribute("svendor");
	String pageNum = request.getParameter("pageNum");
	int delivery_num = Integer.parseInt(request.getParameter("delivery_num"));
	
	int pageSize = 5;
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage-1)*pageSize+1;
	int endRow = currentPage*pageSize;
		
	DeliveryDAO dao = DeliveryDAO.getInstance();
	
	int result = dao.deletePro(delivery_num);
	
	int deliveryCount = dao.countInPage(snum, startRow, endRow);
	
	
	if(result == 1) {
		if(deliveryCount==0){	//현재 페이지의 배송지 갯수가 0일 경우 이전 페이지로 넘어감
%>
		<SCRIPT>
			alert("배송지가 삭제되었습니다.");
			window.location="list.jsp?pageNum=<%=currentPage-1%>";
		</SCRIPT>
<%		}else {
%>
		<SCRIPT>
			alert("배송지가 삭제되었습니다.");
			window.location="list.jsp?pageNum=<%=currentPage%>";
		</SCRIPT>	
<%		}
	}
%>