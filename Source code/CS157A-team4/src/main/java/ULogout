import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.studysmart.User;

@WebServlet("/ULogout")
public class ULogout extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ULogout() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
HttpSession session = request.getSession(false); // Don't create a new session if it doesn't exist
        
        if (session != null) {
            session.invalidate();  // Invalidate the session, clearing all session attributes
        }

        // Redirect the user to the login page after invalidation
        response.sendRedirect("loginPage.jsp");
    }
}
