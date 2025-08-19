import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UpdateNotes")
public class UpdateNotes extends HttpServlet {
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
        String quickNote = request.getParameter("quickNote");

        try {
            int taskId = Integer.parseInt(taskIdStr);
            TaskDao taskDao = new TaskDao();
            taskDao.updateTaskNotes(taskId, userId, quickNote);
            
            response.sendRedirect("UWorkStation?taskId=" + taskId);
        } catch (NumberFormatException e) {
            response.sendRedirect("myTask.jsp");
        }
    }
}