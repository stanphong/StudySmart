public class Course {
    private String courseId;
    private String name;
    private String instructor;
    private String startDate;
    private String endDate;

    public Course(String courseId, String name, String instructor, String startDate, String endDate) {
        this.courseId = courseId;
        this.name = name;
        this.instructor = instructor;
        this.startDate = startDate;
        this.endDate = endDate;
    }

	public String getCourseId() {
		return courseId;
	}

	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getInstructor() {
		return instructor;
	}

	public void setInstructor(String instructor) {
		this.instructor = instructor;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

    
}
