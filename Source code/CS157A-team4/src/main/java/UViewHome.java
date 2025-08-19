import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UViewHome")
public class UViewHome extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    public UViewHome() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Retrieve user_id from session
        HttpSession session = request.getSession();
        String userId = (String) session.getAttribute("username");
        
        // If user is not logged in, redirect to login page
        if (userId == null || userId.isEmpty()) {
            response.sendRedirect("loginPage.jsp");
            return;
        }

        // Call homeDao to retrieve info about the homepage 
        HomeDao homeDao = new HomeDao();
        HomePageStats currentHomePage = homeDao.getHomePageStats(userId);
        
        // Calculate study hours for current week
        LocalDate startDate = LocalDate.now()
            .with(TemporalAdjusters.previousOrSame(DayOfWeek.MONDAY));
        StudySessionDao studyDao = new StudySessionDao();
        Map<String, Double> studyData = studyDao.getStudyData(userId, startDate);
        System.out.println("Study Data: " + studyData);

        // Calculate total study hours for the week
        double totalHours = studyData.values().stream()
            .mapToDouble(Double::doubleValue)
            .sum();

        // Set the data in the request scope to be accessible in the JSP
        request.setAttribute("homePageData", currentHomePage);
        request.setAttribute("weeklyStudyHours", String.format("%.1f", totalHours));
        
        // Forward to the JSP page that will display the home page
        request.getRequestDispatcher("homePage.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}