package project.bean.product;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import project.bean.cart.CartDTO;
import project.bean.category.CategoryDTO;
import project.bean.img.ImgDTO;
import project.bean.search.SearchDTO;

public class ProductDAO {
	// 싱글톤 방식으로 사용
	private static ProductDAO instance = new ProductDAO();

	public static ProductDAO getInstance() {
		return instance;
	}

	private ProductDAO() {
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
	
	
	// 카테고리 불러오기
	public List<CategoryDTO> loadCategory(){
		List<CategoryDTO> list = new ArrayList<CategoryDTO>();
		try {
			conn = getConn();
			sql="select category_name,category_num from category ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CategoryDTO dto = new CategoryDTO();
				dto.setCategory_name(rs.getString("category_name"));
				dto.setCategory_num(rs.getInt("category_num"));
				list.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	//카테고리 총 개수 가져오기
	public int categoryCount() {
		int count = 0;
		try {
			conn = getConn();
			sql="select count(*) from category";
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
	
	
	//상품 등록
	public int saveProduct(ProductDTO dto) {
		int product_num = 0;
		try {
			conn = getConn();
			sql = "insert into product values(product_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, 'N', systimestamp,systimestamp,?,'0')";
			
			pstmt = conn.prepareStatement(sql, new String[] { "PRODUCT_NUM" });
		
			
			pstmt.setInt(1, dto.getMember_num()); // 회원 정보
			pstmt.setInt(2, dto.getCategory_num());	// 카테고리 정보
			pstmt.setString(3, dto.getProduct_name()); // 상품 이름
			pstmt.setString(4, dto.getProduct_info()); // 상품 정보
			pstmt.setInt(5, dto.getPrice()); // 상품 가격
			pstmt.setInt(6, dto.getDelivery_price()); // 배송비
			pstmt.setString(7, dto.getHas_delivery_fee()); // 배송비 여부
			pstmt.setInt(8, dto.getStock()); // 상품 재고
			pstmt.setInt(9, dto.getFirst_stock()+dto.getStock());// 상품 최초 재고

			pstmt.executeUpdate();
		
			rs = pstmt.getGeneratedKeys();

			if (rs.next()) {
				product_num = rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return product_num;
	}
	
	
	// 상품이미지 등록
	public int saveImg(ImgDTO imgDTO) {
		int result = 0;
		try {
			conn = getConn();
			sql = "insert into img values(img_seq.nextval, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, imgDTO.getProduct_num());
			pstmt.setString(2, imgDTO.getImg_name());
			pstmt.setString(3, imgDTO.getOriginal_name());
			pstmt.setString(4, imgDTO.getExtension());
			pstmt.setString(5, imgDTO.getImg_type());

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	// 상품 목록 보기
	public List<ProductDTO> productList(SearchDTO searchDTO) {
		List<ProductDTO> list = new ArrayList<ProductDTO>();
		String trimKeyWord = searchDTO.getKeyWord().trim();
		try {
			conn = getConn();
			sql="select * from (select p.*, rownum r from (select P.*, I.img_name from product  P left outer join img I on P.product_num = I.product_num where P.delete_yn = 'N' and status = '1' and I.img_type = 'thumbnail' and product_name like ? order by P."+searchDTO.getSortName().trim() +" "+ searchDTO.getSort().trim() +" ) p ) where r between ? and ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, "%" + trimKeyWord + "%");
			pstmt.setInt(2, searchDTO.getStart());
			pstmt.setInt(3, searchDTO.getEnd());
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO dto = new ProductDTO();
				ImgDTO imgDto = new ImgDTO();
				dto.setCategory_num(rs.getInt("category_num"));
				dto.setProduct_num(rs.getInt("product_num"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setProduct_info(rs.getString("product_info"));
				dto.setPrice(rs.getInt("price"));
				dto.setDelivery_price(rs.getInt("delivery_price"));
				dto.setStock(rs.getInt("stock"));
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
	// 카테고리별 상품 목록 보기
		public List<ProductDTO> CateProductList(SearchDTO searchDTO, int category_num) {
			List<ProductDTO> list = new ArrayList<ProductDTO>();
			try {
				conn = getConn();
				sql="select * from (select p.*, rownum r from (select P.*,I.img_name from product  P left outer join img I on P.product_num = I.product_num where P.delete_yn = 'N' and status = '1' and I.img_type = 'thumbnail' and category_num = ? order by P."+ searchDTO.getSortName().trim() + " "+ searchDTO.getSort().trim() + " ) p ) where r between ? and ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, category_num);
				pstmt.setInt(2, searchDTO.getStart());
				pstmt.setInt(3, searchDTO.getEnd());
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					ProductDTO dto = new ProductDTO();
					ImgDTO imgDto = new ImgDTO();
					dto.setCategory_num(rs.getInt("category_num"));
					dto.setProduct_num(rs.getInt("product_num")); 
					dto.setProduct_name(rs.getString("product_name"));
					dto.setProduct_info(rs.getString("product_info"));
					dto.setPrice(rs.getInt("price"));
					dto.setDelivery_price(rs.getInt("delivery_price"));
					dto.setStock(rs.getInt("stock"));
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
		public int productCount() {
			int result = 0;
			try {
				conn = getConn();
				sql = "select count(*) from product where delete_yn = 'N' and status = '1'";
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
		
		//카테고리 별 상품수
		public int categoryProductCount(int category_num) {
			int result = 0;
			try {
				conn = getConn();
				sql = "select count(*) from product where delete_yn = 'N' and status = '1' and category_num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1,category_num);
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
		
		// 상품 수정하기 폼
		public ProductDTO updateForm(int product_num) {
			ProductDTO dto = new ProductDTO();
			try {
				conn = getConn();
				sql="select P.*,I.img_name, I.img_num, c.category_name from product  P left outer join img I on P.product_num = I.product_num left outer join category C on P.category_num = C.category_num where P.delete_yn = 'N' and P.product_num = ?";
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
		
		// 상품 수정
		public int updateProduct(ProductDTO dto) {
			int result = 0;
			int dbFirstStock = 0;
			try {
				conn = getConn();
				
				// 상품등록시 기입되었던 최초 재고를가져옴
				sql="select first_stock from product where product_num = ?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, dto.getProduct_num());
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					dbFirstStock = rs.getInt("first_stock");
				}
				
				// 수정하면서 추가 재고를 최초재고에 더하고
				// 현재재고에도 추가재고를더해서 갭차이를 유지 = 판매수량 계산에 지장없게하기위해
				sql = "update product set category_num = ?, product_name = ?, product_info = ?, price = ?, delivery_price = ?, has_delivery_fee = ?, stock = ?, first_stock = ? where product_num = ?";
				pstmt = conn.prepareStatement(sql);

				pstmt.setInt(1, dto.getCategory_num());	// 카테고리 정보
				pstmt.setString(2, dto.getProduct_name()); // 상품 이름
				pstmt.setString(3, dto.getProduct_info()); // 상품 정보
				pstmt.setInt(4, dto.getPrice()); // 상품 가격
				pstmt.setInt(5, dto.getDelivery_price()); // 배송비
				pstmt.setString(6, dto.getHas_delivery_fee()); // 배송비 여부
				pstmt.setInt(7, dto.getStock()+dto.getFirst_stock()); // 상품 재고
				pstmt.setInt(8,	dbFirstStock+dto.getFirst_stock());	 // 상품 최초 재고
				pstmt.setInt(9, dto.getProduct_num());	// 상품 번호

				result = pstmt.executeUpdate();

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(conn, pstmt, rs);
			}
			return result;
		}
		//썸네일이미지 가져오기
		public String getThumbnail(int product_num) {
			String thumbnail="";
			try {
				conn = getConn();
				sql="select img_name from img where product_num = ? and img_type = 'thumbnail'";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, product_num);
				
				rs = pstmt.executeQuery();
				if(rs.next()) {
					thumbnail = rs.getString("img_name");
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(conn, pstmt, rs);
			}
			return thumbnail;
		}
		
		// 이미지 이름 가져오기
		public String getImgName(int imgNum) {
			String imgName="";
			try {
				conn = getConn();
				sql="select img_name from img where img_num = ?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, imgNum);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					imgName = rs.getString("img_name");
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(conn, pstmt, rs);
			}
			return imgName;
		}
		
		// 이미지 삭제 
		public void deleteImg(String imgName) {
			try {
				conn = getConn();
				sql="delete from img where img_name = ?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, imgName);
				
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(conn, pstmt, rs);
			}
			
		}
		
		// 상품 삭제
		public int deleteProduct(int product_num) {
			int result = 0;
			try {
				conn = getConn();
				sql="update product set delete_yn = 'Y' where product_num = ?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, product_num);
				
				result = pstmt.executeUpdate();
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(conn, pstmt, rs);
			}
			return result;
		}
		
		// 등록된 이미지 개수 불러오기 => 확실하게 전체다 등록되었는지 확인하기 위함
		public int ImgInsertCount(int product_num) {
			int imgAddCnt = 0;
			try {
				conn = getConn();
				sql = "select count(*) from img where product_num = ?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, product_num);
				
				rs  = pstmt.executeQuery();
				
				if(rs.next()) {
					imgAddCnt = rs.getInt("count(*)");
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(conn, pstmt, rs);
			}
			return imgAddCnt;
		}
	
		
//		-------------------------universe's made-------------------------

//		-------------------------------상품-------------------------------
//		상품 상세 페이지
		public ProductDTO productContent(int product_num) {
			ProductDTO dto = new ProductDTO();
			try {
				conn = getConn();				// 수정) 04/29 member_num, business_name 을 받기 위함
				sql = "select P.*, M.member_num, M.business_name from product P left outer join member M on P.member_num = M.member_num where delete_yn = 'N' and P.product_num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, product_num);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					dto.setProduct_num(rs.getInt("product_num"));
					dto.setMember_num(rs.getInt("member_num"));
					dto.setBusiness_name(rs.getString("business_name"));
					dto.setCategory_num(rs.getInt("category_num"));
					dto.setProduct_name(rs.getString("product_name"));
					dto.setProduct_info(rs.getString("product_info"));
					dto.setPrice(rs.getInt("price"));
					dto.setStock(rs.getInt("stock"));
					dto.setDelivery_price(rs.getInt("delivery_price"));
					dto.setHas_delivery_fee(rs.getString("has_delivery_fee"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(conn, pstmt, rs);
			}
			return dto;
		}
		
//		썸네일 1장뽑기
		public List<ProductDTO> thumbnail(int product_num) {
			List<ProductDTO> list = new ArrayList<ProductDTO>();
			try {
				conn = getConn();
				sql = "select b.* from (select P.*, I.img_name, I.img_num from product P left outer join img I on P.product_num = I.product_num where P.delete_yn = 'N' and I.img_type = 'thumbnail' order by P.product_num desc) b where product_num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, product_num);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					ProductDTO dto = new ProductDTO();
					ImgDTO imgDto = new ImgDTO();
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
		
	//  썸네일 1장 + 상품정보 + 카테고리 이름
	  public List<ProductDTO> orderList(int product_num) {
	     List<ProductDTO> list = new ArrayList<ProductDTO>();
	     try {
	        conn = getConn();
	        sql = "select P.product_name, P.product_info, C.category_name, I.img_name from product P left outer join img I on P.product_num = I.product_num left outer join category C on P.category_num = C.category_num where P.delete_yn = 'N' and I.img_type = 'thumbnail' and P.product_num = ? order by P.product_num desc";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, product_num);
	        rs = pstmt.executeQuery();
	        if (rs.next()) {
	           ProductDTO dto = new ProductDTO();
	           dto.setProduct_name(rs.getString("product_name"));
	           dto.setProduct_info(rs.getString("product_info"));
	           dto.setCategory_name(rs.getString("category_name"));
	           
	           ImgDTO imgDto = new ImgDTO();
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

//		상품이미지 (상품설명 이미지 제외)
		public List<ProductDTO> productImages(int product_num) {
			List<ProductDTO> list = new ArrayList<ProductDTO>();
			try {
				conn = getConn();
				sql = "select b.* from (select P.*, I.img_name from product P left outer join img I on P.product_num = I.product_num where P.delete_yn = 'N' and I.img_type = 'thumbnail' or I.img_type = 'productImg' order by P.product_num desc) b where product_num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, product_num);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					ProductDTO dto = new ProductDTO();
					ImgDTO imgDto = new ImgDTO();
					dto.setProduct_num(product_num);
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
		
//		상품설명 이미지
		public List<ProductDTO> textImages(int product_num){
			List<ProductDTO> list = new ArrayList<ProductDTO>();
			try {
				conn = getConn();
				sql = "select b.* from (select P.*, I.img_name from product P left outer join img I on P.product_num = I.product_num where P.delete_yn = 'N' and I.img_type = 'textImg' order by P.product_num desc) b where product_num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, product_num);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					ProductDTO dto = new ProductDTO();
					ImgDTO imgDto = new ImgDTO();
					dto.setProduct_num(product_num);
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
		
//		관련상품 이미지 (카테고리 중 최신글 4개)
		public List<ProductDTO> connImg(int product_num, int category_num){
			List<ProductDTO> list = new ArrayList<ProductDTO>();
			try {
				conn = getConn();
				sql = "select * from (select b.*, rownum r from (select P.*, I.img_name, C.category_name from product P left outer join img I on P.product_num = I.product_num left outer join category C on P.category_num = C.category_num where P.status = '1' and P.delete_yn = 'N' and I.img_type = 'thumbnail' and C.category_num = ? order by P.product_num desc) b where product_num != ?) where r <= 4";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, category_num);
				pstmt.setInt(2, product_num);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					ProductDTO dto = new ProductDTO();
					ImgDTO imgDto = new ImgDTO();
					dto.setProduct_num(rs.getInt("product_num"));
					dto.setCategory_num(rs.getInt("category_num"));
					dto.setProduct_name(rs.getString("product_name"));
					dto.setPrice(rs.getInt("price"));
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
		
//		장바구니 상품정보 + 썸네일 (장바구니에서 상품 정보 가져오기 위해 사용 + delete_yn 안넣음 - 삭제상품은 따로 표기하기위함)
		public ArrayList<ProductDTO> productInfo(int product_num) {
			ArrayList<ProductDTO> list = new ArrayList<ProductDTO>();
			try {
				conn = getConn();
				sql = "select P.*, I.img_num, I.img_name from product P left outer join img I on P.product_num = I.product_num where I.img_type='thumbnail' and P.product_num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, product_num);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					ProductDTO dto = new ProductDTO();
					dto.setProduct_num(rs.getInt("product_num"));
//					dto.setMember_num(rs.getInt("member_num"));
//					dto.setBusiness_name(rs.getString("business_name"));
					dto.setCategory_num(rs.getInt("category_num"));
					dto.setProduct_name(rs.getString("product_name"));
//					dto.setProduct_info(rs.getString("product_info"));
					dto.setPrice(rs.getInt("price"));
					dto.setStock(rs.getInt("stock"));
					dto.setDelivery_price(rs.getInt("delivery_price"));
					dto.setHas_delivery_fee(rs.getString("has_delivery_fee"));
					
					ImgDTO imgDto = new ImgDTO();
					imgDto.setImg_num(rs.getInt("img_num"));
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
		
//		상품 30,000원 이상 주문 배송비 무료 + 단일 주문시
		public int productDeliveryOne(int product_num, int count) {
			int deliveryOne = 0;
			try {
				conn = getConn();
				sql = "select * from product where delete_yn = 'N' and product_num = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, product_num);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					ProductDTO dto = new ProductDTO();
					dto.setPrice(rs.getInt("price"));
					dto.setDelivery_price(rs.getInt("delivery_price"));
					if (dto.getPrice() * count >= 30000) {
						deliveryOne = 0;
					}else {
						deliveryOne = dto.getDelivery_price();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(conn, pstmt, rs);
			}
			return deliveryOne;
		}


//		같은 판매자의 상품 30,000원 이상 주문시 배송비 무료 + 수정) 상품별 총 결제금액 30,000원 이상 주문시 배송비 무료
		public int productDelivery(int product_num) {
			ProductDTO dto = new ProductDTO();
			CartDTO cartDto = new CartDTO();
			int sumCount = 0;
			int sumPrice = 0;
			int deliveryPrice = 0;
			try {
				conn = getConn();
				sql = "select P.*, C.product_count from product P left outer join cart C on P.product_num = C.product_num where delete_yn = 'N' and P.product_num = ? and C.product_count > 0";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, product_num);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					dto.setPrice(rs.getInt("price"));
					dto.setDelivery_price(rs.getInt("delivery_price"));
					cartDto.setProduct_count(rs.getInt("product_count"));
//					dto.setMember_num(rs.getInt("member_num"));
					sumCount = cartDto.getProduct_count();
				}
				sumPrice = sumCount * dto.getPrice();
//				System.out.println(sumPrice+"총금액");
//				System.out.println(sumCount+"총수량");
				if (sumPrice >= 30000) {
					deliveryPrice = 0;
				}else {
					deliveryPrice = dto.getDelivery_price();
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(conn, pstmt, rs);
			}
			return deliveryPrice;
		}

}
