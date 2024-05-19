package project.bean.orders;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import project.bean.cart.CartDAO;
import project.bean.img.ImgDTO;
import project.bean.product.ProductDAO;
import project.bean.product.ProductDTO;

public class OrdersDAO {
	private static OrdersDAO instance = new OrdersDAO();
	public static OrdersDAO getInstance() {
		return instance;
	}
	private OrdersDAO() {}
	
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
	
//	주문상품. 썸네일 1장 + 상품 목록 2개 join
	public ArrayList<ProductDTO> orderProduct(int product_num) {
		ArrayList<ProductDTO> list = new ArrayList<ProductDTO>();
		try {
			conn = getConn();
			sql = "select b.* from (select P.*, I.img_name, I.img_num from product P left outer join img I on P.product_num = I.product_num where P.delete_yn = 'N' and I.img_type = 'thumbnail' order by P.product_num desc) b where product_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ProductDTO dto = new ProductDTO();
				ImgDTO imgDto = new ImgDTO();
				dto.setProduct_num(rs.getInt("product_num"));
				dto.setCategory_num(rs.getInt("category_num"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setProduct_info(rs.getString("product_info"));
				dto.setPrice(rs.getInt("price"));
				dto.setDelivery_price(rs.getInt("delivery_price"));
				dto.setHas_delivery_fee(rs.getString("has_delivery_fee"));
				
				imgDto.setImg_name(rs.getString("img_name"));
				imgDto.setImg_num(rs.getInt("img_num"));
				
				List<ImgDTO> imgs = new ArrayList<ImgDTO>();
				imgs.add(imgDto);
				dto.setImages(imgs);
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	
//	주문상품 리스트
	public ArrayList<OrdersDTO> orderList(int product_num, int snum) {
		ArrayList<OrdersDTO> list = new ArrayList<OrdersDTO>();
		try {
			conn = getConn();
			sql = "select * from orders where product_num = ? and member_num = ? order by orders_date desc";
			pstmt = conn.prepareStatement(sql);		// 같은사람이 같은제품을 주문할 경우를 대비해 주문일자 내림차순 정렬
			pstmt.setInt(1, product_num);
			pstmt.setInt(2, snum);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				OrdersDTO dto = new OrdersDTO();
				dto.setCount(rs.getInt("count"));
				dto.setOrders_date(rs.getTimestamp("orders_date"));
				dto.setOrders_name(rs.getString("orders_name"));
				dto.setReceiver_name(rs.getString("receciver_name"));
				dto.setPhone(rs.getString("phone"));
				dto.setCellphone(rs.getString("cellphone"));
				dto.setEmail(rs.getString("email"));
				dto.setAddress1(rs.getString("address1"));
				dto.setAddress1(rs.getString("address2"));
				dto.setAddress1(rs.getString("address3"));
				dto.setFinal_price(rs.getInt("final_price"));
				dto.setPayment_option(rs.getString("payment_option"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
//	단일상품 구매
	public int orderInsert(OrdersDTO ordersDto, ProductDTO productDto)  {
		int result = 0;
		try {
			conn = getConn();
			sql = "insert into orders values(orders_seq.NEXTVAL, ?, ?, ?, ?, 1, 1, 1, ?, systimestamp, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ordersDto.getMember_num());
			pstmt.setInt(2, ordersDto.getProduct_num());
			pstmt.setInt(3, ordersDto.getDelivery_num());
			pstmt.setInt(4, ordersDto.getImg_num());
			pstmt.setInt(5, ordersDto.getCount());
			pstmt.setString(6, ordersDto.getOrders_name());
			pstmt.setString(7, ordersDto.getReceiver_name());
			pstmt.setString(8, ordersDto.getPhone());
			pstmt.setString(9, ordersDto.getCellphone());
			pstmt.setString(10, ordersDto.getEmail());
			pstmt.setString(11, ordersDto.getAddress1());
			pstmt.setString(12, ordersDto.getAddress2());
			pstmt.setString(13, ordersDto.getAddress3());
			pstmt.setInt(14, ordersDto.getFinal_price());
			pstmt.setString(15, ordersDto.getPayment_option());
			result = pstmt.executeUpdate();
			if (result > 0) {
				sql = "update product set stock=? where product_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, productDto.getStock() - ordersDto.getCount());
				pstmt.setInt(2, productDto.getProduct_num());
				pstmt.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
//	장바구니에서 선택한 상품들 구매
	public int orderInsertList(ArrayList<OrdersDTO> list)  {
		int result = 0;
		try {
			conn = getConn();
			sql = "insert into orders values(orders_seq.NEXTVAL, ?, ?, ?, ?, 1, 1, 1, ?, systimestamp, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			for(OrdersDTO ordersDto : list) {
				pstmt.setInt(1, ordersDto.getMember_num());
				pstmt.setInt(2, ordersDto.getProduct_num());
				pstmt.setInt(3, ordersDto.getDelivery_num());
				pstmt.setInt(4, ordersDto.getImg_num());
				pstmt.setInt(5, ordersDto.getCount());
				pstmt.setString(6, ordersDto.getOrders_name());
				pstmt.setString(7, ordersDto.getReceiver_name());
				pstmt.setString(8, ordersDto.getPhone());
				pstmt.setString(9, ordersDto.getCellphone());
				pstmt.setString(10, ordersDto.getEmail());
				pstmt.setString(11, ordersDto.getAddress1());
				pstmt.setString(12, ordersDto.getAddress2());
				pstmt.setString(13, ordersDto.getAddress3());
				pstmt.setInt(14, ordersDto.getFinal_price());
				pstmt.setString(15, ordersDto.getPayment_option());
				
				CartDAO cartDao = CartDAO.getInstance();
				cartDao.deleteCart(ordersDto.getProduct_num());
				
				pstmt.addBatch();
				
				sql = "update product set stock = stock - ? where product_num=?";
				
				PreparedStatement pstmt2 = conn.prepareStatement(sql);
				pstmt2.setInt(1, ordersDto.getCount());
				pstmt2.setInt(2, ordersDto.getProduct_num());
				pstmt2.executeUpdate();
			}
			result = pstmt.executeBatch().length;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	
}