

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UDeleteAssignment
 */
@WebServlet("/UDeleteAssignment")
public class UDeleteAssignment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UDeleteAssignment() {
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
		
		String assignmentId = request.getParameter("assignmentId");
		String course_id = request.getParameter("courseId");
		String course_name = request.getParameter("courseName");
		
		//Terminal testing
		System.out.println("AssignmentID: " + assignmentId);
		System.out.println("courseId: " + course_id);
		System.out.println("courseName: " + course_name);
		
		AssignmentDao aDao = new AssignmentDao();
		
		aDao.remove(Integer.parseInt(assignmentId));
		
		String redir = "UViewAssignment?courseId=" + course_id + "&courseName=" + course_name + "";
		response.sendRedirect(redir);
	}

}
