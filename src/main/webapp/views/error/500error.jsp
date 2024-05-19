<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
	body{
		display: flex;
		align-items: center;
		justify-content: center;
	}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<img src="../images/500.gif" width="40%"  >
<script>
//5초 후에 다른 페이지로 이동하는 함수
function redirectToNextPage() {
    // 이동할 페이지의 URL
    var nextPageUrl = "/project/views/main/main.jsp";

    // 5초 후에 nextPageUrl로 이동
    setTimeout(function() {
        window.location.href = nextPageUrl;
    }, 1150); // 5000 밀리초 = 5초
}

// 페이지 로드 시에 redirectToNextPage 함수 호출
window.onload = redirectToNextPage;
</script>
</body>
</html>