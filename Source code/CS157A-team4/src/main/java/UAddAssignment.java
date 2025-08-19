

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UAddAssignment
 */
@WebServlet("/UAddAssignment")
public class UAddAssignment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UAddAssignment() {
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
		String assignmentName = request.getParameter("assignmentName");
		String description = request.getParameter("description");
		String assignmentGrade = request.getParameter("grade");
		String assignmentMaxGrade = request.getParameter("maxgrade");
		String assignmentWeight = request.getParameter("weight");
		
		String course_id = request.getParameter("courseId");
		String course_name = request.getParameter("courseName");
		
		// Set attributes to forward to the target
	    request.setAttribute("assignmentName", assignmentName);
	    request.setAttribute("description", description);
	    request.setAttribute("grade", assignmentGrade);
	    request.setAttribute("maxgrade", assignmentMaxGrade);
	    request.setAttribute("weight", assignmentWeight);
	    request.setAttribute("courseId", course_id);
		
		Assignment assignment = new Assignment();
		assignment.setName(assignmentName);
		assignment.setDescription(description);
		assignment.setGrade(Double.parseDouble(assignmentGrade));
		assignment.setMaxGrade(Double.parseDouble(assignmentMaxGrade));
		assignment.setWeight(Double.parseDouble(assignmentWeight));
		
		AssignmentDao aDao = new AssignmentDao();
		aDao.insert(assignment, Integer.parseInt(course_id));
		
		//courseId=1&courseName=Course1
		String redir = "UViewAssignment?courseId=" + course_id + "&courseName=" + course_name + ""; 
		
		response.sendRedirect(redir);
	}

}
