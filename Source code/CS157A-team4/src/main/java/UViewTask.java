import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UViewTask")
public class UViewTask extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UViewTask() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("username");
        
        if (userId == null || userId.isEmpty()) {
            response.sendRedirect("loginPage.jsp");
            return;
        }

        // Get sorting and filtering parameters
        String sortBy = request.getParameter("sortBy");
        String filterStatus = request.getParameter("filterStatus");
        
        // Call TaskDao with sorting and filtering parameters
        TaskDao taskDao = new TaskDao();

        taskDao.updateOverdueTasks();
        List<Task> tasks = taskDao.getTasksByUserId(userId, sortBy, filterStatus);
        
        // Set the tasks and current filter/sort settings in request scope
        request.setAttribute("taskList", tasks);
        request.setAttribute("currentSortBy", sortBy);
        request.setAttribute("currentFilterStatus", filterStatus);
        
        request.getRequestDispatcher("myTask.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}