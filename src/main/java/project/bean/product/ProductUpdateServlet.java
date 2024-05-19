package project.bean.product;

import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import project.bean.util.ImageProcess;
import project.bean.util.Util;

@WebServlet("/productUpdate")
@MultipartConfig
public class ProductUpdateServlet extends HttpServlet {
	ProductDTO dto = new ProductDTO();
	ProductDAO dao = ProductDAO.getInstance();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		int uploadStatus = 0; 
		int totalStatus = 0; // 이미지 저장 성공 여부 상태 성공 1, 실패 0
		String fileName = ""; 
		int resultCount = 0;	// 넘어온 이미지 수 만큼 카운트
		int ad = 0;

		request.setCharacterEncoding("UTF-8");

		final String uploadPath = getServletContext().getRealPath("/views/upload");

		// 폴더가없다면 생성
		File filefolder = new File(uploadPath);
		if (!filefolder.exists()) {
			filefolder.mkdirs();
		}
		// admin 에서 넘어오면 받는 값
		if(request.getParameter("ad") != null) {
			ad = Integer.parseInt(request.getParameter("ad"));
		}
	
		// 수정 정보 저장
		ProductDTO data = dto.setProductAdd(request);

		int result = dao.updateProduct(data);

		// 삭제 할 이미지 처리
		String totalImgNums = request.getParameter("deleteList");
		
		// 삭제할 이미지가 없으면 "" 로넘어옴
		if (!(Util.isEmpty(totalImgNums))) {
			
			String[] imgNums = totalImgNums.split(",");

			Integer[] convertImgNums = new Integer[imgNums.length];

			for (int i = 0; i < convertImgNums.length; i++) {
				convertImgNums[i] = Integer.parseInt(imgNums[i]);
			}

			for (int imgNum : convertImgNums) {

				String imgName = dao.getImgName(imgNum);
				ImageProcess.deleteImg(uploadPath, imgName);
			}
		}

		// 이미지 저장
		for (Part part : request.getParts()) {
			
			fileName = ImageProcess.getFileName(part);

			// 파일이 공백이라면 continue
			if (Util.isEmpty(fileName)) {
				continue;
			}
			// 기존 썸네일 제거
			if (part.getSize() > 0 && part.getName().equals("thumbnail")) {
				String thumbnail = dao.getThumbnail(data.getProduct_num());
				ImageProcess.deleteImg(uploadPath, thumbnail);
			}
			
			uploadStatus += ImageProcess.insertImg(uploadPath, data.getProduct_num(), part, request);
			
			resultCount++;
		}
		
		int imgAddCount = dao.ImgInsertCount(data.getProduct_num());
		
		if (Util.isEmpty(fileName)) {
			totalStatus = imgAddCount;
		}
		if( resultCount == uploadStatus) {
			totalStatus = 1;
		}

		
		// 모든 처리후 포워드로 이동
		if(ad == 0) {
			request.setAttribute("totalStatus", totalStatus);
			request.setAttribute("result", result);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/views/product/productUpdatePro.jsp");
			dispatcher.forward(request, response);
		}
		if(ad == 1) {
			request.setAttribute("totalStatus", totalStatus);
			request.setAttribute("result", result);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/views/adminproduct/adminProductPro.jsp");
			dispatcher.forward(request, response);
		}
	}
}
