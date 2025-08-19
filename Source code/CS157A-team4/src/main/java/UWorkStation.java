import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UWorkStation")
public class UWorkStation extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UWorkStation() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("loginPage.jsp");
            return;
        }

        String userId = (String) session.getAttribute("username");
        String taskIdStr = request.getParameter("taskId");

        try {
            int taskId = Integer.parseInt(taskIdStr);
            TaskDao taskDao = new TaskDao();
            Task task = taskDao.getTaskById(taskId, userId);

            if (task != null) {
                // Get all courses for the user
                CourseDao courseDao = new CourseDao();
                List<Course> allCourses = courseDao.getCourseByUserId(userId);
                
                // Get the linked course for this task
                Course linkedCourse = taskDao.getLinkedCourse(taskId);
                
                // Remove the linked course from available courses if it exists
                if (linkedCourse != null) {
                    allCourses.removeIf(course -> course.getCourseId() == linkedCourse.getCourseId());
                }

                // Set attributes for JSP
                request.setAttribute("task", task);
                request.setAttribute("linkedCourse", linkedCourse);
                request.setAttribute("availableCourses", allCourses);
                
                request.getRequestDispatcher("taskWorkstation.jsp").forward(request, response);
            } else {
                response.sendRedirect("myTask.jsp");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("myTask.jsp");
        }
    }
}