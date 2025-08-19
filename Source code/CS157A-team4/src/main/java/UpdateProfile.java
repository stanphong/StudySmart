import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
@WebServlet("/UpdateProfile")
public class UpdateProfile extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("loginPage.jsp");
            return;
        }

        // Redirect back to profile page with edit parameter
        response.sendRedirect("myProfile.jsp?edit=true");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("loginPage.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("user");
        String name = request.getParameter("name").trim();
        String password = request.getParameter("password").trim();
        String confirmPassword = request.getParameter("passwordConfirm").trim();
        String email = request.getParameter("email").trim();

        // Validation
        if (!name.isEmpty() && name.length() < 4) {
            response.sendRedirect("myProfile.jsp?edit=true&error=1");
            return;
        }

        if (!password.isEmpty() && !password.equals(confirmPassword)) {
            response.sendRedirect("myProfile.jsp?edit=true&error=2");
            return;
        }

        // Create updated user object - maintain the user_id as username
        
        String profilePicturePath = null;

        // Get the profile picture file from the request
        Part filePart = request.getPart("profilePicture"); // "profilePicture" is the name in the form
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = filePart.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("/") + "uploads" + File.separator + fileName;
            
            // Create the uploads directory if it doesn't exist
            File uploadDir = new File(getServletContext().getRealPath("/") + "uploads");
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            
            // Write the file to the server
            try (InputStream inputStream = filePart.getInputStream()) {
                Files.copy(inputStream, Paths.get(uploadPath), StandardCopyOption.REPLACE_EXISTING);
            }
            
            // Save the path of the image
            profilePicturePath = "uploads/" + fileName; // Save the relative path to the database
            
        } else {
            // If no file was uploaded, retain the current profile picture
            profilePicturePath = currentUser.getProfilePicture();
        }
        User updatedUser = new User(
                currentUser.getuser_id(), // Keep the original user_id
                email.isEmpty() ? currentUser.getEmail() : email,
                name.isEmpty() ? currentUser.getName() : name,
                password.isEmpty() ? currentUser.getPassword() : password,
                profilePicturePath
            );
        // Update database
        UpdateProfileDao updateDao = new UpdateProfileDao();
        boolean success = updateDao.updateUser(updatedUser);

        if (success) {
            // Update session - use user_id as username
            session.setAttribute("username", updatedUser.getuser_id());
            session.setAttribute("user", updatedUser);
            response.sendRedirect("myProfile.jsp?success=1");
        } else {
            response.sendRedirect("myProfile.jsp?edit=true&error=3");
        }
    }
}