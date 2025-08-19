import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ULogin")
public class ULogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ULogin() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserRegisterDao urDao = new UserRegisterDao();
        boolean isValidUser = urDao.validateUser(username, password);
        User user = urDao.getUser(username, password);
        System.out.println("isValidUser: " + isValidUser);
        System.out.println("username: " + username);
        System.out.println("password: " + password);

        if (isValidUser) {
            // response.getWriter().write("Login successful! Welcome, " + username);
            
            // This code sends you to home page if login is a success            
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            response.sendRedirect("homePage.jsp");
            session.setAttribute("user", user);
            
        } else {
            response.sendRedirect("loginPage.jsp?error=1");
            
            // This code is to bring you back to login page but we need to add a way to tell the user that login failed
            // rather than just reloading the page without any information about what happened
            
            /* 
            RequestDispatcher dispatcher = request.getRequestDispatcher("loginPage.jsp");
            request.setAttribute("errorMessage", "Invalid login. Please try again.");
            dispatcher.forward(request, response);
            */
        }
    }
}
