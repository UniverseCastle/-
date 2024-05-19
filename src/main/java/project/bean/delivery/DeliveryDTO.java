package project.bean.delivery;

public class DeliveryDTO {
	private int delivery_num;			//배송지 번호 - primary key
	private int member_num;				//회원 번호 - foreign key
	private String delivery_name;		//배송지 이름 - not null
	private String name;				//받으실 분 - not null
	private String address1;			//배송지 주소 - 우편번호 not null
	private String address2;			//배송지 주소 - 도로명 주소 not null
	private String address3;			//배송지 주소 - 상세 주소 not null
	private String cellphone;			//휴대폰 번호 - not null
	private String phone;				//전화 번호
	private String default_address;		//기본 배송지 여부 - 일반배송지 1 기본배송지 2
	public int getDelivery_num() {
		return delivery_num;
	}
	public void setDelivery_num(int delivery_num) {
		this.delivery_num = delivery_num;
	}
	public int getMember_num() {
		return member_num;
	}
	public void setMember_num(int member_num) {
		this.member_num = member_num;
	}
	public String getDelivery_name() {
		return delivery_name;
	}
	public void setDelivery_name(String delivery_name) {
		this.delivery_name = delivery_name;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getCellphone() {
		return cellphone;
	}
	public void setCellphone(String cellphone) {
		this.cellphone = cellphone;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getDefault_address() {
		return default_address;
	}
	public void setDefault_address(String default_address) {
		this.default_address = default_address;
	}
}
