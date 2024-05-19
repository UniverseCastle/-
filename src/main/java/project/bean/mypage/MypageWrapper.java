package project.bean.mypage;

import project.bean.member.MemberDTO;
import project.bean.img.ImgDTO;
import project.bean.product.ProductDTO;
import project.bean.review.ReviewDTO;
import project.bean.orders.OrdersDTO;
import project.bean.contact.ProductQnaDTO;

public class MypageWrapper {

	private MemberDTO memberDTO;
	private ProductDTO productDTO;
	private ImgDTO imgDTO;
	private OrdersDTO ordersDTO;
	private ProductQnaDTO productQnaDTO;
	private ReviewDTO reviewDTO;

	//Wrapper 클래스의 생성자
	public MypageWrapper(ProductDTO productDTO, ImgDTO imgDTO) {
		this.productDTO = productDTO;
		this.imgDTO = imgDTO;
	}
	
	public MypageWrapper(OrdersDTO ordersDTO, ProductDTO productDTO, ImgDTO imgDTO) {
		this.ordersDTO = ordersDTO;
		this.productDTO = productDTO;
		this.imgDTO = imgDTO;
	}
	
	public MypageWrapper(ImgDTO imgDTO, MemberDTO memberDTO, ProductDTO productDTO, OrdersDTO ordersDTO) {
		this.imgDTO = imgDTO;
		this.memberDTO = memberDTO;
		this.productDTO = productDTO;
		this.ordersDTO = ordersDTO;
	}
	
	public MypageWrapper(ProductQnaDTO productQnaDTO, ProductDTO productDTO) {
		this.productQnaDTO = productQnaDTO;
		this.productDTO = productDTO;
	}
	
	public MypageWrapper(ReviewDTO reviewDTO, ProductDTO productDTO, ImgDTO imgDTO) {
		this.reviewDTO = reviewDTO;
		this.productDTO = productDTO;
		this.imgDTO = imgDTO;
	}
	
	public MemberDTO getMemberDTO() {
		return memberDTO;
	}

	public void setMemberDTO(MemberDTO memberDTO) {
		this.memberDTO = memberDTO;
	}

	public ProductDTO getProductDTO() {
		return productDTO;
	}

	public void setProductDTO(ProductDTO productDTO) {
		this.productDTO = productDTO;
	}

	public ImgDTO getImgDTO() {
		return imgDTO;
	}

	public void setImgDTO(ImgDTO imgDTO) {
		this.imgDTO = imgDTO;
	}

	public OrdersDTO getOrdersDTO() {
		return ordersDTO;
	}

	public void setOrdersDTO(OrdersDTO ordersDTO) {
		this.ordersDTO = ordersDTO;
	}

	public ProductQnaDTO getProductQnaDTO() {
		return productQnaDTO;
	}

	public void setProductQnaDTO(ProductQnaDTO productQnaDTO) {
		this.productQnaDTO = productQnaDTO;
	}

	public ReviewDTO getReviewDTO() {
		return reviewDTO;
	}

	public void setReviewDTO(ReviewDTO reviewDTO) {
		this.reviewDTO = reviewDTO;
	}
}
