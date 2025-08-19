import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ResourceServlet")
public class ResourceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("loginPage.jsp");
            return;
        }
        
        String userId = (String) session.getAttribute("username");
        String action = request.getParameter("action");
        String taskIdStr = request.getParameter("taskId");
        
        try {
            int taskId = Integer.parseInt(taskIdStr);
            TaskDao taskDao = new TaskDao();
            
            if ("add".equals(action)) {
                String url = request.getParameter("url");
                String displayText = request.getParameter("displayText");
                
                // If displayText is empty, use the URL as display text
                if (displayText == null || displayText.trim().isEmpty()) {
                    displayText = url;
                }
                String resourceType = Resource.detectResourceType(url);
                
                taskDao.addResource(taskId, url, displayText, resourceType);
            } else if ("delete".equals(action)) {
                String resourceIdStr = request.getParameter("resourceId");
                int resourceId = Integer.parseInt(resourceIdStr);
                taskDao.deleteResource(resourceId, userId);
            }
            
            response.sendRedirect("UWorkStation?taskId=" + taskId);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("myTask.jsp");
        }
    }
}