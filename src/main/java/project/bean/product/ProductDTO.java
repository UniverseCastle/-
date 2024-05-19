package project.bean.product;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import project.bean.img.ImgDTO;

public class ProductDTO {

	private int product_num;					// 상품 PK/번호
	
	private int member_num;					// 회원 FK/정보
	
	private int category_num;				// 카테코리 FK/정보
	
	private String product_name;			// 상품명
	
	private String product_info;				// 상품 정보	
	 
	private int price;								// 상품 가격
	
	private int delivery_price;				// 배송비
	
	private String has_delivery_fee;		// 배송비 유무 
	
	private int stock;								// 재고
	
	private Timestamp created_date;		// 상품 등록 일시
	
	private Timestamp modified_date;	// 상품 수정 일시

	private List<ImgDTO> images;			// 조인해서 이미지 가져오기위해 사용
	
	private String category_name; 		// 카테고리이름
	
	private int first_stock;						// 최초 재고
	
	private String status;						// 상품 상태 0 - 승인대기, 1 - 승인 , 2 - 승인거절
	
	private String delete_yn;					// 상품 삭제여부
	
	private int sales_number;			//판매수량
	
	private int sales;					//매출
	
	private int sales_price;			//판매금액
	
	private String business_name;	// 제조사		member 테이블에서 제조사 컬럼을 가져오기위해 사용
	
	// getter()/setter()//
	
	public int getProduct_num() {
		return product_num;
	}

	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}

	public int getMember_num() {
		return member_num;
	}

	public void setMember_num(int member_num) {
		this.member_num = member_num;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public String getProduct_info() {
		return product_info;
	}

	public void setProduct_info(String product_info) {
		this.product_info = product_info;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getDelivery_price() {
		return delivery_price;
	}

	public void setDelivery_price(int delivery_price) {
		this.delivery_price = delivery_price;
	}

	public String getHas_delivery_fee() {
		return has_delivery_fee;
	}

	public void setHas_delivery_fee(String has_delivery_fee) {
		this.has_delivery_fee = has_delivery_fee;
	}

	public Timestamp getCreated_date() {
		return created_date;
	}

	public void setCreated_date(Timestamp created_date) {
		this.created_date = created_date;
	}

	public Timestamp getModified_date() {
		return modified_date;
	}

	public void setModified_date(Timestamp modified_date) {
		this.modified_date = modified_date;
	}


	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}


	public List<ImgDTO> getImages() {
		return images;
	}

	public void setImages(List<ImgDTO> images) {
		this.images = images;
	}

	public int getCategory_num() {
		return category_num;
	}

	public void setCategory_num(int category_num) {
		this.category_num = category_num;
	}

	public String getCategory_name() {
		return category_name;
	}

	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}

	public int getFirst_stock() {
		return first_stock;
	}

	public void setFirst_stock(int first_stock) {
		this.first_stock = first_stock;
	}

	public int getSales_number() {
		return sales_number;
	}

	public void setSales_number(int sales_number) {
		this.sales_number = sales_number;
	}

	public int getSales() {
		return sales;
	}

	public void setSales(int sales) {
		this.sales = sales;
	}

	public int getSales_price() {
		return sales_price;
	}

	public void setSales_price(int sales_price) {
		this.sales_price = sales_price;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDelete_yn() {
		return delete_yn;
	}

	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}
	
	// jsp 에 다쓰면 너무 지저분해 보여서 여기다 메서드로 따로 뺌
	// 상품정보 받아온걸 multipartReq 로 dto 에 set 함
	public ProductDTO setProductAdd(HttpServletRequest request) {
		ProductDTO dto = new ProductDTO();
		if(request.getParameter("product_num")!=null) {
			dto.setProduct_num(Integer.parseInt(request.getParameter("product_num")));
		}
		if(request.getParameter("member_num")!=null) {
			dto.setMember_num(Integer.parseInt(request.getParameter("member_num")));// 회원 고유번호
		
		}
		dto.setCategory_num(Integer.parseInt(request.getParameter("category_num")));
		dto.setProduct_name(request.getParameter("product_name"));
		dto.setProduct_info(request.getParameter("product_info"));
		dto.setPrice(Integer.parseInt(request.getParameter("price")));
		dto.setDelivery_price(Integer.parseInt(request.getParameter("delivery_price")));
		dto.setHas_delivery_fee(request.getParameter("has_delivery_fee"));
		dto.setStock(Integer.parseInt(request.getParameter("stock")));
		dto.setFirst_stock(Integer.parseInt(request.getParameter("first_stock")));
		
		return dto;
	}

	public String getBusiness_name() {
		return business_name;
	}

	public void setBusiness_name(String business_name) {
		this.business_name = business_name;
	}
	
}
