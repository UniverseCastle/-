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

@WebServlet("/productAdd")
@MultipartConfig
public class ProductAddServlet extends HttpServlet{
	
	ProductDTO dto  = new ProductDTO();
	ProductDAO dao = ProductDAO.getInstance();
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		
		int uploadStatus = 0;
		String fileName="";	
		int resultCount = 0;	// 넘어온 이미지 수 만큼 카운트
		int totalStatus = 0; // 이미지 저장 성공 여부 상태 성공 1, 실패 0
		final String uploadPath =getServletContext().getRealPath("/views/upload");
		
		
		File filefolder = new File(uploadPath);
		if(!filefolder.exists()) {
			filefolder.mkdirs();
		}
		
		request.setCharacterEncoding("UTF-8");
		
		

			ProductDTO data =  dto.setProductAdd(request);
			
			
			
			
			
			int product_num = dao.saveProduct(data);
			for(Part part : request.getParts()) {
				fileName = ImageProcess.getFileName(part);
				
				if(Util.isEmpty(fileName)) {
					continue;
				}
				 
				uploadStatus += ImageProcess.insertImg(uploadPath,product_num, part, request);
				resultCount++;
			}
			int imgAddCount = dao.ImgInsertCount(product_num);
			if(resultCount == imgAddCount && resultCount == uploadStatus) {
				totalStatus = 1;
			}
			request.setAttribute("totalStatus", totalStatus);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/views/product/productInsertPro.jsp");
			dispatcher.forward(request, response);
	}
	

}









