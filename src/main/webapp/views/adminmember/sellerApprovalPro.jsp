<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.admin.AdminDAO"%>
<%
	AdminDAO dao = AdminDAO.getInstance();
	int result = 0;
	
	if(request.getParameter("member_num")!=null){
		int	member_num = Integer.parseInt(request.getParameter("member_num"));
		String vendor = request.getParameter("vendor");
		result = dao.changeVendor(vendor, member_num);
	}else{%>
		<script>
			alert("회원 시퀀스가 없습니다 코드 확인 요망");
			location.href="sellerJoinList.jsp";
		</script>	
<%	}
	
	if(result == 1){%>
		<script>
			alert("해당 회원의 판매자 가입이 승인 되었습니다.");
			location.href="sellerJoinList.jsp";
		</script>	
<%	}else{%>
		<script>
			alert("판매자 가입승인 실패");
			location.href="sellerJoinList.jsp";
		</script>	
<%	}
	
%>