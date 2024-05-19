	const productImgDragZone = document.getElementById("productImgDragZone");
	const productImgInput = document.getElementById("productImgInput");
	const productImgPreview = document.getElementById("productImgPreview");
	const productImgCount = document.getElementById("productImgCount");


	
	// 상품이미지 드래그 & 드롭
	productImgDragZone.addEventListener("dragover", (e) => {
		e.preventDefault();
	});

	productImgDragZone.addEventListener("drop", (e) => {
	    e.preventDefault();

	    const files = e.dataTransfer.files;
	    if (files.length > 0) {
	    	displayImage(files,productImgPreview);
	    	productImgInput.files = files;
	    	productImgCount.innerText = files.length;
	    	
	    }
	 });

	 productImgDragZone.addEventListener("click", () => {
	    productImgInput.click();
	 });

	 productImgInput.addEventListener("change", () => {
	    const files = productImgInput.files;
	    if (files.length > 0) {
	       displayImage(files,productImgPreview);
	    }
	 });

	    function displayImage(files,productImgPreview) {
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
	            	imgElement.classList.add("pro-preview-image");
	            	productImgPreview.appendChild(imgElement);
	       	 	};
	        	reader.readAsDataURL(file);
	    	};
	    	
	    };

