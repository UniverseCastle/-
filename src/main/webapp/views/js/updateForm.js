	const deleteBtn = document.getElementById("deleteBtn");
	const cancleBtn = document.getElementById('cancelBtn');
	
	const input = document.querySelector('input[name="deleteList"]');
	
		
	// 이미지 삭제 예약 
	let deleteList = [];
	
	
	// 삭제버튼 누를시 deleteList 에 해당 값 추가
	function deleteImg(imgSid){
		deleteList.push(imgSid);
		document.getElementById(imgSid).style.opacity = "0.3";
		
		console.log(deleteList);
	}
	
	// 취소버튼 누를시 deleteList 에서 해당 값 제거
	function deleteCancel(imgSid){
		let index = deleteList.indexOf(imgSid);
		
		if(index !== -1){
			deleteList.splice(index, 1);
			document.getElementById(imgSid).style.opacity = "1";
			console.log(deleteList);
		}
	}
	// 수정완료 버튼 누를 시 배열을 하나의 덩어리로 만들어 input에 value 로  넣어주고 전송
	function listJoin(){
		input.value = deleteList.join(',');
	}
	
	// 배송비 유무에 따른 이벤트
	function showInputBox(){
		document.getElementById("d_price").style.display="block";
	}
	function closeInputBox(){
		document.getElementById("d_price").style.display="none";
	}
	