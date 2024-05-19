package project.bean.enums;

public enum ImgType {
	productImg(1, "상품이미지"),
	textImg(2,"상품설명이미지"),
	thumbnail(3,"대표이미지");
	
	private int code;
	private String name;
	
	private ImgType(int code, String name) {
		this.code = code;
		this.name = name;
	}
	
	public int getCode() {
		return code;
	}
	
	public String getName() {
		return name;
	}

}
