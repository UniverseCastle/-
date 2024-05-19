package project.bean.review;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import project.bean.img.ImgDTO;
import project.bean.product.ProductDTO;

public class ReviewDAO {
	private static ReviewDAO instance = new ReviewDAO();
	public static ReviewDAO getInstance() {
		return instance;
	}
	private ReviewDAO() {};
	
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
	
	//리뷰 등록
	public int writePro(ReviewDTO dto) {
		int result = 0;
		try {
			conn = getConn();
			sql = "insert into review values(review_seq.nextval, ?, ?, ?, ?, ?, sysdate, 'N')";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getMember_num());
			pstmt.setInt(2, dto.getProduct_num());
			pstmt.setString(3, dto.getRating());
			pstmt.setString(4, dto.getContent());
			pstmt.setString(5, dto.getImg());
			result = pstmt.executeUpdate();
		
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//이 제품의 구매자인지 체크
	public boolean checkBuyer (int member_num, int product_num) {
		boolean result = false;
		try {
			conn = getConn();
			sql = "select * from orders where member_num = ? and product_num = ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, member_num);
			pstmt.setInt(2, product_num);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = true;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//리뷰 갯수
	public int count() {
		int result = 0;
		try {
			conn = getConn();
			sql = "select count(*) from review where delete_yn='N'";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch (Exception e){
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//리뷰 목록
	public ArrayList<ReviewWrapper> list (int start, int end) {
		ArrayList<ReviewWrapper> list = new ArrayList<ReviewWrapper>();
		try {
			conn = getConn();
			sql = "select * from (select p.*, rownum r from (select R.review_num, R.reg, R.rating, R.img, R.content, P.*, I.img_name from review R left outer join product P on R.product_num=P.product_num left outer join img I on R.product_num=I.product_num where I.img_type='thumbnail' and R.delete_yn='N' order by R.reg desc)p) where r between ? and ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReviewDTO reviewDTO = new ReviewDTO();
				ProductDTO productDTO = new ProductDTO();
				ImgDTO imgDTO = new ImgDTO();
				imgDTO.setImg_name(rs.getString("img_name"));
				productDTO.setProduct_num(rs.getInt("product_num"));
				productDTO.setCategory_num(rs.getInt("category_num"));
				reviewDTO.setReg(rs.getTimestamp("reg"));
				reviewDTO.setRating(rs.getString("rating"));
				reviewDTO.setReview_num(rs.getInt("review_num"));
				productDTO.setProduct_name(rs.getString("product_name"));
				reviewDTO.setImg(rs.getString("img"));
				reviewDTO.setContent(rs.getString("content"));
				
				ReviewWrapper wrapper = new ReviewWrapper(reviewDTO, productDTO, imgDTO);
				list.add(wrapper);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	// 리뷰 수정 form
	public ArrayList<ReviewWrapper> updateForm (int review_num) {
		ArrayList<ReviewWrapper> list = new ArrayList<ReviewWrapper>();
		try {
			conn = getConn();
			sql = "select R.*, P.product_name, I.img_name from review R left outer join product P on R.product_num=P.product_num left outer join img I on R.product_num=I.product_num where I.img_type='thumbnail' and R.delete_yn='N' and R.review_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, review_num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReviewDTO reviewDTO = new ReviewDTO();
				ProductDTO productDTO = new ProductDTO();
				ImgDTO imgDTO = new ImgDTO();
				imgDTO.setImg_name(rs.getString("img_name"));
				reviewDTO.setProduct_num(rs.getInt("product_num"));
				reviewDTO.setReg(rs.getTimestamp("reg"));
				reviewDTO.setRating(rs.getString("rating"));
				productDTO.setProduct_name(rs.getString("product_name"));
				reviewDTO.setImg(rs.getString("img"));
				reviewDTO.setContent(rs.getString("content"));
					
				ReviewWrapper wrapper = new ReviewWrapper(reviewDTO, productDTO, imgDTO);
				list.add(wrapper);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	//리뷰 수정 pro
	public int updatePro (ReviewDTO dto) {
		int result = 0;
		try {
			conn = getConn();
			sql = "update review set rating=?, content=?, img=? where review_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getRating());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getImg());
			pstmt.setInt(4, dto.getReview_num());
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace(); 
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//리뷰 삭제
	public int deletePro (int review_num) {
		int result = 0;
		try {
			conn = getConn();
			sql = "update review set delete_yn='Y' where review_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, review_num);
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//현재 페이지에 있는 리뷰 갯수
	public int countInPage (int member_num, int start, int end) {
		int result = 0;
		try {
			conn = getConn();
			sql = "select count(*) from (select p.*, rownum r from (select * from review where delete_yn='N' and member_num=?)p) where r between ? and ?";;
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
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
	
//	-----------------universe's made----------------------
	
	public List<ReviewDTO> reviewList(int product_num){
		List<ReviewDTO> list = new ArrayList<ReviewDTO> ();
		try {
			conn = getConn();
			sql = "select * from (select b.*, rownum r from (select * from review where product_num=? order by reg desc) b) where  r<=5";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReviewDTO dto = new ReviewDTO();
				dto.setRating(rs.getString("rating"));
				dto.setContent(rs.getString("content"));
				dto.setReg(rs.getTimestamp("reg"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
}


