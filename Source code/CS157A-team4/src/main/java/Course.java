import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Course {
	private int courseId;		//corresponds to course_id (primary key, auto increments) 
	private String courseName; 	//corresponds to name
	private String instructor; 	//corresponds to instructor
	private LocalDate start_date;
	private LocalDate end_date;
	private String letterGrade;
	private double decimalGrade;
	private List<Assignment> assignmentsList;
	
	//Constructor
	public Course(int courseId, String courseName, String instructor, LocalDate start_date, LocalDate end_date) {
		super();
		this.courseId = courseId;
		this.courseName = courseName;
		this.instructor = instructor;
		this.start_date = start_date;
		this.end_date = end_date;
		this.decimalGrade = 0;
		assignmentsList = new ArrayList<>();
	}

	//default constructor
	public Course() {
		assignmentsList = new ArrayList<>();
		this.decimalGrade = 0;
	}

	//getters and setters
	public int getCourseId() {
		return courseId;
	}

	public void setCourseId(int courseId) {
		this.courseId = courseId;
	}

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public String getInstructor() {
		return instructor;
	}

	public void setInstructor(String instructor) {
		this.instructor = instructor;
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

	public String getLetterGrade() {
		return letterGrade;
	}
	
	public double getDecimalGrade() {
		return decimalGrade;
	}
	
	@Override
	public String toString() {
		return "Course [courseId=" + courseId + ", courseName=" + courseName + ", instructor=" + instructor
				+ ", start_date=" + start_date + ", end_date=" + end_date + "]";
	}
	
	
	//Add Assignment
	public void addAssigmnent(Assignment assignment) {
		assignmentsList.add(assignment);
	}
	
	public void addAssignmentList(List<Assignment> aList) {
		assignmentsList = aList;
	}
	
	//Derive Letter grade from number grade
	public String determineLetterGrade(double grade) {
		
		if (grade < 0) {
			return "N/A";
		}
		else if (grade < 60) {
			return "F";
		}
		else if (grade < 70) {
			return "D";
		}
		else if (grade < 80) {
			return "C";
		}
		else if (grade < 90) {
			return "B";
		}
		else if (grade < 101) {
			return "A";
		}
		
		return "N/A";
	}
	
	//Calculate Grade using all assignments in course
    public void calculateGrade() {
    	if (assignmentsList.size() == 0) {
    		letterGrade = "N/A";
    		return;
    	}
    	
    	double sum = 100;
    	
    	for (Assignment a : assignmentsList) {
    		sum -= (a.getWeight() - (a.getGrade() / a.getMaxGrade()) * a.getWeight());
    	}
    	
    	this.decimalGrade = sum;
    	this.letterGrade = determineLetterGrade(sum);
    }
}
