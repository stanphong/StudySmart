import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UDeleteTask")
public class UDeleteTask extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UDeleteTask() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve user_id from session
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("username"); // Assuming username corresponds to user_id

        // Get the task ID from the request
        String taskIdStr = request.getParameter("taskId");
        
        try {
            // Parse the task ID
            int taskId = Integer.parseInt(taskIdStr);
            
            // Call TaskDao to delete the task
            TaskDao taskDao = new TaskDao();
            boolean result = taskDao.deleteTask(taskId, userId);
            System.out.println("Task deleted: " + result);
            
            // Redirect back to the task list page
            response.sendRedirect("myTask.jsp");
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("myTask.jsp");
        }
    }
}