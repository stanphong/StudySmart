import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/TaskCourseServlet")
public class TaskCourseServlet extends HttpServlet {
    private TaskDao taskDao = new TaskDao();
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("username");
        
        if (userId == null) {
            response.sendRedirect("loginPage.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        int taskId = Integer.parseInt(request.getParameter("taskId"));
        
        if ("link".equals(action)) {
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            taskDao.linkTaskToCourse(taskId, courseId);
        } else if ("unlink".equals(action)) {
            taskDao.unlinkTaskFromCourse(taskId);
        }
        
        // Redirect back to task workstation
        response.sendRedirect("UWorkStation?taskId=" + taskId);
    }
}