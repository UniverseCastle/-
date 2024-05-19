package project.bean.cart;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import project.bean.orders.OrdersDTO;
import project.bean.product.ProductDTO;

public class CartDAO {
	private static CartDAO instance = new CartDAO();
	public static CartDAO getInstance() {
		return instance;
	}
	private CartDAO() {}
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String sql;
	
	private Connection getConn() throws Exception {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
			String user = "project1";
			String pw = "tiger";
			conn = DriverManager.getConnection(dburl, user, pw);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		try {if (conn != null) 	{conn.close();}	} catch (SQLException e) {e.printStackTrace();}
		try {if (pstmt != null) {pstmt.close();}} catch (SQLException e) {e.printStackTrace();}
		try {if (rs != null) 	{rs.close();}	} catch (SQLException e) {e.printStackTrace();}
	}
	
//	장바구니 select
	public CartDTO cartSelect(int product_num, int member_num) {	// 장바구니에 set 하기 위해 사용
		CartDTO dto = new CartDTO();
		try {
			conn = getConn();
			sql = "select * from cart where product_num=? and member_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_num);
			pstmt.setInt(2, member_num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setCart_num(rs.getInt("cart_num"));
				dto.setProduct_num(rs.getInt("product_num"));
				dto.setMember_num(rs.getInt("member_num"));
				dto.setProduct_count(rs.getInt("product_count"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return dto;
	}
	
//	장바구니에 추가
//	수정) 이미 등록된 상품이라면, 개수 합치고 업데이트
	public int cartInsert(CartDTO cartDto, int product_num, int member_num, int p_count) {
		int result = 0;
		int count = 0;
		try {
			conn = getConn();
			if (cartDto.getProduct_count() != 0) {
				count = cartDto.getProduct_count() + p_count;	// 원래있던 상품 개수와 입력받은 개수를 합침
				sql = "update cart set product_count=? where ?>product_count and product_num=? and member_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, count);		// set 하겠다.
				pstmt.setInt(2, count);		// 기존 개수보다 값이 크다면,
				pstmt.setInt(3, product_num);
				pstmt.setInt(4, member_num);
				result = pstmt.executeUpdate();
				System.out.println(cartDto.getProduct_count());
			}else {
				count = p_count;
				sql = "insert into cart values(cart_seq.NEXTVAL, ?, ?, ?, systimestamp)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, member_num);
				pstmt.setInt(2, product_num);
				pstmt.setInt(3, p_count);
				result = pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
//	장바구니 리스트 (snum 에 대한 장바구니 리스트 + 삭제여부(상품이 삭제돼서 장바구니에서 빠지면 안됨 / 수정)if 걸어서 따로 표시해야함) + 장바구니추가날짜 내림차순)
//	수정) 장바구니에 상품 개수가 이미 값이 있다면 상품 추가한 개수만큼 + 해주기		-완-
//	수정) 삭제된 제품이면 따로 표시해주기
	public ArrayList<CartDTO> cartList(int member_num) {
		ArrayList<CartDTO> list = new ArrayList<CartDTO>();
		try {
			conn = getConn();
			sql = "select C.*, M.member_num, P.product_num from cart C left outer join member M on C.member_num = M.member_num left outer join product P on C.product_num = P.product_num where M.member_num = ? order by C.cart_reg desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				CartDTO dto = new CartDTO();
				dto.setCart_num(rs.getInt("cart_num"));
				dto.setMember_num(rs.getInt("member_num"));
				dto.setProduct_num(rs.getInt("product_num"));
				dto.setProduct_count(rs.getInt("product_count"));
				dto.setCart_reg(rs.getTimestamp("cart_reg"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
//	체크박스 선택 삭제 메서드
	public void deleteCart(int product_num) {
		try {
			conn = getConn();
			sql = "delete from cart where product_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
	}
	
//	이동시키고 구매 완료 되면 장바구니에서 삭제해야함
	public void cartOrders() {
		try {
			conn = getConn();
			sql = "";
			pstmt = conn.prepareStatement(sql);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
	}
	
	

	
}