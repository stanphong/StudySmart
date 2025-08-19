
public class Assignment {

	private int assignmentId;
	private String name;
	private String description;
	private double grade;
	private double maxGrade;
	private double weight;
	
	//Constructors
	public Assignment(int assignmentId, String name, String description, double grade, double maxGrade, double weight) {
		this.name = name;
		this.description = description;
		this.grade = grade;
		this.maxGrade = maxGrade;
		this.weight = weight;
	}
	
	public Assignment() {
		
	}

	
	//Getters and Setters
	public int getAssignmentId() {
		return assignmentId;
	}
	
	public void setAssignmentId(int assignmentId) {
		this.assignmentId = assignmentId;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public double getGrade() {
		return grade;
	}

	public void setGrade(double grade) {
		this.grade = grade;
	}

	public double getMaxGrade() {
		return maxGrade;
	}
	
	public void setMaxGrade(double maxGrade) {
		this.maxGrade = maxGrade;
	}
	
	public double getWeight() {
		return weight;
	}

	public void setWeight(double weight) {
		this.weight = weight;
	}
}
