package project.bean.member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import project.bean.delivery.DeliveryDTO;

public class MemberDAO {
	private static MemberDAO instance = new MemberDAO();
	public static MemberDAO getInstance() {
		return instance;
	}
	private MemberDAO() {};
	
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
		}catch(SQLException s) {}
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
	
	//아이디 중복 확인
	public boolean confirmId(String id) {
		boolean result = false;
		try {
			conn = getConn();
			sql = "select * from member where id=? and del='1'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//회원가입
	public int insertPro(MemberDTO dto) {
		int result = 0;
		if(dto.getVendor() == null) {	//vedor값이 null일 때 (일반회원일 때) vendor값을 1로 설정
			dto.setVendor("1");
		}
		try {
			conn = getConn();
			sql = "	insert into member values(member_seq.nextval,?,?,?,?,?,?,?,?,?,?,?,'BRONZE',sysdate,'1')";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getVendor());
			pstmt.setString(3, dto.getBusiness_number());
			pstmt.setString(4, dto.getBusiness_name());
			pstmt.setString(5, dto.getPw());
			pstmt.setString(6, dto.getName());
			pstmt.setString(7, dto.getEmail());
			pstmt.setString(8, dto.getCellphone());
			pstmt.setString(9, dto.getPhone());
			pstmt.setString(10, dto.getGender());
			pstmt.setString(11, dto.getBirth());
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();	
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//아이디 찾기
	public String findId(MemberDTO dto) {
		String id = "";
		try {
			conn = getConn();
			sql="select id from member where name=? and cellphone=? and del='1'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getCellphone());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				id = rs.getString("id");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return id;
	}
	
	//비밀번호 바꾸기 - 회원확인
	public boolean checkMem(MemberDTO dto) { 
		boolean result = false;
		try {
			conn = getConn();
			sql = "select * from member where id=? and cellphone=? and del='1'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getCellphone());
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
	
	//비밀번호 바꾸기
	public int changePw(MemberDTO dto) {
		int result = 0;
		try {
			conn = getConn();
			sql = "update member set pw=? where id=? and cellphone=? and del='1'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getPw());
			pstmt.setString(2, dto.getId());
			pstmt.setString(3, dto.getCellphone());
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}	
	
	//로그인 체크
	public boolean loginCheck(MemberDTO dto) {
		boolean result = false;
		try {
			conn = getConn();
			sql = "select * from member where id=? and pw=? and del='1'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPw());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setMember_num(rs.getInt("member_num"));
				dto.setVendor(rs.getString("vendor"));
				result = true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//가입 승인 거절 회원 가입 재신청
	public int reapply (int member_num) {
		int result = 0;
		try {
			conn = getConn();
			sql = "update member set vendor='0' where member_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//정보조회 전 비밀번호 확인
	public boolean pwCheck(String pw, int member_num) {
		boolean result = false;
		try {
			conn = getConn();
			sql = "select * from member where pw=? and member_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pw);
			pstmt.setInt(2, member_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = true;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//회원정보
	public MemberDTO memberInfo(int member_num) {
		MemberDTO dto = new MemberDTO();
		try {
			conn = getConn();
			sql = "select * from member where member_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setBusiness_number(rs.getString("business_number"));
				dto.setBusiness_name(rs.getString("business_name"));
				dto.setPw(rs.getString("pw"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setCellphone(rs.getString("cellphone"));
				dto.setPhone(rs.getString("phone"));
				dto.setGender(rs.getString("gender"));
				dto.setBirth(rs.getString("birth"));
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return dto;
	}
	
	//비밀번호를 표시할때 ·으로 숨겨서 표시
	public String maskedPw(String pw) {	
		StringBuilder masked = new StringBuilder();
			for (int i = 0; i < pw.length(); i++) {
				masked.append("*");
		    }
		return masked.toString();
	}
			
	
	//회원 정보 변경
	public int updatePro(MemberDTO dto) {
		int result = 0;
		try {				
			conn = getConn();
			if(dto.getPw()==null) {
				sql = "update member set business_number=?, business_name=?, name=?, email=?, cellphone=?, phone=?, gender=?, birth=? where member_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getBusiness_number());
				pstmt.setString(2, dto.getBusiness_name());
				pstmt.setString(3, dto.getName());
				pstmt.setString(4, dto.getEmail());
				pstmt.setString(5, dto.getCellphone());
				pstmt.setString(6, dto.getPhone());
				pstmt.setString(7, dto.getGender());
				pstmt.setString(8, dto.getBirth());
				pstmt.setInt(9, dto.getMember_num());
				result = pstmt.executeUpdate();
			}else {
				sql = "update member set business_number=?, business_name=?, pw=?, name=?, email=?, cellphone=?, phone=?, gender=?, birth=? where member_num=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, dto.getBusiness_number());
				pstmt.setString(2, dto.getBusiness_name());
				pstmt.setString(3, dto.getPw());
				pstmt.setString(4, dto.getName());
				pstmt.setString(5, dto.getEmail());
				pstmt.setString(6, dto.getCellphone());
				pstmt.setString(7, dto.getPhone());
				pstmt.setString(8, dto.getGender());
				pstmt.setString(9, dto.getBirth());
				pstmt.setInt(10, dto.getMember_num());
				result = pstmt.executeUpdate();
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//회원 탈퇴 - del을 2로 수정
	public int deletePro(int member_num, String pw) {
		int result = 0;
		String dbpw = "";
		try {
			conn = getConn();
			sql = "select pw from member where member_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dbpw = rs.getString("pw");
				if(dbpw.equals(pw)) {
					sql="update member set del='2' where member_num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, member_num);
					result = pstmt.executeUpdate();
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	

//	---------------- universe's update
	
//	회원정보 업데이트 (전화번호/휴대폰번호) orderForm.jsp 회원정보 반영 체크했을때
	public void memberUpdate(MemberDTO dto, int member_num) {
		try {
			conn = getConn();
			sql = "update member set phone=?, cellphone=? where member_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getPhone());
			pstmt.setString(2, dto.getCellphone());
			pstmt.setInt(3, member_num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
	}
	
}
