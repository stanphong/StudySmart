import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class URegister
 */
@WebServlet("/URegister")
public class URegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public URegister() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userID = request.getParameter("userID"); 
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String profilePicture = request.getParameter("profilePicture");
		User user = new User(userID, email, name, password, profilePicture);
		UserRegisterDao urDao = new UserRegisterDao();
		int result = urDao.insert(user);
		
		boolean isValidUser = urDao.validateUser(userID, password);
		
		if (isValidUser) {
            // This code sends you to home page if login is a success            
            HttpSession session = request.getSession();
            session.setAttribute("username", userID);
            session.setAttribute("user", user);
            response.sendRedirect("homePage.jsp");
            
        } else {
            response.sendRedirect("loginPage.jsp?error=1");
        }
	}

}
