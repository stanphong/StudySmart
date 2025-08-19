import java.io.IOException;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UpdateProgress")
public class UpdateProgress extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("loginPage.jsp");
            return;
        }

        String userId = (String) session.getAttribute("username");
        String taskIdStr = request.getParameter("taskId");
        String progressStr = request.getParameter("progress");

        try {
            int taskId = Integer.parseInt(taskIdStr);
            int progress = Integer.parseInt(progressStr);
            TaskDao taskDao = new TaskDao();
            
            // Get current task to check due date
            Task task = taskDao.getTaskById(taskId, userId);
            
            // Update status based on progress and due date
            String newStatus = calculateStatus(progress, task.getDueDate());
            
            // Update both progress and status
            taskDao.updateTaskProgressAndStatus(taskId, userId, progress, newStatus);
            
            response.sendRedirect("UWorkStation?taskId=" + taskId);
        } catch (NumberFormatException e) {
            response.sendRedirect("myTask.jsp");
        }
    }
    
    private String calculateStatus(int progress, LocalDate dueDate) {
        LocalDate today = LocalDate.now();
        
        if (progress == 100) {
            return "Completed";
        } else if (today.isAfter(dueDate)) {
            return "Overdue";
        } else {
            return "Pending";
        }
    }
}