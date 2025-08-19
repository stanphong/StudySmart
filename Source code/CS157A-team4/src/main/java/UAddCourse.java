

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
 * Servlet implementation class UAddCourse
 */
@WebServlet("/UAddCourse")
public class UAddCourse extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UAddCourse() {
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
		// Retrieve course info from the form 
        String courseName = request.getParameter("courseName");
        String instructor = request.getParameter("instructor");
        String start_date_str = request.getParameter("startDate");
        String end_date_str = request.getParameter("endDate");

        // Retrieve user_id from session
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("username");

        // Initialize course object and set fields
        Course course = new Course();
        course.setCourseName(courseName);
        course.setInstructor(instructor);

        // Parse the start and end date string into LocalDate and handle possible errors
        try {
            LocalDate startDate = LocalDate.parse(start_date_str);
            LocalDate endDate = LocalDate.parse(end_date_str);
            course.setStart_date(startDate);
            course.setEnd_date(endDate);
        } catch (DateTimeParseException e) {
            response.getWriter().print("Invalid date format.");
            return;
        }

        // Call CourseDao to insert the course into the database and associate it with user_id
        CourseDao courseDao = new CourseDao();
        String result = courseDao.insert(course, userId);
        
        // Print result back to the user (success or failure message)
        // response.getWriter().print(result);
        
        response.sendRedirect("myCourses.jsp");
        
	}

}
