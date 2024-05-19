package project.bean.review;

import project.bean.img.ImgDTO;
import project.bean.product.ProductDTO;


public class ReviewWrapper {

	private ReviewDTO reviewDTO;
	private ProductDTO productDTO;
	private ImgDTO imgDTO;

	//Wrapper 클래스의 생성자
	public ReviewWrapper(ReviewDTO reviewDTO, ProductDTO productDTO, ImgDTO imgDTO) {
		this.reviewDTO = reviewDTO;
		this.productDTO = productDTO;
		this.imgDTO = imgDTO;
	}

	public ReviewDTO getReviewDTO() {
		return reviewDTO;
	}

	public void setReviewDTO(ReviewDTO reviewDTO) {
		this.reviewDTO = reviewDTO;
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
	
	
}
