import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.time.LocalTime;
import java.time.LocalDate;

@WebServlet("/RecordStudySession")
public class RecordStudySessionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }
        
        String userId = (String) session.getAttribute("username");
        
        try {
            // Parse request parameters
            String startTimeStr = request.getParameter("startTime");
            String endTimeStr = request.getParameter("endTime");
            String dateRecordedStr = request.getParameter("dateRecorded"); // Add this line
            
            LocalTime startTime = LocalTime.parse(startTimeStr);
            LocalTime endTime = LocalTime.parse(endTimeStr);
            LocalDate dateRecorded = LocalDate.parse(dateRecordedStr); // Parse the date from client
            
            // Create and save study session
            StudySession studySession = new StudySession(startTime, endTime, dateRecorded);
            StudySessionDao dao = new StudySessionDao();
            int sessionId = dao.recordSession(studySession, userId);
            
            // Send success response
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": true, \"sessionId\": " + sessionId + "}");
            
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"success\": false, \"error\": \"" + e.getMessage() + "\"}");
        }
    }
}