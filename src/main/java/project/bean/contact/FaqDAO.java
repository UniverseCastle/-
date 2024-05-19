package project.bean.contact;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class FaqDAO {
	private static FaqDAO instance = new FaqDAO();
	public static FaqDAO getInstance() {
		return instance;
	}
	private FaqDAO() {}
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String sql;
	
	private Connection getConn() throws Exception{
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String url = "jdbc:oracle:thin:@192.168.0.10:1521:orcl";
			String user = "project1";
			String pass = "tiger";			
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
	
	//글작성
	public int faqWrite(FaqDTO dto) {
		int result=0;
		try {
			conn = getConn();
			sql="insert into faq values(faq_seq.NEXTVAL,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getCategory());
			pstmt.setInt(2, dto.getNum());
			pstmt.setString(3, dto.getQuestion());
			pstmt.setString(4, dto.getAnswer());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//글목록
	public ArrayList<FaqDTO> faqList(int start,int end){
		ArrayList<FaqDTO> list = new ArrayList<FaqDTO>();
		try {
			conn = getConn();
			sql = "select * from (select b.*, rownum r from (select * from faq order by faq_num desc)b)where r>=? and r<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				do {
					FaqDTO dto = new FaqDTO();
					dto.setNum(rs.getInt("faq_num"));
					dto.setCategory(rs.getString("category"));
					dto.setReadCount(rs.getInt("readCount"));
					dto.setQuestion(rs.getString("question"));
					dto.setAnswer(rs.getString("answer"));
					list.add(dto);
				}while(rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	//글 개수
	public int boardCount() {
		int result=0;
		try {
			conn= getConn();
			sql = "select count(*) from faq";
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
	
	// 글 수정폼
	public FaqDTO faqUpdateForm(int num) {
		FaqDTO dto = new FaqDTO();
		try {
			conn = getConn();
			sql = "select * from faq where faq_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getInt("faq_num"));
				dto.setAnswer(rs.getString("answer"));
				dto.setCategory(rs.getString("category"));
				dto.setQuestion(rs.getString("question"));
				dto.setAnswer(rs.getString("answer"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return dto;
	}
	
	// 글수정 Pro
	
	public int faqUpdatePro(FaqDTO dto, int faq_num) {
	    int result = 0;
	    try {
	        conn = getConn();
	        sql = "update faq set question=?, answer=?, category=? where faq_num=?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, dto.getQuestion());
	        pstmt.setString(2, dto.getAnswer());
	        pstmt.setString(3, dto.getCategory());
	        pstmt.setInt(4, faq_num);
	        result = pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        close(conn, pstmt, rs);
	    }
	    return result;
	}
	
	// 글삭제
	public int faqDelete(int num) {
	    int result = 0;
	    try {
	        conn = getConn();
	        sql = "delete from faq where faq_num=?";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, num);
	        result = pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        close(conn, pstmt, rs);
	    }
	    return result;
	}
}
