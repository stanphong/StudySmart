
public class HomePageStats {
	private String name;
	private int coursesEnrolled;
	private int numberOfTasks;
	
	//Constructor
	public HomePageStats(String name, int coursesEnrolled, int numberOfTasks) {
		this.name = name;
		this.coursesEnrolled = coursesEnrolled;
		this.numberOfTasks = numberOfTasks;
	}
	
	//Default Constructor
	public HomePageStats() {
		
	}


	//Getters and Setters
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getCoursesEnrolled() {
		return coursesEnrolled;
	}

	public void setCoursesEnrolled(int coursesEnrolled) {
		this.coursesEnrolled = coursesEnrolled;
	}

	public int getNumberOfTasks() {
		return numberOfTasks;
	}

	public void setNumberOfTasks(int numberOfTasks) {
		this.numberOfTasks = numberOfTasks;
	}
	
	
}
