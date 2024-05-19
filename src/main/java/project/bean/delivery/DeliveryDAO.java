package project.bean.delivery;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DeliveryDAO {
	private static DeliveryDAO instance = new DeliveryDAO();
	public static DeliveryDAO getInstance () {
		return instance;
	}
	private DeliveryDAO() {};
	
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
	
	//로그인한 아이디의 배송지 갯수
	public int count (int memberNum) {	
		int result = 0;
		try {
			conn = getConn();
			sql = "select count(*) from delivery where member_num=? and delete_yn = 'N'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberNum);
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
	
	//로그인한 아이디의 배송지 목록
	public ArrayList<DeliveryDTO> list(int memberNum, int start, int end) {
		ArrayList<DeliveryDTO> list = new ArrayList<DeliveryDTO>();
		try {
			conn = getConn();
			sql = "select * from (select b.*, rownum r from (select * from delivery where member_num=? and delete_yn = 'N' order by delivery_num desc)b) where r>=? and r<=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberNum);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery(); 
			while(rs.next()) {
				DeliveryDTO dto = new DeliveryDTO();
				dto.setDelivery_num(rs.getInt("delivery_num"));
				dto.setMember_num(rs.getInt("member_num"));
				dto.setDelivery_name(rs.getString("delivery_name"));
				dto.setName(rs.getString("name"));
				dto.setAddress1(rs.getString("address1"));
				dto.setAddress2(rs.getString("address2"));
				dto.setAddress3(rs.getString("address3"));
				dto.setCellphone(rs.getString("cellphone"));
				dto.setPhone(rs.getString("phone"));
				dto.setDefault_address(rs.getString("default_address"));
				list.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	} 
	
	//모든 배송지 중에 기본배송지가 있는지 여부 확인
	public boolean isDefault_address(int snum) {
		boolean result = false;
		try {
			conn = getConn();
			sql = "select default_address from delivery where member_num=? and delete_yn = 'N'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, snum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				if(rs.getString("default_address").equals("2")) {
					result=true;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//배송지 목록 추가
	public int insertPro(DeliveryDTO dto) {
		int result = 0;
		if(dto.getDefault_address() == null) {	//기본배송지 체크가 안될 때 기본값을 1로 대입
			dto.setDefault_address("1");
		}
		try {
			conn = getConn();
			sql = "insert into delivery values(delivery_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?,'N')";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getMember_num());
			pstmt.setString(2, dto.getDelivery_name());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getAddress1());
			pstmt.setString(5, dto.getAddress2());
			pstmt.setString(6, dto.getAddress3());
			pstmt.setString(7, dto.getCellphone());
			pstmt.setString(8, dto.getPhone());
			pstmt.setString(9, dto.getDefault_address());
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//배송지 정보
	public DeliveryDTO updateForm (int delivery_num) {
		DeliveryDTO dto = new DeliveryDTO();
		try {
			conn = getConn();
			sql = "select * from delivery where delivery_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, delivery_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setDelivery_name(rs.getString("delivery_name"));
				dto.setName(rs.getString("name"));
				dto.setAddress1(rs.getString("address1"));
				dto.setAddress2(rs.getString("address2"));
				dto.setAddress3(rs.getString("address3"));
				dto.setPhone(rs.getString("phone"));
				dto.setCellphone(rs.getString("cellphone"));
				dto.setDefault_address(rs.getString("default_address"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return dto;
	}
	
	//기본배송지 초기화 (기본배송지를 1개만 설정하기 위함)
	public void resetDefault_address (int member_num) {
		try {
			conn = getConn();
			sql = "update delivery set default_address='1' where member_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		} 
	}
	
	//배송지 변경
	public int updatePro (DeliveryDTO dto) {
		int result = 0;
		try {
			conn = getConn();
			sql = "update delivery set delivery_name=?, name=?, address1=?, address2=?, address3=?, phone=?, cellphone=?, default_address=? where delivery_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getDelivery_name());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getAddress1());
			pstmt.setString(4, dto.getAddress2());
			pstmt.setString(5, dto.getAddress3());
			pstmt.setString(6, dto.getPhone());
			pstmt.setString(7, dto.getCellphone());
			pstmt.setString(8, dto.getDefault_address() == null ? "1" : dto.getDefault_address());
			pstmt.setInt(9, dto.getDelivery_num());
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		} 
		return result;
	}
	
	//배송지 삭제
	public int deletePro (int delivery_num) {
		int result = 0;
		try {
			conn = getConn();
			sql = "update delivery set delete_yn = 'Y' where delivery_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, delivery_num);
			result = pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//현재 페이지에 있는 배송지의 갯수
	public int countInPage (int member_num, int start, int end) {
		int result = 0;
		try {
			conn = getConn();
			sql = "select count(*) from (select b.*, rownum r from (select * from delivery where member_num=? and delete_yn = 'N')b) where r>=? and r<=?";;
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
	
//	---------------- universe's update
	
//	기본배송지인 배송지 찾기 (값이 2 로 설정된 정보 찾기) orderForm.jsp
	public DeliveryDTO defaultVal(int member_num) {
		DeliveryDTO dto = new DeliveryDTO();
		try {
			conn = getConn();
			sql = "select * from delivery where member_num = ? and delete_yn = 'N' and default_address = '2'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setName(rs.getString("name"));
				dto.setDelivery_num(rs.getInt("delivery_num"));
				dto.setAddress1(rs.getString("address1"));
				dto.setAddress2(rs.getString("address2"));
				dto.setAddress3(rs.getString("address3"));
				dto.setPhone(rs.getString("phone"));
				dto.setCellphone(rs.getString("cellphone"));
				dto.setDefault_address(rs.getString("default_address"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return dto;
	}
	
//	배송지 추가 orderForm.jsp 배송지에 추가 선택했을 때
	public void deliveryInsert(DeliveryDTO dto, int member_num) {
		try {
			conn = getConn();
			sql = "insert into delivery values(delivery_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, 1,'N')";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getMember_num());
			pstmt.setString(2, dto.getDelivery_name());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getAddress1());
			pstmt.setString(5, dto.getAddress2());
			pstmt.setString(6, dto.getAddress3());
			pstmt.setString(7, dto.getCellphone());
			pstmt.setString(8, dto.getPhone());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
	}
	
//	주소 정보 - orderForm 에서 address1,2,3을 받기 위함
	public List<DeliveryDTO> addressInfo(int member_num) {			// 회원이 주소추가를 한 번 더 하면 2개의 결과값이나옴
		List<DeliveryDTO> list = new ArrayList<DeliveryDTO>();
		try {
			conn = getConn();
			sql = "select D.* from delivery D left outer join member M on D.member_num = M.member_num where D.member_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				DeliveryDTO dto = new DeliveryDTO();
				dto.setDelivery_num(rs.getInt("delivery_num"));
				dto.setDelivery_name(rs.getString("delivery_name"));
				dto.setName(rs.getString("name"));
				dto.setAddress1(rs.getString("address1"));
				dto.setAddress2(rs.getString("address2"));
				dto.setAddress3(rs.getString("address3"));
				dto.setPhone(rs.getString("phone"));
				dto.setCellphone(rs.getString("cellphone"));
				
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
//	배송지 시퀀스 받아오기위해 만듬
	public DeliveryDTO deliveryNum(int member_num) {
		DeliveryDTO dto = new DeliveryDTO();
		try {
			conn = getConn();
			sql = "select * from delivery where member_num=? and delete_yn = 'N'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setDelivery_num(rs.getInt("delivery_num"));
				dto.setAddress3(rs.getString("address3"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return dto;
	}
}

