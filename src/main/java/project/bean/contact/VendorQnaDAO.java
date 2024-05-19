package project.bean.contact;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class VendorQnaDAO {
	private static VendorQnaDAO instance = new VendorQnaDAO();
	public static VendorQnaDAO getInstance() {
		return instance;
	}
	private VendorQnaDAO() {}
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String sql;
	
	private Connection getConn() throws Exception{
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String url = "jdbc:oracle:thin:@192.168.0.10:1521:orcl";
			String pass = "tiger";
			String user = "project1";
			conn = DriverManager.getConnection(url, user, pass);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	private void close(Connection conn,PreparedStatement pstmt, ResultSet rs) {
		try {if (conn!=null){conn.close();}}catch(SQLException e) {e.printStackTrace();}
		try {if (pstmt!=null) {pstmt.close();}}catch(SQLException e) {e.printStackTrace();}
		try {if (rs!=null) {rs.close();}}catch(SQLException e) {e.printStackTrace();}
	}
	
	
	
	// 글작성
		public int vendorQnaWrite(VendorQnaDTO dto) {
			int result=0;
			try {
				conn = getConn();
				sql = "insert into vendor_qna values(vendor_qna_seq.NEXTVAL,?,?,?,?,?,?,sysdate,sysdate,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, dto.getMember_num());
				pstmt.setString(2, dto.getPassword());
				pstmt.setString(3, dto.getTitle());
				pstmt.setString(4, dto.getQuestion());
				pstmt.setString(5, dto.getAnswer());
				pstmt.setString(6, dto.getImg());
				pstmt.setInt(7, dto.getReadCount());
				pstmt.setString(8, dto.getSecret_yn());
				pstmt.setString(9, dto.getDelete_yn());
				result = pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(conn, pstmt, rs);
			}
			return result;
		}

	
	// 답글
		public int vendorAnswerWrite(VendorQnaDTO dto) {
			int result=0;
			sql = "update vendor_qna set answer=?, reg_answer=sysdate where vendor_qna_num=?";
			try {
				conn = getConn();
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getAnswer());
				pstmt.setInt(2, dto.getVendor_qna_num());
				result = pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(conn, pstmt, rs);
			}
			return result;
		}
		
		//글개수
		public int count() {
			int result=0;
			try {
				conn = getConn();
				sql = "select count(*) from vendor_qna";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getInt(1);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(conn, pstmt, rs);
			}
			return result;
		}
		
		
		//글목록
		public ArrayList<VendorQnaDTO> list(int start, int end){
			ArrayList<VendorQnaDTO> list = new ArrayList<VendorQnaDTO>();
			try {
				conn = getConn();
				sql = "SELECT *	FROM (SELECT v.*, m.vendor, m.business_name, ROW_NUMBER() OVER (ORDER BY v.vendor_qna_num DESC) AS r FROM vendor_qna v left outer JOIN member m ON v.member_num = m.member_num)WHERE r >= ? AND r <= ? and delete_yn= 'n'";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					VendorQnaDTO dto = new VendorQnaDTO();
					dto.setBusiness_name(rs.getString("business_name"));
					dto.setVendor(rs.getString("vendor"));
					dto.setMember_num(rs.getInt("member_num"));
					dto.setVendor_qna_num(rs.getInt("vendor_qna_num"));
					dto.setTitle(rs.getString("title"));
					dto.setReg(rs.getTimestamp("reg"));
					dto.setAnswer(rs.getString("answer"));
					dto.setSecret_yn(rs.getString("secret_yn"));
					dto.setDelete_yn(rs.getString("delete_yn"));
					list.add(dto);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(conn, pstmt, rs);
			}
			return list;
		}
	
	
		
		// 글 내용
		public VendorQnaDTO content(int num) {
			VendorQnaDTO dto = new VendorQnaDTO();
			try {
				conn=getConn();
				sql = "update vendor_qna set readcount=readcount+1 where vendor_qna_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
				
				sql = "SELECT vq.*, m.vendor, m.business_name \r\n"
						+ "FROM vendor_qna vq \r\n"
						+ "left outer JOIN member m ON vq.member_num = m.member_num \r\n"
						+ "WHERE vq.vendor_qna_num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					dto.setMember_num(rs.getInt("member_num"));
					dto.setVendor_qna_num(rs.getInt("vendor_qna_num"));
					dto.setImg(rs.getString("img"));
					dto.setTitle(rs.getString("title"));
					dto.setAnswer(rs.getString("answer"));
					dto.setReg(rs.getTimestamp("reg"));
					dto.setReadCount(rs.getInt("readcount"));
					dto.setReg_answer(rs.getTimestamp("reg_answer"));
					dto.setQuestion(rs.getString("question"));
					dto.setBusiness_name(rs.getString("business_name"));
					dto.setVendor(rs.getString("vendor"));
					dto.setSecret_yn(rs.getString("secret_yn"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(conn, pstmt, rs);
			}
			return dto;
		}
		
		// 글수정 form
		public VendorQnaDTO vendorQnaUpdateForm(int num) {
			VendorQnaDTO dto = new VendorQnaDTO();
			try {
				conn = getConn();
				sql = "select * from vendor_qna where vendor_qna_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					dto.setAnswer(rs.getString("answer"));
					dto.setTitle(rs.getString("title"));
					dto.setPassword(rs.getString("password"));
					dto.setQuestion(rs.getString("question"));
					dto.setSecret_yn(rs.getString("secret_yn"));
					dto.setReg(rs.getTimestamp("reg"));
					dto.setImg(rs.getString("img"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(conn, pstmt, rs);
			}
			return dto;
		}
		
		// 글수정 pro
		public int vendorQnaUpdatePro(VendorQnaDTO dto, int num) {
			int result=0;
			String dbpw="";
			try {
				conn = getConn();
				sql = "select password from vendor_qna where vendor_qna_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					dbpw = rs.getString("password");
					if(dbpw.equals(dto.getPassword())) {
						sql="update vendor_qna set title=?, question=?, img=?, secret_yn=?, reg=sysdate where vendor_qna_num=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, dto.getTitle());
						pstmt.setString(2, dto.getQuestion());
						pstmt.setString(3, dto.getImg());
						pstmt.setString(4, dto.getSecret_yn());
						pstmt.setInt(5, dto.getVendor_qna_num());
						result = pstmt.executeUpdate();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(conn, pstmt, rs);
			}
			return result;
		}
		
		// 글삭제
		public int qnaDelete(int num,String password) {
			int result=0;
			String dbpw = "";
			try {
				conn = getConn();
				pstmt = conn.prepareStatement("select password from vendor_qna where vendor_qna_num=?");
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					dbpw = rs.getString("password");
					if(dbpw.equals(password)) {
						sql = "update vendor_qna set delete_yn = 'y' where vendor_qna_num=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setInt(1, num);
						result=pstmt.executeUpdate();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(conn, pstmt, rs);
			}
			return result;
		}
		
		// 글삭제2 (이미지 리턴)
			public String delete(int num) {
				String img = "";
				try {
					conn = getConn();
					sql = "select & from vendor_qna where vendor_qna_num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					rs = pstmt.executeQuery();
					if(rs.next()) {
						img = rs.getString("img");
					}
						
					sql = "update vendor_qna set delete_yn = 'y' where vendor_qna_num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
				} catch (Exception e) {
					e.printStackTrace();
				}finally {
					close(conn, pstmt, rs);
				}
				return img;			
			}	
}
