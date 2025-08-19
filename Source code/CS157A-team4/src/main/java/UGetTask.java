import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializer;
import com.google.gson.JsonSerializationContext;
import java.lang.reflect.Type;
import java.time.LocalDate;

@WebServlet("/UGetTask")
public class UGetTask extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UGetTask() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set response headers first
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("username") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\": \"Unauthorized\"}");
            return;
        }

        try {
            // Parse taskId as integer
            int taskId = Integer.parseInt(request.getParameter("taskId"));
            String userId = (String) session.getAttribute("username");

            TaskDao taskDao = new TaskDao();
            Task task = taskDao.getTaskById(taskId, userId);
            
            if (task != null) {
                String json = convertTaskToJson(task);
                response.getWriter().write(json);
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\": \"Task not found\"}");
            }
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"Invalid task ID format\"}");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Internal server error\"}");
            e.printStackTrace();
        }
    }

    private String convertTaskToJson(Task task) {
        GsonBuilder gsonBuilder = new GsonBuilder();
        
        // Add LocalDate serializer
        gsonBuilder.registerTypeAdapter(LocalDate.class, new JsonSerializer<LocalDate>() {
            @Override
            public JsonElement serialize(LocalDate date, Type typeOfSrc, JsonSerializationContext context) {
                return new JsonPrimitive(date.toString());
            }
        });
        
        Gson gson = gsonBuilder.create();
        return gson.toJson(task);
    }
}