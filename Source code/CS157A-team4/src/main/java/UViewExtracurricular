

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class UViewExtracurricular
 */
@WebServlet("/UViewExtracurricular")
public class UViewExtracurricular extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UViewExtracurricular() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Retrieve user_id from session
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("username");
        
        // If user is not logged in, redirect to login page
        if (userId == null || userId.isEmpty()) {
            response.sendRedirect("loginPage.jsp");
            return;
        }

        // Call ExtracurricularDao to retrieve extracurriculars for the given user_id
        ExtracurricularDao ecDao = new ExtracurricularDao();
        
        List<Extracurricular> extracurriculars = ecDao.getExtracurricularByUserId(userId);
        
        // Set the extracurriculars in the request scope to be accessible in the JSP
        request.setAttribute("extracurricularList", extracurriculars);
        
        // Forward to the JSP page that will display the extracurriculars
        request.getRequestDispatcher("myExtracurriculars.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
