package project.bean.member;

import java.sql.Timestamp;

public class MemberDTO {
	
	private int member_num;				//멤버 넘버 - primary key
	private String id;					//아이디
	private String vendor;				//판매자/일반회원/관리자 여부 0 판매자가입 승인 대기, 1 일반회원, 2 승인된 판매자회원, 3 관리자
	private String business_number;		//사업자 등록번호
	private String business_name;		//사업자명
	private String pw;					//비밀번호 - not null
	private String name;				//이름 - not null;
	private String email;				//이메일주소
	private String cellphone;			//핸드폰번호 - not null;
	private String phone;				//전화번호
	private String gender;				//성별 - not null;
	private String birth;				//생일 - not null;
	private String grade;				//회원등급	- default bronze;
	private Timestamp reg;				//가입일자 - default sysdate;
	private String del;					//삭제여부 - 삭제안됨 1 삭제됨 2
	private String save_id;				//아이디저장
	public int getMember_num() {
		return member_num;
	}
	public void setMember_num(int member_num) {
		this.member_num = member_num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getVendor() {
		return vendor;
	}
	public void setVendor(String vendor) {
		this.vendor = vendor;
	}
	public String getBusiness_number() {
		return business_number;
	}
	public void setBusiness_number(String business_number) {
		this.business_number = business_number;
	}
	public String getBusiness_name() {
		return business_name;
	}
	public void setBusiness_name(String business_name) {
		this.business_name = business_name;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	public String getDel() {
		return del;
	}
	public void setDel(String del) {
		this.del = del;
	}
	public String getSave_id() {
		return save_id;
	}
	public void setSave_id(String save_id) {
		this.save_id = save_id;
	}

	
}
