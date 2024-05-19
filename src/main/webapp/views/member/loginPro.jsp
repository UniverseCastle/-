<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.member.MemberDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:include page="/views/member/memberHeader.jsp" />

<jsp:useBean id="dto" class="project.bean.member.MemberDTO" />
<jsp:setProperty name="dto" property="*" />

<%
	MemberDAO dao = MemberDAO.getInstance();
	boolean result = dao.loginCheck(dto);
	int memberNum = dto.getMember_num();
	
	
	if(dto.getSave_id()!=null && dto.getSave_id().equals("1")) {
		Cookie coo = new Cookie ("cid", dto.getId());
		coo.setMaxAge(60*60*24*2);
		coo.setPath("/");
		response.addCookie(coo);
	}
	
	if(result==true) {
		if(dto.getVendor().equals("0")) {	//미승인 회원
%>
			<SCRIPT>
				alert("가입 승인이 필요합니다.");
				window.location="loginForm.jsp"
			</SCRIPT>
			
<%		}else if(dto.getVendor().equals("4")) {	//가입이 거절된 경우
%>
			<SCRIPT>
				alert("가입이 거절되셨습니다.");
				var confirmation = confirm("가입 신청을 다시 하시겠습니까");
				
				if(confirmation) {
					var memberNum = '<%= memberNum %>';
					window.location = "reapply.jsp?member_num="+memberNum;
				}else {
					alert("가입 신청이 취소되었습니다.");
					window.location = "loginForm.jsp"
				}	
			</SCRIPT>
				
<%		}else {
			session.setAttribute("sid", dto.getId());
			session.setAttribute("snum", dto.getMember_num());
			session.setAttribute("svendor", dto.getVendor());
%>
			<SCRIPT>
				alert("로그인 되셨습니다.");
				window.location="../main/introMain.jsp"
			</SCRIPT>
<% 		}
	}else {
%>	
		<SCRIPT>
			alert("아이디와 비밀번호를 확인해 주세요.");
			history.go(-1);
		</SCRIPT>		
<%	}
%>