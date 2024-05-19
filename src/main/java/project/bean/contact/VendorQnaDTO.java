package project.bean.contact;

import java.sql.Timestamp;

public class VendorQnaDTO {


	private int vendor_qna_num;
	private int member_num;
	private String password;
	private String title;
	private String question;
	private String answer;
	private String img;
	private Timestamp reg;
	private Timestamp reg_answer;
	private int readCount;
	private String secret_yn;
	private String delete_yn;
	private String vendor;
	private String business_name;
	
	public String getVendor() {
		return vendor;
	}
	public void setVendor(String vendor) {
		this.vendor = vendor;
	}
	public String getBusiness_name() {
		return business_name;
	}
	public void setBusiness_name(String business_name) {
		this.business_name = business_name;
	}
	public int getMember_num() {
		return member_num;
	}
	public void setMember_num(int member_num) {
		this.member_num = member_num;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	public Timestamp getReg_answer() {
		return reg_answer;
	}
	public void setReg_answer(Timestamp reg_answer) {
		this.reg_answer = reg_answer;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public int getVendor_qna_num() {
		return vendor_qna_num;
	}
	public void setVendor_qna_num(int vendor_qna_num) {
		this.vendor_qna_num = vendor_qna_num;
	}
	public String getSecret_yn() {
		return secret_yn;
	}
	public void setSecret_yn(String secret_yn) {
		this.secret_yn = secret_yn;
	}
	public String getDelete_yn() {
		return delete_yn;
	}
	public void setDelete_yn(String delete_yn) {
		this.delete_yn = delete_yn;
	}
	
	
}
