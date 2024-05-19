package project.bean.img;

public class ImgDTO {
	
	private int product_num;			// 상품 시퀀스 받아와서 어떤 상품의 이미지인지 알수있게함
	
	private int img_num;				// 이미지 시퀀스
	
	private String img_name;			// 이미지 명
	
	private String original_name;	// 이미지 원본 이름
	
	private String extension;			// 이미지 확장자
	
	private String img_type;			// 이미지 타입
	
	public int getProduct_num() {
		return product_num;
	}

	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}

	public String getImg_name() {
		return img_name;
	}

	public void setImg_name(String img_name) {
		this.img_name = img_name;
	}

	public String getOriginal_name() {
		return original_name;
	}

	public void setOriginal_name(String original_name) {
		this.original_name = original_name;
	}

	public String getExtension() {
		return extension;
	}

	public void setExtension(String extension) {
		this.extension = extension;
	}

	public String getImg_type() {
		return img_type;
	}

	public void setImg_type(String img_type) {
		this.img_type = img_type;
	}

	public int getImg_num() {
		return img_num;
	}

	public void setImg_num(int img_num) {
		this.img_num = img_num;
	}

}
