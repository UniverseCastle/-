<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "project.bean.contact.NoticeDAO"%>
<jsp:useBean id="dto" class="project.bean.contact.NoticeDTO"/>
<jsp:setProperty property="*" name="dto"/>
<%
	String pageNum = request.getParameter("pageNum");
	int num = Integer.parseInt(request.getParameter("num"));
	NoticeDAO dao = NoticeDAO.getInstance();
	dto.setNotice_num(num);
	int result = dao.noticeUpdatePro(dto);
	
	if(dto.getFix_yn()==null){%>
		<script>
			alert("고정글 여부를 확인해주세요.");
			history.go(-1);
		</script>
<%	}else if(result == 1){%>
	<script>
		alert("수정이 완료되었습니다.");
		window.location="noticeList.jsp?pageNum=<%=pageNum%>";
	</script>	
<%	}else{ %>
	<script>
		alert("수정이 실패했습니다.");
		history.go(-1);
	</script>
<%	} %>
