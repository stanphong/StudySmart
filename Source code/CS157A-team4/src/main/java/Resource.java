public class Resource {
  private int id;
  private int taskId;
  private String url;
  private String displayText;
  private String type; // New field to store resource type
  
  // Default constructor
  public Resource() {}
  
  // Constructor with parameters
  public Resource(int id, int taskId, String url, String displayText, String type) {
      this.id = id;
      this.taskId = taskId;
      this.url = url;
      this.displayText = displayText;
      this.type = type;
  }
  
  // Getters and Setters
  public int getId() {
      return id;
  }
  
  public void setId(int id) {
      this.id = id;
  }
  
  public int getTaskId() {
      return taskId;
  }
  
  public void setTaskId(int taskId) {
      this.taskId = taskId;
  }
  
  public String getUrl() {
      return url;
  }
  
  public void setUrl(String url) {
      this.url = url;
  }
  
  public String getDisplayText() {
      return displayText != null ? displayText : url;  // Fallback to URL if displayText is null
  }
  
  public void setDisplayText(String displayText) {
      this.displayText = displayText;
  }

  public String getType() {
      return type;
  }

  public void setType(String type) {
      this.type = type;
  }

  public static String detectResourceType(String url) {
        url = url.toLowerCase();

        // Video platforms
        if (url.contains("youtube.com") || url.contains("youtu.be") ||
            url.contains("vimeo.com") || url.contains("dailymotion.com")) {
            return "video";
        }

        // Image files
        if (url.endsWith(".jpg") || url.endsWith(".jpeg") || url.endsWith(".png") ||
            url.endsWith(".gif") || url.endsWith(".bmp") || url.endsWith(".webp")) {
            return "image";
        }

        // PDF files
        if (url.endsWith(".pdf")) {
            return "pdf";
        }

        // Default to link
        return "link";
  }

    // Method to get embed URL for videos
    public String getEmbedUrl() {
        if (!"video".equals(type)) {
            return url;
        }
        
        if (url.contains("youtube.com") || url.contains("youtu.be")) {
            // Extract YouTube video ID
            String videoId = "";
            if (url.contains("youtube.com/watch?v=")) {
                videoId = url.split("v=")[1];
            } else if (url.contains("youtu.be/")) {
                videoId = url.split("youtu.be/")[1];
            }
            if (videoId.contains("&")) {
                videoId = videoId.split("&")[0];
            }
            return "https://www.youtube.com/embed/" + videoId;
        }
        
        if (url.contains("vimeo.com")) {
            // Extract Vimeo video ID
            String videoId = url.split("vimeo.com/")[1];
            return "https://player.vimeo.com/video/" + videoId;
        }
        
        return url;
    }
}