

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class UAddExtracurriculars
 */
@WebServlet("/UAddExtracurriculars")
public class UAddExtracurriculars extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UAddExtracurriculars() {
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
		// Retrieve extracurricular info from the form 
        String activityName = request.getParameter("activityName");
        String description = request.getParameter("description");
        String start_date_str = request.getParameter("startDate");
        String end_date_str = request.getParameter("endDate");

        // Retrieve user_id from session
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("username");

        // Initialize extracurricular object and set fields
        Extracurricular extracurricular = new Extracurricular();
        extracurricular.setActivityName(activityName);
        extracurricular.setDescription(description);

        // Parse the start and end date string into LocalDate and handle possible errors
        try {
            LocalDate startDate = LocalDate.parse(start_date_str);
            LocalDate endDate = LocalDate.parse(end_date_str);
            extracurricular.setStart_date(startDate);
            extracurricular.setEnd_date(endDate);
        } catch (DateTimeParseException e) {
            response.getWriter().print("Invalid date format.");
            return;
        }

        // Call ExtracurricularDao to insert the extracurricular into the database and associate it with user_id
        ExtracurricularDao ecDao = new ExtracurricularDao();
        String result = ecDao.insert(extracurricular, userId);
        
        response.sendRedirect("myExtracurriculars.jsp");
	}

}
