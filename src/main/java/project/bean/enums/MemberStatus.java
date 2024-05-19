package project.bean.enums;

public enum MemberStatus {
	MEMBERSHIP("1","가입"),
	MEMBERSHIP_WITHDRAWAL("2", "탈퇴");
	
	private String code;
	private String name;
	
	private MemberStatus(String code, String name) {
		this.code = code;
		this.name = name;
	};
	
	public String getCode() {
		return code;
	}
	public String getName() {
		return name;
	}
	
	//가져온 권한에 따라 비교하고 일치하는값의 name 을 리턴 = > 사용자에게 보여줌
	public static String getNameByStatus(String statusCode) {
		for(MemberStatus enumValue : MemberStatus.values()) {
			if(enumValue.getCode().equals(statusCode)) {
				return enumValue.getName();
			}
		}
		return "없음";
	}
}
