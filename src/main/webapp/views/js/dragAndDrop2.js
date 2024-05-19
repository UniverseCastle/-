	const textImgDragZone = document.getElementById("textImgDragZone");
	const textImgInput = document.getElementById("textImgInput");
	const textImgPreview = document.getElementById("textImgPreview");
	const textImgCount = document.getElementById("textImgCount");
	
		    
	 // 상품설명이미지 드래그 & 드롭   
	 textImgDragZone.addEventListener("dragover", (e) => {
		e.preventDefault();
	});

	textImgDragZone.addEventListener("drop", (e) => {
	    e.preventDefault();

	    const files = e.dataTransfer.files;
	    if (files.length > 0) {
	    	displayImage(files,textImgPreview);
	    	textImgInput.files = files;
	    	textImgCount.innerText = files.length;
	    }
	 });

	 textImgDragZone.addEventListener("click", () => {
	    textImgInput.click();
	 });

	 textImgInput.addEventListener("change", () => {
	    const files = textImgInput.files;
	    if (files.length > 0) {
	       displayImage(files, textImgPreview);
	    }
	 });

	    function displayImage(files,textImgPreview) {
	    	console.log(files)
	    	 for (let i = 0; i < files.length; i++) {
	    		 const file = files[i];
	        	const reader = new FileReader();
	        	reader.onload = () => {
	        		const imgElement = document.createElement("img");
	        		imgElement.src = reader.result;
	        		imgElement.style.display = "block";
	        		imgElement.style.width = "100"
	        		imgElement.style.height = "100"
	            	imgElement.classList.add("text-preview-image");
	            	textImgPreview.appendChild(imgElement);
	       	 	};
	        	reader.readAsDataURL(file);
	    	};
	    };
	      
	    
	    