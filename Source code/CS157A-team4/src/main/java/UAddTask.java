import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UAddTask")
public class UAddTask extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UAddTask() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve task information from the form (submitted by the user)
        String taskName = request.getParameter("taskName");
        String description = request.getParameter("description");
        String dueDateStr = request.getParameter("dueDate");
        String priority = request.getParameter("priority");
        String status = request.getParameter("status");
        String type = request.getParameter("type");

        // Retrieve user_id from session
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("username"); // Assuming username corresponds to user_id

        // Initialize task object and set fields
        Task task = new Task();
        task.setTaskName(taskName);
        task.setDescription(description);
        task.setPriority(priority);
        task.setStatus(status);
        task.setType(type);

        // Parse the due date string into LocalDate and handle possible errors
        try {
            LocalDate dueDate = LocalDate.parse(dueDateStr);
            task.setDueDate(dueDate);
        } catch (DateTimeParseException e) {
            response.getWriter().print("Invalid date format.");
            return;
        }

        // Call TaskDao to insert the task into the database and associate with user_id
        TaskDao taskDao = new TaskDao();
        String result = taskDao.insert(task, userId);
        
        // Print result back to the user (success or failure message)
        // response.getWriter().print(result);
        response.sendRedirect("myTask.jsp");
    }
}
