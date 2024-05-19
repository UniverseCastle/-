<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="project.bean.contact.QnaDAO"%>
<%@ page import="project.bean.contact.QnaDTO"%>
<link rel="stylesheet" href="/project/views/css/c_style.css">
<jsp:include page="../main/header.jsp"/>
<%
    int num = Integer.parseInt(request.getParameter("num"));
    String pageNum = request.getParameter("pageNum");
    
    // 게시글 정보 불러오기
    QnaDAO dao = QnaDAO.getInstance();
    QnaDTO dto = dao.content(num);
    
    int snum = 0;
    if(session.getAttribute("snum") != null ){
        snum = (int)session.getAttribute("snum");
    }
    String svendor="";
	if (session.getAttribute("svendor") != null) {
		svendor = (String)session.getAttribute("svendor");
	}
    
    
    if(snum == dto.getMember_num() && snum == 0) {%>
<div id="contents">
	<div class="sub_content">
		<div class="board_zone_sec">
			<div class="board_zone_tit">
				<h2>1:1 문의 비밀번호 입력</h2>
			</div>
			<div class=board_zone_cont>
				<div class="board_zone_view">
					<div class="board_view_tit">
						<strong>[<%=dto.getCategory() %>]&nbsp; <%=dto.getTitle() %></strong>					
					</div>
						<form method="post" action="qnaQuestionB.jsp?num=<%=num%>&pageNum=<%=pageNum%>">
				            <input type="hidden" name="num" value="<%=num%>">
				            <input type="hidden" name="pageNum" value="<%=pageNum%>">
				            <div class="board_write_box">
							<table class="board_write_table">
								<tr>
									<th scope="row">비밀번호</th>
									<td><input type="password" name="password"/></td>
								</tr>			
							</table>
					            <div class="btn_center_box">
									<button type="button" class="btn_before" onclick="history.back()">
									<strong>이전</strong>
									</button>
						            <button type="submit" class="btn_write_ok" value="확인">
									<strong>확인</strong>
									</button>
								</div>
							</div>
				        </form>
				</div>
			</div>
		</div>
	</div>
</div>
        
    <% } else if(snum == dto.getMember_num() || svendor.equals("3")) { %>
<div id="contents">
	<div class="sub_content">
		<div class="board_zone_sec">
			<div class="board_zone_tit">
				<h2>1:1 문의</h2>
			</div>
			<div class=board_zone_cont>
				<div class="board_zone_view">
					<div class="board_view_tit">
						<strong>[<%=dto.getCategory() %>]&nbsp; <%=dto.getTitle() %></strong>					
					</div>
					<div class="board_view_info">
						<span class="view_info_id">						
<%							if(dto.getMember_num()==0){%>
								<strong><%=dto.getWriter() %></strong>
<%							}else{ %>
								<strong><%=dto.getName()%></strong>
<%							} %>
						</span>
						<span class="view_info_day">
							<%=dto.getReg() %>
						</span>
						<span class="view_info_hits">
							조회수 : <%=dto.getReadCount() %>
						</span>
					</div>
					<div class="board_view_content">
						<div class="view_goods_select"></div>
						<div class="board_view_qa">
							<%-- 질문창 --%>
							<div class="view_question_box">
								<strong class="view_question_tit">Q.</strong>
								<div class="seem_cont">
									<div style="margin: 10px 0 10px 0">
										<p><%=dto.getQuestion() %></p>
											<%	if(dto.getImg() !=null){%>
											<img src="/project/views/upload/<%=dto.getImg() %>"/>
											<%	}%>
									</div>
								</div>
							</div>
							<%-- 답변창 --%>
							<%
							if(dto.getAnswer()!=null){%>
							<div class="view_answer_box">
								<strong class="view_answer_tit">A.</strong>
									<div class="view_answer_info">
										<strong>답변입니다.</strong>
										<span class="view_info_id">관리자</span>
										<span class="view_info_day"><%=dto.getReg_answer() %></span>
									</div>
									<div class="seem_cont">
										<div style="margin: 10px 0 10px 0">
											<p><%=dto.getAnswer() %></p>
										</div>
									</div>
							</div>
							<%} %>
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
				<div class="btn_center_box">
					<button type="button"class="btn_before" onclick="window.location='qnaList.jsp?pageNum=<%=pageNum%>'">
						<strong>이전</strong>
					</button>
					<%if(!svendor.equals("3")){%>
					<button type="submit" class="btn_write_ok" onclick="window.location='qnaUpdateForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
						<strong>수정</strong>
					</button>
<%					} %>
<%					if(svendor.equals("3")){%>
					<button class="btn_comment" onclick="window.location='qnaAnswerForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
						<strong>답글</strong>
					</button>
<%					} %>
					<button class="btn_update" onclick="window.location='qnaDeleteForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
						<strong>삭제</strong>
					</button >
				</div>
<%}else { %>
        <script>
            alert("본인이 작성한 글만 열람할 수 있습니다.");
            history.go(-1);
        </script>
        <%}%>