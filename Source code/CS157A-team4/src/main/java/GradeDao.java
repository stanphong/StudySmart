import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class GradeDao {
	private String dburl= dbConnectorInfo.dburl();
	private String dbuname= dbConnectorInfo.dbuname();
	private String dbpassword= dbConnectorInfo.dbpassword(); //Remember to put your own password
	private String dbdriver= dbConnectorInfo.dbdriver();
	
	public void loadDriver(String dbdriver){
			try{
				Class.forName(dbdriver);
			}catch(ClassNotFoundException e){
				e.printStackTrace();
			}
		}

	 public Connection getConnection(){
			Connection con = null;
			try{
				con=DriverManager.getConnection(dburl, dbuname, dbpassword);
			}catch(SQLException e){
				e.printStackTrace();
			}
			return con;
		}
	 
	 public String insertGrade(Course course) {
		 loadDriver(dbdriver);
		 Connection con = getConnection();
		 String result = "Grade entered successfully";
		 String verifyGrade = "SELECT grade_id " +
		 					  "FROM gradeOf " +
		 					  "NATURAL JOIN grade " +
		 					  "WHERE course_id = ? ";
		 
		 String updateGrade = "UPDATE grade " +  
				 			  "SET decimal_grade = ?, letter_grade = ? " +
				 			  "WHERE grade_id = ?";
		 
		 int gradeId = -1;
		 					 
		 try {
			 PreparedStatement verifyPs = con.prepareStatement(verifyGrade);
			 verifyPs.setInt(1, course.getCourseId());
			 ResultSet rs = verifyPs.executeQuery();
			 
			 if (rs.next()) {
				 gradeId = rs.getInt(1);
			 }
			 
			 if (gradeId != -1) {
				 PreparedStatement updatePs = con.prepareStatement(updateGrade);
				 updatePs.setDouble(1, course.getDecimalGrade());
				 updatePs.setString(2, course.getLetterGrade());
				 updatePs.setInt(3, gradeId);
				 
				 updatePs.executeUpdate();
				 //System.out.println("Decimal Grade: " + course.getDecimalGrade());
				 //System.out.println("Letter: " + course.getLetterGrade());
				 //System.out.println("Successfully updated grades!");
				 
			 } else {
				 //System.out.println("Failed to update grades");
				 return "Failed to update grade";
			 }
			 
		 } catch(SQLException s1) {
			 s1.printStackTrace();
		 } finally {
			 try {
				 if (con != null) 
					 con.close();
			 } catch (SQLException s2) {
				 s2.printStackTrace();
			 }
		 }
		 
		 return result;
	 }
}
