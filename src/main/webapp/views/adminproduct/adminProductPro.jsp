<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% 
	int result = (int)request.getAttribute("result");
	int totalStatus = (int)request.getAttribute("totalStatus");
	System.out.println("result"+result);
	System.out.println("totalStatus"+totalStatus);
	if(result == 1 && totalStatus == 1){%>
		<script>
			alert("수정되었습니다");
			location.href="/project/views/adminproduct/allProductList.jsp";
		</script>	
<%	}else{%>
	<script>
		alert("수정에 실패하였습니다. ");
		location.href="/project/views/adminproduct/allProductList.jsp";
	</script>	
	
<%	}
%>
