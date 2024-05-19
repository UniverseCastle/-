package project.bean.contact;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;

public class NoticeDAO {
	
	private static NoticeDAO instance = new NoticeDAO();
	public static NoticeDAO getInstance() {
		return instance;
	}
	private NoticeDAO() {}
	
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
	
	
	
	// 글 작성
	public int noticeWrite(NoticeDTO dto) {
		int result=0;
		try {
			/*
				notice_num number not null primary key,
			    member_num number not null,
			    title varchar2(50) not null,
			    content varchar2(2000) not null,
			    img varchar2(50),
			    readCount number,
			    reg date default sysdate,
			    content_comment varchar2(2000),
			    reg_comment date default sysdate
			    */
			conn = getConn();
			sql = "insert into notice values(notice_seq.NEXTVAL,?,?,?,?,sysdate,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getImg());
			pstmt.setInt(4, dto.getReadCount());
			pstmt.setString(5, dto.getFix_yn());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	// 글목록
	public ArrayList<NoticeDTO> noticeList(int start, int end){
		ArrayList<NoticeDTO> list = new ArrayList<NoticeDTO>();
		try{
			conn = getConn();
//			sql = "select * from (select n.*, rownum r from (select * from notice order by notice_num desc)n)where r>=? and r<=?";
			sql = "select * from (select n.*, rownum r from (select * from notice order by fix_yn desc, notice_num desc)n)where r >= ? and r <=?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				do {
					NoticeDTO dto = new NoticeDTO();
					dto.setNotice_num(rs.getInt("notice_num"));
					dto.setReadCount(rs.getInt("readCount"));
					dto.setReg(rs.getTimestamp("reg"));
					dto.setTitle(rs.getString("title"));
					dto.setFix_yn(rs.getString("fix_yn"));
					list.add(dto);
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	// 글개수
	public int boardCount() {
		int result=0;
		try {
			conn = getConn();
			sql = "select count(*) from notice";
			pstmt=conn.prepareStatement(sql);
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
	
	// 글내용
	public NoticeDTO readContent(int num) {
		NoticeDTO dto = new NoticeDTO();
		try {
			conn = getConn();
			sql = "update notice set readcount=readcount+1 where notice_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			sql = "select * from notice where notice_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setNotice_num(rs.getInt("notice_num"));
				dto.setTitle(rs.getString("title"));
				dto.setImg(rs.getString("img"));
				dto.setReadCount(rs.getInt("readcount"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setContent(rs.getString("content"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return dto;
	}
	
	// 글 삭제
	public int noticeDelete(int num) {
		int result=0;
		try {
			conn = getConn();
			sql = "delete from notice where notice_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	// 글 수정Form
	public NoticeDTO noticeUpdateForm(int num) {
		NoticeDTO dto = new NoticeDTO();
		try {
			conn = getConn();
			sql = "select * from notice where notice_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setFix_yn(rs.getString("fix_yn"));
				dto.setNotice_num(rs.getInt("notice_num"));
				dto.setContent(rs.getString("content"));
				dto.setImg(rs.getString("img"));
				dto.setReadCount(rs.getInt("readCount"));
				dto.setTitle(rs.getString("title"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return dto;
	}
	
	// 글수정 pro
	public int noticeUpdatePro(NoticeDTO dto) {
		int result=0;
		try {
			conn = getConn();
			sql = "update notice set title=?, img = ?, content=?, fix_yn=? where notice_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getImg());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getFix_yn());
			pstmt.setInt(5, dto.getNotice_num());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	
	
}
