package project.bean.admin;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import project.bean.img.ImgDTO;
import project.bean.member.MemberDTO;
import project.bean.product.ProductDTO;
import project.bean.search.SearchDTO;

public class AdminDAO {
	// 싱글톤 방식으로 사용
	private static AdminDAO instance = new AdminDAO();

	public static AdminDAO getInstance() {
		return instance;
	}

	private AdminDAO() {
	}

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String sql;

	private Connection getConn() throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
		String user = "project1";
		String pw = "tiger";

		Connection conn = DriverManager.getConnection(dburl, user, pw);
		return conn;
	}

	private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		try {
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if (pstmt != null) {
				pstmt.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if (rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/*-----------------관리자 - 회원 파트 --------------------*/
	// 전체 회원목록
	public List<MemberDTO> loadAllMemeber(int start, int end) {
		List<MemberDTO> list = new ArrayList<MemberDTO>();
		try {
			conn = getConn();
			sql = "select * from (select M.*, rownum r from (select * from member order by member_num desc) M ) where r between ? and ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setMember_num(rs.getInt("member_num"));
				dto.setId(rs.getString("id"));
				dto.setVendor(rs.getString("vendor"));
				dto.setBusiness_number(rs.getString("business_number"));
				dto.setBusiness_name(rs.getString("business_name"));
				dto.setName(rs.getString("name"));
				dto.setGender(rs.getString("gender"));
				dto.setGrade(rs.getString("grade"));
				dto.setDel(rs.getString("del"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	// 가입대기자 회원수 가져오기
	public int sellerJoinCount() {
		int count = 0;
		try {
			conn = getConn();
			sql = "select count(*) from member where vendor = '0'";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return count;
	}

	
	// 전체 회원수 가져오기
	public int AllMemberCount() {
		int count = 0;
		try {
			conn = getConn();
			sql = "select count(*) from member";
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt("count(*)");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}

		return count;
	}

	// 회원 상세정보
	public MemberDTO memberDetail(int member_num) {
		MemberDTO dto = new MemberDTO();
		try {
			conn = getConn();
			sql = "select * from member where member_num = ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, member_num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto.setMember_num(rs.getInt("member_num"));
				dto.setId(rs.getString("id"));
				dto.setVendor(rs.getString("vendor"));
				dto.setBusiness_number(rs.getString("business_number"));
				dto.setBusiness_name(rs.getString("business_name"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setCellphone(rs.getString("cellphone"));
				dto.setPhone(rs.getString("phone"));
				dto.setGender(rs.getString("gender"));
				dto.setGrade(rs.getString("grade"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setDel(rs.getString("del"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return dto;
	}

	// 회원 정보 수정
	public int updateMember(MemberDTO dto) {
		int result = 0;
		try {
			conn = getConn();
			sql = "update member set id = ?, vendor = ?, name = ?, grade = ? where member_num = ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getVendor());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getGrade());
			pstmt.setInt(5, dto.getMember_num());
			
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}

	// 회원 가입상태 변경
	public int changeMemberDel(int memeber_num, String del) {
		int result = 0;
		try {
			conn = getConn();
			sql = "update member set del = ? where member_num = ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, del);
			pstmt.setInt(2, memeber_num);

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}

	// 판매자 승인대기 목록
	public List<MemberDTO> loadWaitingMemeber(int start, int end) {
		List<MemberDTO> list = new ArrayList<MemberDTO>();
		try {
			conn = getConn();
			sql = "select * from (select M.*, rownum r from (select * from member where vendor = '0' order by member_num desc) M ) where r between ? and ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setMember_num(rs.getInt("member_num"));
				dto.setId(rs.getString("id"));
				dto.setVendor(rs.getString("vendor"));
				dto.setBusiness_number(rs.getString("business_number"));
				dto.setBusiness_name(rs.getString("business_name"));
				dto.setName(rs.getString("name"));
				dto.setGender(rs.getString("gender"));
				dto.setGrade(rs.getString("grade"));
				dto.setDel(rs.getString("del"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return list;
	}

	// 판매자 가입 승인 및 거절
	public int changeVendor(String vendor, int member_num) {
		int result = 0;
		try {
			conn = getConn();
			sql="update member set vendor = ? where member_num = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, vendor);
			pstmt.setInt(2, member_num);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	/*------------- 관리자 - 상품 파트 -----------------*/
	// 상품 목록 보기
	public List<ProductDTO> loadAllProduct(SearchDTO searchDTO) {
		List<ProductDTO> list = new ArrayList<ProductDTO>();
		String trimKeyWord = searchDTO.getKeyWord().trim();
		try {
			conn = getConn();
			sql="select * from (select p.*, rownum r from (select P.*, I.img_name from product  P left outer join img I on P.product_num = I.product_num where I.img_type = 'thumbnail' and product_name like ? order by P."+searchDTO.getSortName().trim() +" "+ searchDTO.getSort().trim() +" ) p ) where r between ? and ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, "%" + trimKeyWord + "%");
			pstmt.setInt(2, searchDTO.getStart());
			pstmt.setInt(3, searchDTO.getEnd());
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO dto = new ProductDTO();
				ImgDTO imgDto = new ImgDTO();
				dto.setProduct_num(rs.getInt("product_num"));
				dto.setMember_num(rs.getInt("member_num"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setPrice(rs.getInt("price"));
				dto.setCreated_date(rs.getTimestamp("created_date"));
				dto.setDelete_yn(rs.getString("delete_yn"));
				imgDto.setImg_name(rs.getString("img_name"));
				
				
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
	// 전체 상품 수 가져오기
	public int AllProductCount() {
		int result = 0;
		try {
			conn = getConn();
			sql = "select count(*) from product";
			pstmt = conn.prepareStatement(sql);
			rs= pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	// 해당 상품의 판매자 정보
	public String findBusinessName(int member_num) {
		String business_name = "";
		try {
			conn = getConn();
			sql="select business_name from member where member_num = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, member_num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				business_name = rs.getString("business_name");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return business_name; 
	}
	// 해당 상품 판매자의 사업자번호
	public String findBusinessNumber(int member_num) {
		String business_number = "";
		try {
			conn = getConn();
			sql="select business_number from member where member_num = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, member_num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				business_number = rs.getString("business_number");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return business_number; 
	}
	// 상품 상세보기
	public ProductDTO productDetail(int product_num) {
		ProductDTO dto = new ProductDTO();
		try {
			conn = getConn();
			sql="select P.*,I.img_name, I.img_num, c.category_name from product  P left outer join img I on P.product_num = I.product_num left outer join category C on P.category_num = C.category_num where P.product_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setProduct_num(rs.getInt("product_num"));
				dto.setMember_num(rs.getInt("member_num"));
				dto.setCategory_num(rs.getInt("category_num"));
				dto.setCategory_name(rs.getString("category_name"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setProduct_info(rs.getString("product_info"));
				dto.setStock(rs.getInt("stock"));
				dto.setPrice(rs.getInt("price"));
				dto.setDelivery_price(rs.getInt("delivery_price"));
				dto.setHas_delivery_fee(rs.getString("has_delivery_fee"));
				dto.setCreated_date(rs.getTimestamp("created_date"));
				dto.setModified_date(rs.getTimestamp("modified_date"));
				dto.setDelete_yn(rs.getString("delete_yn"));
				
				// 이미지 정보
			 	List<ImgDTO> imgs = new ArrayList<ImgDTO>();
 		            do {
	                ImgDTO imgDto = new ImgDTO();
	                imgDto.setImg_name(rs.getString("img_name"));
	                imgDto.setImg_num(rs.getInt("img_num"));
	                imgs.add(imgDto);
	            } while (rs.next() && product_num == rs.getInt("product_num")); // 같은 상품 번호인 경우에만 계속해서 이미지 추가
				dto.setImages(imgs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return dto;
	}
	
	//상품 복구하기
	public int restoreProduct(int product_num) {
		int result = 0;
		try {
			conn = getConn();
			sql="update product set delete_yn = 'N' where product_num = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, product_num);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	// 상품 승인 대기 목록 보기
	public List<ProductDTO> loadProductwaitList(SearchDTO searchDTO) {
		List<ProductDTO> list = new ArrayList<ProductDTO>();
		String trimKeyWord = searchDTO.getKeyWord().trim();
		try {
			conn = getConn();
			sql="select * from (select p.*, rownum r from (select P.*, I.img_name from product  P left outer join img I on P.product_num = I.product_num where I.img_type = 'thumbnail' and P.status = '0' and product_name like ? order by P."+searchDTO.getSortName().trim() +" "+ searchDTO.getSort().trim() +" ) p ) where r between ? and ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, "%" + trimKeyWord + "%");
			pstmt.setInt(2, searchDTO.getStart());
			pstmt.setInt(3, searchDTO.getEnd());
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO dto = new ProductDTO();
				ImgDTO imgDto = new ImgDTO();
				dto.setProduct_num(rs.getInt("product_num"));
				dto.setMember_num(rs.getInt("member_num"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setPrice(rs.getInt("price"));
				dto.setProduct_info(rs.getString("product_info"));
				dto.setCreated_date(rs.getTimestamp("created_date"));
				dto.setDelete_yn(rs.getString("delete_yn"));
				dto.setStatus(rs.getString("status"));
				imgDto.setImg_name(rs.getString("img_name"));
				
				
				
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
	
	//승인 대기 상품 개수 
	public int productAddCount() {
		int count = 0;
		try {
			conn = getConn();
			sql="select count(*) from product where status = '0'";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()){
				count = rs.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return count;
	}
	
	// 상품 승인 거절 메서드
	public int changeProductStatus(String status ,int product_num) {
		int result = 0;
		try {
			conn = getConn();
			sql="update product set status = ? where product_num = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, status);
			pstmt.setInt(2,product_num);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
}
