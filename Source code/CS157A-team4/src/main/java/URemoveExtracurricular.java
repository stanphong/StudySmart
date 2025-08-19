

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class URemoveExtracurricular
 */
@WebServlet("/URemoveExtracurricular")
public class URemoveExtracurricular extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public URemoveExtracurricular() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String extracurricularId = request.getParameter("extracurricularId");
		
		HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("username");
		
        //for debugging
        System.out.println("Deleting from extracurricular with extracurricular_id: " + extracurricularId);
        System.out.println("Deleting from involvedin with extracurricular_id: " + extracurricularId + " and user_id: " + userId);
        
		try {
			ExtracurricularDao ecDao = new ExtracurricularDao();
			ecDao.deleteExtracurricularById(Integer.parseInt(extracurricularId), userId);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		response.sendRedirect("myExtracurriculars.jsp");
	}

}
