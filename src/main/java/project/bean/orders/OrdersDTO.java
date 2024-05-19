package project.bean.orders;

import java.sql.Timestamp;

public class OrdersDTO {
	private int orders_num;				// 주문 시퀀스
	private int member_num;				// 회원 시퀀스
	private int product_num;			// 상품 시퀀스
	private int delivery_num;			// 배송지 시퀀스
	private int img_num;				// 이미지 시퀀스
	private String orders_status;		// 주문 상태
	private String delivery_status;		// 배송 상태
	private String request_status;		// 신청 상태
	private int count;					// 주문 수량
	private Timestamp orders_date;		// 주문 날짜
	private String orders_name;			// 주문자 이름
	private String receiver_name;		// 받는사람 이름
	private String phone;				// 전화번호
	private String cellphone;			// 휴대폰 번호
	private String email;				// 이메일
	private String address1;			// 우편번호
	private String address2;			// 도로명 주소
	private String address3;			// 상세주소
	private int final_price;			// 최종 결제 금액
	private String payment_option;		// 결제수단
	
//	getter / setter	
	public int getOrders_num() {
		return orders_num;
	}
	public void setOrders_num(int orders_num) {
		this.orders_num = orders_num;
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
	public int getDelivery_num() {
		return delivery_num;
	}
	public void setDelivery_num(int delivery_num) {
		this.delivery_num = delivery_num;
	}
	public int getImg_num() {
		return img_num;
	}
	public void setImg_num(int img_num) {
		this.img_num = img_num;
	}
	public String getOrders_status() {
		return orders_status;
	}
	public void setOrders_status(String orders_status) {
		this.orders_status = orders_status;
	}
	public String getDelivery_status() {
		return delivery_status;
	}
	public void setDelivery_status(String delivery_status) {
		this.delivery_status = delivery_status;
	}
	public String getRequest_status() {
		return request_status;
	}
	public void setRequest_status(String request_status) {
		this.request_status = request_status;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public Timestamp getOrders_date() {
		return orders_date;
	}
	public void setOrders_date(Timestamp orders_date) {
		this.orders_date = orders_date;
	}
	public String getOrders_name() {
		return orders_name;
	}
	public void setOrders_name(String orders_name) {
		this.orders_name = orders_name;
	}
	public String getReceiver_name() {
		return receiver_name;
	}
	public void setReceiver_name(String receiver_name) {
		this.receiver_name = receiver_name;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getCellphone() {
		return cellphone;
	}
	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getAddress3() {
		return address3;
	}
	public void setAddress3(String address3) {
		this.address3 = address3;
	}
	public int getFinal_price() {
		return final_price;
	}
	public void setFinal_price(int final_price) {
		this.final_price = final_price;
	}
	public String getPayment_option() {
		return payment_option;
	}
	public void setPayment_option(String payment_option) {
		this.payment_option = payment_option;
	}
}