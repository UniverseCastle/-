<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.contact.ProductQnaDAO" %>
<%@ page import="project.bean.contact.ProductQnaDTO" %>
<link rel="stylesheet" href="/project/views/css/c_style.css">
<jsp:include page="../main/header.jsp"/>
<%
	int snum=0;
	if(session.getAttribute("snum") != null ){
		snum = (int)session.getAttribute("snum");
	}
	 
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	String svendor="";
	if (session.getAttribute("svendor") != null) {
		svendor = (String)session.getAttribute("svendor");
	}
	
	ProductQnaDAO dao = ProductQnaDAO.getInstance();
	ProductQnaDTO dto = dao.content(num);
	int product_num = dao.getSellerProductNum(num);
	boolean result = dao.isReal(snum, product_num);
	System.out.println(result);
	if(dto.getSecret_yn().equals("y") && result
		|| dto.getSecret_yn().equals("n") || svendor.equals("3") || snum == dto.getMember_num()){
			
	 %>
<div id="contents">
	<div class="sub_content">
		<div class="board_zone_sec">
			<div class="board_zone_tit">
				<h2>상품문의</h2>
			</div>
			<div class=board_zone_cont>
				<div class="board_zone_view">
					<div class="board_view_tit">
						<strong>[<%=dto.getCategory()%>]&nbsp;<%=dto.getTitle() %></strong>					
					</div>
					<div class="board_view_info">
						<span class="view_info_id">						
							<strong><%=dto.getMember_name() %></strong>
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
									<a href="../product/productContent.jsp?product_num=<%=dto.getProduct_num()%>&pageNum=<%=pageNum%>&category_num=<%=dto.getCatetgory_num()%>"><img src="../upload/<%=dto.getImg_name()%>" width="50" height="50"/></a>
									<h3><%=dto.getProduct_name() %></h3>
							<%-- 질문창 --%>
							<div class="view_question_box">
								<strong class="view_question_tit">Q.</strong>
								<div class="seem_cont">
									<div style="margin: 10px 0 10px 0">
										<p><%=dto.getQuestion() %></p>
											<%	if(dto.getImg() != null){%>
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
										<span class="view_info_id"></span>
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
               <button class="btn_before" onclick="history.back()">
                  <strong>이전</strong>
               </button>
            <% if(svendor.equals("1")){%>   
               <button type="submit" class="btn_write_ok" onclick="window.location='productQnaUpdateForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
                  <strong>수정</strong>
               </button>
            <%} %>   
            <% if(svendor.equals("2")){%>
               <button class="btn_comment" onclick="window.location='productQnaAnswerForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
                  <strong>답글</strong>
               </button>
            <%} %>
               <button class="btn_update" onclick="window.location='productQnaDeleteForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'">
                  <strong>삭제</strong>
               </button >
            </div>

				
<%		}else{ %>
		<script>
			alert("본인이 작성한 글만 열람할 수 있습니다.");
			history.go(-1);
		</script>
<% 		}%>