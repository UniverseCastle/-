package project.bean.enums;

public enum MemberVendor {
	WAITING_FOR_APPROVAL("0","판매자 가입 승인대기"),
	USER("1","일반회원"),
	SELLER("2","판매자 회원"),
	ADMIN("3","관리자"),
	REFUSAL_OF_APPROVAL("4","판매자 가입 승인거절");
	
	private String code;
	private String name;
	
	private MemberVendor(String code,String name) {
		this.code = code;
		this.name = name;
	};
	
	public String getCode() {
		return code;
	}
	public String getName() {
		return name;
	}
	
	// 해당 권한이 0 , 1, 2 로들어오기때문에 사용자가 보기힘들다
	// 따라서 가져온 권한에 따라 비교하고 일치하는값의 name 을 리턴 = > 사용자에게 보여줌
	public static String getNameByVendor(String vendorCode) {
		for(MemberVendor enumValue : MemberVendor.values()) {
			if(enumValue.getCode().equals(vendorCode)){
				return enumValue.getName();
			}
		}
		return "없음";
	}
}
