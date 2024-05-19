package project.bean.cart;

import java.sql.Timestamp;

public class CartDTO {
	private int cart_num;				// 장바구니 시퀀스
	private int member_num;				// 회원 시퀀스
	private int product_num;			// 상품 시퀀스
	private int product_count;			// 각 상품 개수
	private Timestamp cart_reg;			// 장바구니 추가날짜
	
//	getter/setter
	public int getCart_num() {
		return cart_num;
	}
	public void setCart_num(int cart_num) {
		this.cart_num = cart_num;
	}
	public int getMember_num() {
		return member_num;
	}
	public void setMember_num(int member_num) {
		this.member_num = member_num;
	}
	public int getProduct_num() {
		return product_num;
	}
	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}
	public int getProduct_count() {
		return product_count;
	}
	public void setProduct_count(int product_count) {
		this.product_count = product_count;
	}
	public Timestamp getCart_reg() {
		return cart_reg;
	}
	public void setCart_reg(Timestamp cart_reg) {
		this.cart_reg = cart_reg;
	}
}