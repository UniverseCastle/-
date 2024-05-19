package project.bean.contact;

import java.sql.Timestamp;

public class QnaDTO {
	private int qna_num;			// 문의글 번호
	private int member_num;			// 회원 번호
	private String password;		// 문의글 비밀번호
	private String category;		// 분류
	private String title;			// 제목
	private int readCount;			// 조회수
	private String question;		// 내용
	private String answer;			// 답변상태
	private String img;				// 첨부파일
	private Timestamp reg;			// 문의글 등록일시
	private Timestamp reg_answer; 	// 답글 등록일시
	private String writer;			// 작성자 (비로그인)
	private String name;			// 작성자이름 (로그인)
	private String vendor;			// 회원타입
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getVendor() {
		return vendor;
	}
	public void setVendor(String vendor) {
		this.vendor = vendor;
	}
	public int getQna_num() {
		return qna_num;
	}
	public void setQna_num(int qna_num) {
		this.qna_num = qna_num;
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
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
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
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	
	
	
	
}