package project.bean.contact;

import java.sql.Timestamp;

public class NoticeDTO {
	
	private int notice_num;				// 글번호
	private int member_num;				// 회원번호
	private String category;			// 분류
	private String title;				// 제목
	private String content;				// 내용
	private String img;					// 첨부파일
	private int readCount;				// 조회수
	private Timestamp reg;				// 작성일
	private String fix_yn;					// 고정여부
	
	
	public int getNotice_num() {
		return notice_num;
	}
	public void setNotice_num(int notice_num) {
		this.notice_num = notice_num;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	public String getFix_yn() {
		return fix_yn;
	}
	public void setFix_yn(String fix_yn) {
		this.fix_yn = fix_yn;
	}
	
	
	
	
	
	
}
