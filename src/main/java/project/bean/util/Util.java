package project.bean.util;

public class Util {
	// 공백체크
	public static boolean isEmpty(String fileName) {
		if(!fileName.equals("")) {
			return false;
		}
		return true;
	}
}
