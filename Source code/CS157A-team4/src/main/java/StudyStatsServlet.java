import java.io.IOException;
import java.sql.*;
import java.time.*;
import java.time.temporal.TemporalAdjusters;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.google.gson.Gson;
import java.sql.Date;

@WebServlet("/StudyStats")
public class StudyStatsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("username");
        
        if (userId == null) {
            response.sendRedirect("loginPage.jsp");
            return;
        }

        // Get week offset parameter (0 = current week, -1 = last week, 1 = next week, etc.)
        int weekOffset = 0;
        try {
            weekOffset = Integer.parseInt(request.getParameter("week") != null ? 
                        request.getParameter("week") : "0");
        } catch (NumberFormatException e) {
            weekOffset = 0;
        }

        // Calculate the start date for the requested week
        LocalDate startDate = LocalDate.now().plusWeeks(weekOffset)
                                     .with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));

        StudySessionDao dao = new StudySessionDao();
        Map<String, Double> studyData = dao.getStudyData(userId, startDate);
        
        // Convert to JSON using Gson
        Gson gson = new Gson();
        String jsonData = gson.toJson(studyData);
        
        // Set attributes for JSP
        request.setAttribute("studyDataJson", jsonData);
        request.setAttribute("currentWeek", weekOffset);
        request.setAttribute("weekStart", startDate);
        request.setAttribute("weekEnd", startDate.plusDays(6));
        
        request.getRequestDispatcher("myStudySessions.jsp").forward(request, response);
    }
}