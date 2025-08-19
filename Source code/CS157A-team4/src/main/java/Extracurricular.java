import java.time.LocalDate;

public class Extracurricular {
	private int extracurricularId;		//corresponds to extracurricular_id (primary key, auto increments) 
	private String activityName; 	//corresponds to activity_name
	private String description; 	//corresponds to description
	private LocalDate start_date;   //corresponds to start_date
	private LocalDate end_date;		//corresponds to end_date
	
	//Constructor
	public Extracurricular(int extracurricularId, String activityName, String description, LocalDate start_date, LocalDate end_date) {
		super();
		this.extracurricularId = extracurricularId;
		this.activityName = activityName;
		this.description = description;
		this.start_date = start_date;
		this.end_date = end_date;
	}

	//default constructor
	public Extracurricular() {}

	//getters and setters
	public int getExtracurricularId() {
		return extracurricularId;
	}

	public void setExtracurricularId(int extracurricularId) {
		this.extracurricularId = extracurricularId;
	}

	public String getActivityName() {
		return activityName;
	}

	public void setActivityName(String activityName) {
		this.activityName = activityName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public LocalDate getStart_date() {
		return start_date;
	}

	public void setStart_date(LocalDate start_date) {
		this.start_date = start_date;
	}

	public LocalDate getEnd_date() {
		return end_date;
	}

	public void setEnd_date(LocalDate end_date) {
		this.end_date = end_date;
	}

	@Override
	public String toString() {
		return "Extracurricular [extracurricularId=" + extracurricularId + ", activityName=" + activityName + ", description=" + description
				+ ", start_date=" + start_date + ", end_date=" + end_date + "]";
	}
	
	
	
   
}
