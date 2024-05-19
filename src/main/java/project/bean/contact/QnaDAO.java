package project.bean.contact;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Connection;
import java.util.ArrayList;



public class QnaDAO {
	
	private static QnaDAO instance = new QnaDAO();
	public static QnaDAO getInstance() {return instance;}
	private QnaDAO() {}
	
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
	
	private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		if(conn!=null) {try{conn.close();}catch(SQLException e) {}}
		if(pstmt!=null) {try{pstmt.close();}catch(SQLException e) {}}
		if(rs!=null) {try{rs.close();}catch(SQLException e) {}}
	}
	

//////////////////////////

	// 글작성
	public int qnaWrite(QnaDTO dto) {
		int result=0;
		try {
			conn = getConn();
			sql="insert into qna values (qna_seq.NEXTVAL,?,?,?,?,?,?,?,?,?,sysdate,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getMember_num());
			pstmt.setString(2, dto.getPassword());
			pstmt.setString(3, dto.getCategory());
			pstmt.setString(4, dto.getTitle());
			pstmt.setString(5, dto.getQuestion());
			pstmt.setString(6, dto.getAnswer());
			pstmt.setInt(7, dto.getReadCount());
			pstmt.setString(8, dto.getImg());
			pstmt.setString(9, dto.getWriter());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	// 답글
	public int answerWrite(QnaDTO dto) {
		int result=0;
		sql = "update qna set answer=?, reg_answer=sysdate where qna_num=?";
		try {
			conn = getConn();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getAnswer());
			pstmt.setInt(2, dto.getQna_num());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	// 글개수
	public int count() {
		int result=0;
		try {
			conn = getConn();
			sql = "select count(*) from qna";
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
	public ArrayList<QnaDTO> list(int start, int end){
		ArrayList<QnaDTO> list = new ArrayList<QnaDTO>();
		try {
			conn = getConn();
//			sql = "select * from (select q.*, rownum r from (select * from qna order by qna_num desc)q)where r>=? and r<=?";
			sql = "SELECT *	FROM (SELECT q.*, m.vendor, m.name, ROW_NUMBER() OVER (ORDER BY q.qna_num DESC) AS r FROM qna q left outer JOIN member m ON q.member_num = m.member_num)WHERE r >= ? AND r <= ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				QnaDTO dto = new QnaDTO();
				dto.setName(rs.getString("name"));
				dto.setWriter(rs.getString("writer"));
				dto.setMember_num(rs.getInt("member_num"));
				dto.setQna_num(rs.getInt("qna_num"));
				dto.setCategory(rs.getString("category"));
				dto.setTitle(rs.getString("title"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setAnswer(rs.getString("answer"));
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
	public QnaDTO content(int num) {
		QnaDTO dto = new QnaDTO();
		try {
			conn=getConn();
			sql = "update qna set readcount = readcount+1 where qna_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			sql = "SELECT q.*, m.name \r\n"
					+ "FROM qna q \r\n"
					+ "left outer JOIN member m ON q.member_num = m.member_num \r\n"
					+ "WHERE q.qna_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setMember_num(rs.getInt("member_num"));
				dto.setName(rs.getString("name"));
				dto.setImg(rs.getString("img"));
				dto.setWriter(rs.getString("writer"));
				dto.setTitle(rs.getString("title"));
				dto.setAnswer(rs.getString("answer"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setReadCount(rs.getInt("readcount"));
				dto.setReg_answer(rs.getTimestamp("reg_answer"));
				dto.setCategory(rs.getString("category"));
				dto.setQuestion(rs.getString("question"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return dto;
	}
	
	
	
	// 글 수정 form
	public QnaDTO qnaUpdateForm(int num) {
		QnaDTO dto = new QnaDTO();
		try {
			conn = getConn();
			sql = "select * from qna where qna_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setQna_num(rs.getInt("qna_num"));
				dto.setImg(rs.getString("img"));
				dto.setPassword(rs.getString("password"));
				dto.setTitle(rs.getString("title"));
				dto.setAnswer(rs.getString("answer"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setReg_answer(rs.getTimestamp("reg_answer"));
				dto.setCategory(rs.getString("category"));
				dto.setQuestion(rs.getString("question"));
				dto.setWriter(rs.getString("writer"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return dto;
	}
	
	// 글수정 Pro
	
	public int qnaUpdatePro(QnaDTO dto, int num) {
		int result=0;
		String dbpw="";
		try {
			conn = getConn();
			sql = "select password from qna where qna_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpw = rs.getString("password");
				if(dbpw.equals(dto.getPassword())) {
					sql = "update qna set title=?, question=?, category=?, img=? where qna_num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, dto.getTitle());
					pstmt.setString(2, dto.getQuestion());
					pstmt.setString(3, dto.getCategory());
					pstmt.setString(4, dto.getImg());
					pstmt.setInt(5, dto.getQna_num());
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
	
	// 글삭제
	
		public int qnaDelete(int num,String password) {
			int result=0;
			String dbpw = "";
			try {
				conn = getConn();
				pstmt = conn.prepareStatement("select password from qna where qna_num=?");
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					dbpw = rs.getString("password");
					if(dbpw.equals(password)) {
						sql = "delete from qna where qna_num=?";
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
				sql = "select & from qna where num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					img = rs.getString("img");
				}
				
				sql = "delete from qna where num=?";
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