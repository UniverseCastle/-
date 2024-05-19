package project.bean.mypage;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import project.bean.img.ImgDTO;
import project.bean.member.MemberDTO;
import project.bean.product.ProductDTO;
import project.bean.review.ReviewDTO;
import project.bean.review.ReviewWrapper;
import project.bean.orders.OrdersDTO;
import project.bean.contact.QnaDTO;
import project.bean.contact.ProductQnaDTO;
import project.bean.contact.VendorQnaDTO;

public class MypageDAO {
	private static MypageDAO instance = new MypageDAO();
	public static MypageDAO getInstance () {
		return instance;
	}
	private MypageDAO() {};
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String sql;
	
	private Connection getConn() throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		String user = "project1";
		String password = "tiger";
		conn = DriverManager.getConnection(url, user, password);
		return conn;
	}
	private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		try {
			if(conn!=null) {
				conn.close();
			}
		}catch(SQLException s){}
		try {
			if(pstmt!=null) {
				pstmt.close();
			}
		}catch(SQLException s) {}
		try {
			if(rs!=null) {
				rs.close();
			}
		}catch(SQLException s) {}
	}
	
	//회원 등급 및 회원 이름
	public MemberDTO grade_name (int member_num) {
		MemberDTO dto = new MemberDTO();
		try {
			conn = getConn();
			sql = "select grade, name from member where member_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setGrade(rs.getString("grade"));
				dto.setName(rs.getString("name"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return dto;
	}
	
	//30일 간 판매물품 등록 갯수
	public int reg_count_main (int member_num) {
		int result = 0;
		try {
			conn = getConn();
			sql="select count(*) from product where delete_yn='N' and status='1' and member_num=? and trunc(modified_date) >= trunc(sysdate) - 30";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//30일 간 판매물품 등록 현황
	public ArrayList<MypageWrapper> registration_main (int member_num, int start, int end) {
		ArrayList<MypageWrapper>list = new ArrayList<MypageWrapper>();
		try {
			conn = getConn();
			sql = "select * from (select p.*, rownum r from (select P.*,I.img_name from product P left outer join img I on P.product_num = I.product_num where P.delete_yn='N' and P.status='1' and I.img_type='thumbnail' and P.member_num=? and trunc(P.modified_date) >= trunc(sysdate) - 30 order by P.modified_date desc) p) where r between ? and ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductDTO productDTO = new ProductDTO();
				ImgDTO imgDTO = new ImgDTO();
				productDTO.setModified_date(rs.getTimestamp("modified_date"));
				productDTO.setProduct_num(rs.getInt("product_num"));
				productDTO.setProduct_name(rs.getString("product_name"));
				imgDTO.setImg_name(rs.getString("img_name"));
				productDTO.setPrice(rs.getInt("price"));
				productDTO.setStock(rs.getInt("stock"));
				productDTO.setCategory_num(rs.getInt("category_num"));
				productDTO.setStatus("status");
				MypageWrapper wrapper = new MypageWrapper(productDTO, imgDTO);
				list.add(wrapper);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	//정해진 기간 판매물품 등록 갯수
	public int reg_count(int member_num, String start, String end) {
		int result = 0;
		try {
			conn = getConn();
			sql="select count(*) from product where delete_yn='N' and member_num=? and trunc(modified_date) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD')";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//정해진 기간 판매물품 등록 현황
	public ArrayList<MypageWrapper> registration (int member_num, String start, String end) {
		ArrayList<MypageWrapper>list = new ArrayList<MypageWrapper>();
		try {
			conn = getConn();
			sql = "select P.*,I.img_name from product P left outer join img I on P.product_num = I.product_num where P.delete_yn='N' and I.img_type='thumbnail' and P.member_num = ? and trunc(P.modified_date) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD') order by P.modified_date desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductDTO productDTO = new ProductDTO();
				ImgDTO imgDTO = new ImgDTO();
				productDTO.setModified_date(rs.getTimestamp("modified_date"));
				productDTO.setProduct_num(rs.getInt("product_num"));
				productDTO.setProduct_name(rs.getString("product_name"));
				imgDTO.setImg_name(rs.getString("img_name"));
				productDTO.setPrice(rs.getInt("price"));
				productDTO.setStock(rs.getInt("stock"));
				productDTO.setCategory_num(rs.getInt("category_num"));
				productDTO.setStatus(rs.getString("status"));
				MypageWrapper wrapper = new MypageWrapper(productDTO, imgDTO);
				list.add(wrapper);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	//승인거절 상품 재신청
	public int registrationApproval (int product_num) {
		int result = 0;
		try {
			conn = getConn();
			sql = "update product set status='0' where product_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_num);
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//정해진 기간 판매 승인된 제품 갯수
	public int sales_count (int member_num, String start, String end) {
		int result = 0;
		try {
			conn = getConn();
			sql = "select count(*) from product where delete_yn='N' and status = '1' and member_num=? and trunc(modified_date) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD')";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//정해진 기간 판매매출 현황
	public ArrayList<MypageWrapper> sales (int member_num, String start, String end) {
		ArrayList<MypageWrapper>list = new ArrayList<MypageWrapper>();
		try {
			conn = getConn();
			sql = "select P.*, I.img_name from product P left outer join img I on P.product_num = I.product_num where I.img_type='thumbnail' and P.status = '1' and P.member_num=? and trunc(P.modified_date) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD') order by P.modified_date desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductDTO productDTO = new ProductDTO();
				ImgDTO imgDTO = new ImgDTO();
				productDTO.setModified_date(rs.getTimestamp("modified_date"));
				productDTO.setProduct_num(rs.getInt("product_num"));
				productDTO.setProduct_name(rs.getString("product_name"));
				imgDTO.setImg_name(rs.getString("img_name"));
				productDTO.setPrice(rs.getInt("price"));
				productDTO.setFirst_stock(rs.getInt("first_stock"));
				productDTO.setStock(rs.getInt("stock"));
				productDTO.setCategory_num(rs.getInt("category_num"));
				MypageWrapper wrapper = new MypageWrapper(productDTO, imgDTO);
				list.add(wrapper);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		
		return list;
	}
	
	//판매 주문 갯수
	public int wholeSales_count(int member_num) {
		int result = 0;
		try {
			conn = getConn();
			sql="select count(*) from orders O left outer join product P on O.product_num = P.product_num where O.orders_status='1' and P.member_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//전체 판매 현황
	public ArrayList<MypageWrapper> wholeSales (int member_num, int start, int end) {
		ArrayList<MypageWrapper>list = new ArrayList<MypageWrapper>();
		try {
			conn = getConn();
			sql = "select * from (select p.*, rownum r from (select I.img_name, O.count, M.id, P.* from orders O left outer join product P on O.product_num = P.product_num left outer join member M on O.member_num = M.member_num left outer join img I on O.product_num = I.product_num where I.img_type='thumbnail' and O.orders_status='1'and P.member_num = ? order by P.modified_date desc)p) where r between ? and ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ImgDTO imgDTO = new ImgDTO();
				ProductDTO productDTO = new ProductDTO();
				OrdersDTO ordersDTO = new OrdersDTO();
				MemberDTO memberDTO = new MemberDTO();
				productDTO.setProduct_num(rs.getInt("product_num"));
				productDTO.setProduct_name(rs.getString("product_name"));
				productDTO.setPrice(rs.getInt("price"));
				ordersDTO.setCount(rs.getInt("count"));
				memberDTO.setId(rs.getString("id"));
				productDTO.setCategory_num(rs.getInt("category_num"));
				imgDTO.setImg_name(rs.getString("img_name"));
				MypageWrapper wrapper = new MypageWrapper(imgDTO, memberDTO, productDTO, ordersDTO);
				list.add(wrapper);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	//30일 간 주문 갯수
	public int orders_count_main(int member_num) {
		int result = 0;
		try {
			conn = getConn();
			sql = "select count(*) from orders where orders_status!='2' and member_num=? and trunc(orders_date) >= trunc(sysdate) - 30";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}

	//30일 간 주문/배송현황
	public ArrayList<MypageWrapper> orders_main (int member_num, int start, int end) {
		ArrayList<MypageWrapper>list = new ArrayList<MypageWrapper>();
		try {
			conn = getConn();
			sql = "select * from (select p.*, rownum r from (select O.orders_date, O.orders_num, O.count, O.delivery_status, P.*, I.img_name from orders O left outer join product P on O.product_num= P.product_num left outer join img I on O.product_num = I.product_num where I.img_type='thumbnail' and O.orders_status!='2' and O.member_num=? and trunc(O.orders_date) >= trunc(sysdate) - 30 order by O.orders_date desc)p) where r between ? and ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrdersDTO ordersDTO = new OrdersDTO();
				ImgDTO imgDTO = new ImgDTO();
				ProductDTO productDTO = new ProductDTO();
				ordersDTO.setOrders_date(rs.getTimestamp("orders_date"));
				ordersDTO.setOrders_num(rs.getInt("orders_num"));
				productDTO.setProduct_num(rs.getInt("product_num"));
				imgDTO.setImg_name(rs.getString("img_name"));
				productDTO.setProduct_name(rs.getString("product_name"));
				productDTO.setPrice(rs.getInt("price"));
				ordersDTO.setCount(rs.getInt("count"));
				ordersDTO.setDelivery_status(rs.getString("delivery_status"));
				productDTO.setCategory_num(rs.getInt("category_num"));
				MypageWrapper wrapper = new MypageWrapper(ordersDTO, productDTO, imgDTO);
				list.add(wrapper);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	//정해진 기간 주문 갯수
	public int orders_count(int member_num, String start, String end) {
		int result = 0;
		try {
			conn = getConn();
			sql = "select count(*) from orders where orders_status!='2' and member_num=? and trunc(orders_date) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD')";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//정해진 기간 주문/배송 현황
	public ArrayList<MypageWrapper> orders (int member_num, String start, String end) {
		ArrayList<MypageWrapper>list = new ArrayList<MypageWrapper>();
		try {
			conn = getConn();
			sql = "select O.*, P.*, I.img_name from orders O left outer join product P on O.product_num = P.product_num left outer join img I on O.product_num = I.product_num where I.img_type='thumbnail' and orders_status!='2' and O.member_num=? and trunc(O.orders_date) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD') order by O.orders_date desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrdersDTO ordersDTO = new OrdersDTO();
				ImgDTO imgDTO = new ImgDTO();
				ProductDTO productDTO = new ProductDTO();
				ordersDTO.setOrders_date(rs.getTimestamp("orders_date"));
				ordersDTO.setOrders_num(rs.getInt("orders_num"));
				productDTO.setProduct_num(rs.getInt("product_num"));
				imgDTO.setImg_name(rs.getString("img_name"));
				productDTO.setProduct_name(rs.getString("product_name"));
				productDTO.setPrice(rs.getInt("price"));
				ordersDTO.setCount(rs.getInt("count"));
				ordersDTO.setDelivery_status(rs.getString("delivery_status"));
				ordersDTO.setRequest_status(rs.getString("request_status"));
				productDTO.setCategory_num(rs.getInt("category_num"));
				MypageWrapper wrapper = new MypageWrapper(ordersDTO, productDTO, imgDTO);
				list.add(wrapper);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	//취소신청
	public int cancellationPro (int[] selectedOrdersNums) {
		int result = 0;
		try {
			conn = getConn();
			for (int orders_num : selectedOrdersNums) {
				sql = "update orders set request_status='2' where orders_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, orders_num);
				result += pstmt.executeUpdate();
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}

	//반품신청
	public int returnPro (int[] selectedOrdersNums) {
		int result = 0;
		try {
			conn = getConn();
			for (int orders_num : selectedOrdersNums) {
				sql = "update orders set request_status='3' where orders_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, orders_num);
				result += pstmt.executeUpdate();
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}

	//교환신청
	public int exchangePro (int[] selectedOrdersNums) {
		int result = 0;
		try {
			conn = getConn();
			for (int orders_num : selectedOrdersNums) {
				sql = "update orders set request_status='4' where orders_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, orders_num);
				result += pstmt.executeUpdate();
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//정해진 기간 취소/반품/교환 신청 갯수
	public int cancellation_request_count (int member_num, String start, String end) {
		int result = 0;
		try {
			conn = getConn();
			sql="select count(*) from orders where member_num=? and request_status!='1' and trunc(orders_date) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD')";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//정해진 기간 취소/교환/환불 신청 내역
	public ArrayList<MypageWrapper> cancellation_request (int member_num, String start, String end) {
		ArrayList<MypageWrapper>list = new ArrayList<MypageWrapper>();
		try {
			conn = getConn();
			sql = "select O.*, P.*, I.img_name from orders O left outer join product P on O.product_num= P.product_num left outer join img I on O.product_num = I.product_num where I.img_type='thumbnail' and O.request_status!='1' and O.member_num=? and trunc(O.orders_date) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD') order by O.orders_date desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrdersDTO ordersDTO = new OrdersDTO();
				ImgDTO imgDTO = new ImgDTO();
				ProductDTO productDTO = new ProductDTO();
				ordersDTO.setOrders_date(rs.getTimestamp("orders_date"));
				ordersDTO.setOrders_num(rs.getInt("orders_num"));
				productDTO.setProduct_num(rs.getInt("product_num"));
				imgDTO.setImg_name(rs.getString("img_name"));
				productDTO.setProduct_name(rs.getString("product_name"));
				productDTO.setPrice(rs.getInt("price"));
				ordersDTO.setCount(rs.getInt("count"));
				ordersDTO.setRequest_status(rs.getString("request_status"));
				ordersDTO.setOrders_status(rs.getString("orders_status"));
				productDTO.setCategory_num(rs.getInt("category_num"));
				MypageWrapper wrapper = new MypageWrapper(ordersDTO, productDTO, imgDTO);
				list.add(wrapper);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}	
	
	//정해진 기간 취소/반품/교환 처리 갯수
	public int cancellation_count (int member_num, String start, String end) {
		int result = 0;
		try {
			conn = getConn();
			sql="select count(*) from orders where member_num=? and request_status!='1' and trunc(orders_date) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD')";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//정해진 기간 취소/교환/환불 처리 현황
	public ArrayList<MypageWrapper> cancellation (int member_num, String start, String end) {
		ArrayList<MypageWrapper>list = new ArrayList<MypageWrapper>();
		try {
			conn = getConn();
			sql = "select O.*, P.*, I.img_name from orders O left outer join product P on O.product_num= P.product_num left outer join img I on O.product_num = I.product_num where P.delete_yn='N' and I.img_type='thumbnail' and O.member_num=? and request_status!='1' and trunc(O.orders_date) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD') order by O.orders_date desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrdersDTO ordersDTO = new OrdersDTO();
				ImgDTO imgDTO = new ImgDTO();
				ProductDTO productDTO = new ProductDTO();
				ordersDTO.setOrders_date(rs.getTimestamp("orders_date"));
				ordersDTO.setOrders_num(rs.getInt("orders_num"));
				productDTO.setProduct_num(rs.getInt("product_num"));
				imgDTO.setImg_name(rs.getString("img_name"));
				productDTO.setProduct_name(rs.getString("product_name"));
				productDTO.setPrice(rs.getInt("price"));
				ordersDTO.setCount(rs.getInt("count"));
				ordersDTO.setRequest_status(rs.getString("request_status"));
				ordersDTO.setOrders_status(rs.getString("orders_status"));
				productDTO.setCategory_num(rs.getInt("category_num"));
				MypageWrapper wrapper = new MypageWrapper(ordersDTO, productDTO, imgDTO);
				list.add(wrapper);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}	
	
	//정해진 기간 취소/반품/교환 신청 갯수(판매자)
	public int approval_count (int member_num, String start, String end) {
		int result = 0;
		try {
			conn = getConn();
			sql="select count(*) from orders O left outer join product P on O.product_num = P.product_num where P.member_num=? and request_status!='1' and trunc(O.orders_date) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD')";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//정해진 기간 취소/반품/교환 처리 (판매자)
	public ArrayList<MypageWrapper> approval (int member_num, String start, String end) {
		ArrayList<MypageWrapper>list = new ArrayList<MypageWrapper>();
		try {
			conn = getConn();
			sql = "select O.*, P.*, I.img_name from orders O left outer join product P on O.product_num= P.product_num left outer join img I on O.product_num = I.product_num where I.img_type='thumbnail' and P.member_num=? and request_status!='1' and trunc(O.orders_date) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD') order by O.orders_date desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrdersDTO ordersDTO = new OrdersDTO();
				ImgDTO imgDTO = new ImgDTO();
				ProductDTO productDTO = new ProductDTO();
				ordersDTO.setOrders_date(rs.getTimestamp("orders_date"));
				ordersDTO.setOrders_num(rs.getInt("orders_num"));
				productDTO.setProduct_num(rs.getInt("product_num"));
				imgDTO.setImg_name(rs.getString("img_name"));
				productDTO.setProduct_name(rs.getString("product_name"));
				productDTO.setPrice(rs.getInt("price"));
				ordersDTO.setCount(rs.getInt("count"));
				ordersDTO.setRequest_status(rs.getString("request_status"));
				ordersDTO.setOrders_status(rs.getString("orders_status"));
				productDTO.setCategory_num(rs.getInt("category_num"));
				MypageWrapper wrapper = new MypageWrapper(ordersDTO, productDTO, imgDTO);
				list.add(wrapper);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}		
	
	//취소/반품/교환 승인
	public int approvalPro (int orders_num, int product_num) {
		int result = 0;
		try {
			conn = getConn();
			sql = "update orders set orders_status='2' where orders_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, orders_num);
			result = pstmt.executeUpdate();
			//취소/반품/교환 시 재고량 증가
			sql = "update product set stock	= stock+(select count from orders where orders_num=?) where product_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, orders_num);
			pstmt.setInt(2, product_num);
			pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//정해진 기간동안 1:1 문의 갯수
	public int qna_count (int member_num, String start, String end) {
		int result = 0;
		try {
			conn = getConn();
			sql = "select count(*) from qna where member_num=? and trunc(reg) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD')";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//정해진 기간동안 1:1 문의 내역
	public ArrayList<QnaDTO> qna (int member_num, String start, String end) {
		ArrayList<QnaDTO> list = new ArrayList<QnaDTO>();
		try {
			conn = getConn();
			sql = "select * from qna where member_num=? and trunc(reg) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD') order by reg desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				QnaDTO dto = new QnaDTO();
				dto.setQna_num(rs.getInt("qna_num"));
				dto.setCategory(rs.getString("category"));
				dto.setTitle(rs.getString("title"));
				dto.setImg(rs.getString("img"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setAnswer(rs.getString("answer"));
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	//정해진 기간동안 상품 문의 갯수
	public int product_qna_count (int member_num, String start, String end) {
		int result = 0;
		try {
			conn = getConn();
			sql = "select count(*) from product_qna where delete_yn ='n' and member_num=? and trunc(reg) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD')";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//정해진 기간동안 상품 문의 내역
	public ArrayList<MypageWrapper> product_qna (int member_num, String start, String end) {
		ArrayList<MypageWrapper> list = new ArrayList<MypageWrapper>();
		try {
			conn = getConn();
			sql = "select Q.*, P.* from product_qna Q left outer join product P on Q.product_num = P.product_num where Q.delete_yn='n' and Q.member_num=? and trunc(reg) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD') order by Q.reg desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ProductQnaDTO productQnaDTO = new ProductQnaDTO();
				ProductDTO productDTO = new ProductDTO();
				productQnaDTO.setProduct_qna_num(rs.getInt("product_qna_num"));
				productQnaDTO.setCategory(rs.getString("category"));
				productDTO.setProduct_num(rs.getInt("product_num"));
				productDTO.setCategory_num(rs.getInt("category_num"));
				productDTO.setProduct_name(rs.getString("product_name"));
				productQnaDTO.setTitle(rs.getString("title"));
				productQnaDTO.setSecret_yn(rs.getString("secret_yn"));
				productQnaDTO.setImg(rs.getString("img"));
				productQnaDTO.setReg(rs.getTimestamp("reg"));
				productQnaDTO.setAnswer(rs.getString("answer"));
				
				MypageWrapper wrapper = new MypageWrapper(productQnaDTO, productDTO);
				list.add(wrapper);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	//작성한 리뷰 갯수
	public int review_count (int member_num) {
		int result = 0;
		try {
			conn = getConn();
			sql = "select count(*) from review where delete_yn='N' and member_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//리뷰 목록
	public ArrayList<MypageWrapper> review (int member_num, int start, int end) {
		ArrayList<MypageWrapper> list = new ArrayList<MypageWrapper>();
		try {
			conn = getConn();
			sql = "select * from (select p.*, rownum r from (select R.review_num, R.reg, R.rating, R.img, R.content, P.*, I.img_name from review R left outer join product P on R.product_num=P.product_num left outer join img I on R.product_num=I.product_num where I.img_type='thumbnail' and R.delete_yn='N' and R.member_num=? order by R.reg desc)p) where r between ? and ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReviewDTO reviewDTO = new ReviewDTO();
				ProductDTO productDTO = new ProductDTO();
				ImgDTO imgDTO = new ImgDTO();
				reviewDTO.setReview_num(rs.getInt("review_num"));
				imgDTO.setImg_name(rs.getString("img_name"));
				productDTO.setProduct_num(rs.getInt("product_num"));
				productDTO.setCategory_num(rs.getInt("category_num"));
				reviewDTO.setReg(rs.getTimestamp("reg"));
				reviewDTO.setRating(rs.getString("rating"));
				productDTO.setProduct_name(rs.getString("product_name"));
				reviewDTO.setImg(rs.getString("img"));
				reviewDTO.setContent(rs.getString("content"));
				
				MypageWrapper wrapper = new MypageWrapper(reviewDTO, productDTO, imgDTO);
				list.add(wrapper);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}	
	
	//정해진 기간 동안 사업자 문의 갯수
	public int vendor_qna_count (int member_num, String start, String end) {
		int result = 0;
		try {
			conn = getConn();
			sql = "select count(*) from vendor_qna where delete_yn='n' and member_num=? and trunc(reg) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD')";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//정해진 기간 동안 사업자 문의 내역
	public ArrayList<VendorQnaDTO> vendor_qna (int member_num, String start, String end) {
		ArrayList<VendorQnaDTO> list = new ArrayList<VendorQnaDTO>();
		try {
			conn = getConn();
			sql = "select * from vendor_qna where delete_yn='n' and member_num=? and trunc(reg) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD') order by reg desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				VendorQnaDTO dto = new VendorQnaDTO();
				dto.setVendor_qna_num(rs.getInt("vendor_qna_num"));
				dto.setTitle(rs.getString("title"));
				dto.setSecret_yn(rs.getString("secret_yn"));
				dto.setImg(rs.getString("img"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setAnswer(rs.getString("answer"));
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	//정해진 기간동안 상품 문의 갯수 (판매자)
	public int product_qnaV_count (int member_num, String start, String end) {
		int result = 0;
		try {
			conn = getConn();
			sql = "select count(*) from product_qna Q left outer join product P on Q.product_num = P.product_num where Q.delete_yn='n' and P.member_num=? and trunc(reg) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD')";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//정해진 기간동안 상품 문의 내역 (판매자)
	public ArrayList<MypageWrapper> product_qnaV (int member_num, String start, String end) {
		ArrayList<MypageWrapper> list = new ArrayList<MypageWrapper>();
		try {
			conn = getConn();
			sql = "select Q.*, P.* from product_qna Q left outer join product P on Q.product_num = P.product_num where Q.delete_yn='n' and P.member_num=? and trunc(reg) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD') order by Q.reg desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ProductQnaDTO productQnaDTO = new ProductQnaDTO();
				ProductDTO productDTO = new ProductDTO();
				productQnaDTO.setProduct_qna_num(rs.getInt("product_qna_num"));
				productQnaDTO.setCategory(rs.getString("category"));
				productDTO.setProduct_num(rs.getInt("product_num"));
				productDTO.setCategory_num(rs.getInt("category_num"));
				productDTO.setProduct_name(rs.getString("product_name"));
				productQnaDTO.setTitle(rs.getString("title"));
				productQnaDTO.setSecret_yn(rs.getString("secret_yn"));
				productQnaDTO.setImg(rs.getString("img"));
				productQnaDTO.setReg(rs.getTimestamp("reg"));
				productQnaDTO.setAnswer(rs.getString("answer"));
				
				MypageWrapper wrapper = new MypageWrapper(productQnaDTO, productDTO);
				list.add(wrapper);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}	
}