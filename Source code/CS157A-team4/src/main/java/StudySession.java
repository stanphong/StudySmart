import java.time.LocalTime;
import java.time.LocalDate;

public class StudySession {
  private int sessionId;
  private LocalTime startTime;
  private LocalTime endTime;
  private LocalDate dateRecorded;

  // Constructors
  public StudySession() {}
  
  public StudySession(LocalTime startTime, LocalTime endTime, LocalDate dateRecorded) {
      this.startTime = startTime;
      this.endTime = endTime;
      this.dateRecorded = dateRecorded;
  }

  // Getters and Setters
  public int getSessionId() { return sessionId; }
  public void setSessionId(int sessionId) { this.sessionId = sessionId; }
  public LocalTime getStartTime() { return startTime; }
  public void setStartTime(LocalTime startTime) { this.startTime = startTime; }
  public LocalTime getEndTime() { return endTime; }
  public void setEndTime(LocalTime endTime) { this.endTime = endTime; }
  public LocalDate getDateRecorded() { return dateRecorded; }
  public void setDateRecorded(LocalDate dateRecorded) { this.dateRecorded = dateRecorded; }
}