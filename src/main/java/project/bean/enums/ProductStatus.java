package project.bean.enums;

public enum ProductStatus {
	WAITING_FOR_APPROVAL_PRODUCT("0","상품 등록 승인대기"),
	APPROVAL_PRODUCT("1", "상품 등록 승인"),
	REFUSAL_PRODUCT("2","상품 등록 거절");
	
	private String code;	// 위에 상수에 "1","2" 이런번호 부분이 code
	private String name;	// 위에 상수에 "상품 등록 승인대기" 등 과같은 부분이 name
	       
	public String getCode() { // 단순 get메서드
		return code;
	}

	public String getName() { // 단순 get메서드
		return name;
	}

	private ProductStatus(String code, String name) { // 단순 생성자 단, enum 클래스는 생성자가 private 
		this.code = code;
		this.name = name;
	}
	
	// 상품 상태 코드를 받아 해당 코드의 맞는 상태 NAME 을 반환
	public static String getNameByProductStatus(String code) {
		for(ProductStatus enumValue : ProductStatus.values()) {//ProductStatus 란 객체타입의 enumValue 변수 , ProductStatus.values() =ProductStatus에 있는 모든 상수들(배열) 
			if(enumValue.getCode().equals(code)) { // ProductStatus 클래스안에 있는 상수중에서 code 부분이 매개변수로 받은 code 즉 상품의 status 값과 같으면
				return enumValue.getName();	// 해당 상수의 name 값을 리턴해준다
			}
		}
		return "없음"; // 없다면 없음이란 문자열 리턴
	}
}
