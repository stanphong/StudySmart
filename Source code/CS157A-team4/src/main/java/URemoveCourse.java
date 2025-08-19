

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class URemoveCourse
 */
@WebServlet("/URemoveCourse")
public class URemoveCourse extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public URemoveCourse() {
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
		String courseId = request.getParameter("courseId");
		
		HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("username");
		
        //for debugging
        System.out.println("Deleting from courses with course_id: " + courseId);
        System.out.println("Deleting from enrolled with course_id: " + courseId + " and user_id: " + userId);
        
		try {
			CourseDao courseDao = new CourseDao();
			courseDao.deleteCourseById(Integer.parseInt(courseId), userId);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		response.sendRedirect("myCourses.jsp");
	}

}
