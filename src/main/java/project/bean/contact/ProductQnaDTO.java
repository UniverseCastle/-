package project.bean.contact;

import java.sql.Timestamp;

public class ProductQnaDTO {

	private int product_qna_num;		// 상품문의 글번호
	private int product_num;			// 상품번호
	private int member_num;				// 회원번호
	private String category;			// 문의분류 (배송, 교환환불, 교환변경, 기타)
	private String title;				// 제목
	private String question;			// 질문
	private String answer;				// 답변
	private String password;			// 비밀번호
	private String img;					// 첨부파일
	private int readCount;				// 조회수
	private Timestamp reg;				// 작성시간
	private Timestamp reg_answer;		// 답변시간
	private String secret_yn;			// 비밀여부
	private String delete_yn;			// 삭제여부
	
	private int catetgory_num;			// 카테고리넘버
	private String img_name;			// 이미지이름
	private String category_name;		// 상품카테고리
	private String product_name;		// 상품이름
	private String member_name;			// 회원이름
	
	
	public int getProduct_qna_num() {
		return product_qna_num;
	}
	public void setProduct_qna_num(int product_qna_num) {
		this.product_qna_num = product_qna_num;
	}
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
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
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
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
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


	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public String getImg_name() {
		return img_name;
	}
	public void setImg_name(String img_name) {
		this.img_name = img_name;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public int getCatetgory_num() {
		return catetgory_num;
	}
	public void setCatetgory_num(int catetgory_num) {
		this.catetgory_num = catetgory_num;
	}
	
	
	
}