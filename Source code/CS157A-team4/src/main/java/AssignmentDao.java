import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AssignmentDao {
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
	 
	 
	 public List<Assignment> getAssignmentsByCourseId(int courseId) {
		
		 loadDriver(dbdriver);
		 Connection con = getConnection();
		 List<Assignment> aList = new ArrayList<>();
		 
		 String sql = "SELECT a.assignment_id, a.name, a.description, a.grade, a.max_grade, a.weight " + 
				 	  "FROM Assignment a " +
				 	  "JOIN AssignedBy b ON a.assignment_id = b.assignment_id " +
				 	  "WHERE b.course_id = ?";
		 
		 try {
			 
			 PreparedStatement ps = con.prepareStatement(sql);
			 ps.setInt(1, courseId);
			 ResultSet rs = ps.executeQuery();
			 
			 while(rs.next()) {
				 Assignment a = new Assignment();
				 a.setAssignmentId(rs.getInt("assignment_id"));
				 a.setName(rs.getString("name"));
				 a.setDescription(rs.getString("description"));
				 a.setGrade(rs.getDouble("grade"));
				 a.setMaxGrade(rs.getDouble("max_grade"));
				 a.setWeight(rs.getDouble("weight"));
				 
				 aList.add(a);
			 }
			 
		 } catch(Exception e) {
			 e.printStackTrace();
		 } finally {
			 try {
				 if (con != null) {
					 con.close();
				 }
			 } catch(SQLException s) {
				 s.printStackTrace();
			 }
		 }
		 
		 return aList;
	 }
	 
	 public String insert(Assignment a, int course_id) {
		  	loadDriver(dbdriver);
			Connection con = getConnection();
			String result = "Assignment entered successfully";
			String assignmentInsertSql = "INSERT INTO assignment (name, description, grade, max_grade, weight) VALUES (?, ?, ?, ?, ?)";
			String assignedByInsertSql = "INSERT INTO assignedby (assignment_id, course_id) VALUES (?, ?)";
			
			try {
				// Insert assignment and retrieve assignment_id
				PreparedStatement psAssign = con.prepareStatement(assignmentInsertSql, PreparedStatement.RETURN_GENERATED_KEYS);
				psAssign.setString(1, a.getName());
				psAssign.setString(2, a.getDescription());
				psAssign.setDouble(3, a.getGrade());
				psAssign.setDouble(4, a.getMaxGrade());
				psAssign.setDouble(5, a.getWeight());
				
				int affectedRows = psAssign.executeUpdate();

				if (affectedRows == 0) {
						throw new SQLException("Inserting course failed, no rows affected.");
				}
				
				// Get the generated course_id
				ResultSet generatedKeys = psAssign.getGeneratedKeys();
				if (generatedKeys.next()) {
						int assignmentId = generatedKeys.getInt(1);

						// Insert into assignedBy table (assignment_id and course_id)
						PreparedStatement psEnrolled = con.prepareStatement(assignedByInsertSql);
						psEnrolled.setInt(1, assignmentId); // Set assignmentId
						psEnrolled.setInt(2, course_id);    // Set course_id
						psEnrolled.executeUpdate();
				} else {
						throw new SQLException("Inserting assignment failed, no ID obtained.");
				}
			} catch (SQLException e) {
					e.printStackTrace();
					result = "assignment not entered";
			} finally {
		        try {
		            if (con != null) {
		                con.close();
		            }
		        } catch (SQLException e) {
		            e.printStackTrace();
		        }
			}
			
			return result;
	  }
	 
	 public String remove(int assignmentId) {
		 loadDriver(dbdriver);
		 Connection con = getConnection();
		 
		 String result = "Sucessfully deleted from Assignment and AssignedTo Tables";
		 String removeFromAssignment = "DELETE FROM assignment WHERE assignment_id = ?";
		 String removeFromAssignedTo = "DELETE FROM assignedby WHERE assignment_id = ?";
		 
		 try {
			 
			 PreparedStatement assignmentPs = con.prepareStatement(removeFromAssignment);
			 PreparedStatement assignedToPs = con.prepareStatement(removeFromAssignedTo);
			 
			 assignmentPs.setInt(1, assignmentId);
			 assignedToPs.setInt(1, assignmentId);
			 
			 assignedToPs.executeUpdate();
			 assignmentPs.executeUpdate();
			 
		 } catch (Exception e) {
			 e.printStackTrace();
		 } finally {
			 try {
				 if (con != null) {
					 con.close();
				 }
			 } catch (SQLException e) {
				 e.printStackTrace();
			 }
		 }
		 
		 return result;
	 }
}
