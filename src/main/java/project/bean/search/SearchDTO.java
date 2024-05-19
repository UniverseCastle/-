package project.bean.search;

public class SearchDTO {
	private int start;//해당페이지에서 상품 시작번호
	
	private int end;// 해당페이지에서 상품 끝번호
	
	private String keyWord;	// 검색 키워드
	
	private String sortName;	//정렬 기준 컬럼
	
	private String sort;			// 정렬방식

	
	
	public SearchDTO(int start, int end, String keyWord, String sortName, String sort) {
		this.start = start;
		this.end = end;
		this.keyWord = keyWord;
		this.sortName = sortName;
		this.sort = sort;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public String getKeyWord() {
		return keyWord;
	}

	public void setKeyWord(String keyWord) {
		this.keyWord = keyWord;
	}

	public String getSortName() {
		return sortName;
	}

	public void setSortName(String sortName) {
		this.sortName = sortName;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}
}
