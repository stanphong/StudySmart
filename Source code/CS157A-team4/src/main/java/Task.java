import java.time.LocalDate;
import java.util.List;

public class Task {
    private int taskId;               // Corresponds to task_id (Primary Key, Auto Increment)
    private String taskName;           // Corresponds to task_name
    private String description;        // Corresponds to description
    private LocalDate dueDate;         // Corresponds to due_date
    private String priority;           // Corresponds to priority (enum: 'Low', 'Medium', 'High')
    private String status;             // Corresponds to status (enum: 'Pending', 'Completed', 'Overdue')
    private String type;               // Corresponds to type
    private String quickNote;    // Added field
    private int progress;        // Added field
    private List<Resource> resources;  // Add this field

    // Constructor
    public Task(int taskId, String taskName, String description, LocalDate dueDate, String priority, String status, String type) {
        this.taskId = taskId;
        this.taskName = taskName;
        this.description = description;
        this.dueDate = dueDate;
        this.priority = priority;
        this.status = status;
        this.type = type;
    }

    // Default constructor
    public Task() {}

    // Getters and Setters
    public int getTaskId() {
        return taskId;
    }

    public void setTaskId(int taskId) {
        this.taskId = taskId;
    }

    public String getTaskName() {
        return taskName;
    }

    public void setTaskName(String taskName) {
        this.taskName = taskName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public LocalDate getDueDate() {
        return dueDate;
    }

    public void setDueDate(LocalDate dueDate) {
        this.dueDate = dueDate;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getQuickNote() {
        return quickNote;
    }
    
    public void setQuickNote(String quickNote) {
        this.quickNote = quickNote;
    }
    
    public int getProgress() {
        return progress;
    }
    
    public void setProgress(int progress) {
        this.progress = progress;
    }

    public List<Resource> getResources() {
        return resources;
    }
    
    public void setResources(List<Resource> resources) {
        this.resources = resources;
    }

    @Override
    public String toString() {
        return "Task [taskId=" + taskId + ", taskName=" + taskName + ", description=" + description + 
               ", dueDate=" + dueDate + ", priority=" + priority + ", status=" + status + ", type=" + type + "]";
    }
}
