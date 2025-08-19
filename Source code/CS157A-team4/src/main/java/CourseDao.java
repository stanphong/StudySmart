import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CourseDao {
	
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
	  
	  public String insert(Course course, String userId) {
		  	loadDriver(dbdriver);
			Connection con = getConnection();
			String result = "Course entered successfully";
			String courseInsertSql = "INSERT INTO course (name, instructor, start_date, end_date) VALUES (?, ?, ?, ?)";
			String enrolledInsertSql = "INSERT INTO enrolled (user_id, course_id) VALUES (?, ?)";
			String insertGrade = "INSERT INTO grade (decimal_grade, letter_grade, date_recorded) VALUES (?, ?, ?)";
			String insertGradeOf = "INSERT INTO gradeof (grade_id, course_id) VALUES (?, ?)";
			
			try {
				// Insert course and retrieve generated course_id
				PreparedStatement psCourse = con.prepareStatement(courseInsertSql, PreparedStatement.RETURN_GENERATED_KEYS);
				psCourse.setString(1, course.getCourseName());
				psCourse.setString(2, course.getInstructor());
				psCourse.setDate(3, java.sql.Date.valueOf(course.getStart_date()));
				psCourse.setDate(4, java.sql.Date.valueOf(course.getEnd_date()));
				
				int affectedRows = psCourse.executeUpdate();

				if (affectedRows == 0) {
						throw new SQLException("Inserting course failed, no rows affected.");
				}
				
				int courseId = 0;
				
				// Get the generated course_id
				ResultSet generatedKeys = psCourse.getGeneratedKeys();
				if (generatedKeys.next()) {
						courseId = generatedKeys.getInt(1);

						// Insert into enrolled table (user_id and course_id)
						PreparedStatement psEnrolled = con.prepareStatement(enrolledInsertSql);
						psEnrolled.setString(1, userId); // Set user_id
						psEnrolled.setInt(2, courseId);    // Set course_id
						psEnrolled.executeUpdate();
						
						
				} else {
						throw new SQLException("Inserting course failed, no ID obtained.");
				}
				
				//Insert into Grade table
				PreparedStatement gradePs = con.prepareStatement(insertGrade, PreparedStatement.RETURN_GENERATED_KEYS);
				gradePs.setDouble(1, 100);
				gradePs.setString(2, "A");
				gradePs.setDate(3, java.sql.Date.valueOf(course.getStart_date()));
				
				gradePs.executeUpdate();
				ResultSet generatedGradeKey = gradePs.getGeneratedKeys();
				if (generatedGradeKey.next()) {
					
					int gradeId = generatedGradeKey.getInt(1);
					
					//Insert into gradeOf table
					PreparedStatement gradeOfPs = con.prepareStatement(insertGradeOf);
					gradeOfPs.setInt(1, gradeId);
					gradeOfPs.setInt(2, courseId);
					gradeOfPs.executeUpdate();
				} else {
					throw new SQLException("Inserting grade failed, no ID obtained.");
				}
				
			} catch (SQLException e) {
					e.printStackTrace();
					result = "course not entered";
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
	  
	public String deleteCourseById(int course_id, String userId) throws SQLException {
		loadDriver(dbdriver);
		Connection con = getConnection();
		String result = "Course deleted sucessfully";
		
		List<Assignment> assignList;
		
		//Delete all assignments First
		assignList = getAssignmentsByCourseId(course_id);
		for (Assignment a : assignList) {
			removeAssignment(a.getAssignmentId());
		}
		
		//Now deleting the course
		try {
			String coursesSql = "DELETE FROM course WHERE course_id = ?";
			String enrolledSql = "DELETE FROM enrolled WHERE course_id = ? AND user_id = ?";
			String gradeSql = "DELETE FROM grade WHERE grade_id = ?";
			String gradeOfSql = "DELETE FROM gradeof WHERE course_id = ?";
			PreparedStatement ps = con.prepareStatement(coursesSql);
			PreparedStatement ps1 = con.prepareStatement(enrolledSql);
			PreparedStatement ps2 = con.prepareStatement(gradeSql);
			PreparedStatement ps3 = con.prepareStatement(gradeOfSql);
			
			//Get grade_id before deleting anything
			String gradeIdSql = "SELECT grade_id FROM gradeof WHERE course_id = ?";
			PreparedStatement gradeInSqlPs = con.prepareStatement(gradeIdSql);
			gradeInSqlPs.setInt(1, course_id);
			int grade_id = -1;
			ResultSet gradeIdRs = gradeInSqlPs.executeQuery(); 
			if (gradeIdRs.next()) {
				grade_id = gradeIdRs.getInt("grade_id");
			}
			
			ps.setInt(1, course_id);
			ps1.setInt(1, course_id);
			ps1.setString(2, userId);
			ps2.setInt(1, grade_id);
			ps3.setInt(1, course_id);
			
			con.setAutoCommit(false); // Start transaction
			ps3.executeUpdate();
		    ps2.executeUpdate();
		    ps1.executeUpdate(); // Delete from enrolled
		    ps.executeUpdate(); // Delete from courses
		    con.commit(); // Commit transaction
		}
		catch (Exception e) {
			con.rollback(); //revert if someting goes wrong
			e.printStackTrace();
		}
		return result;
	}
	  
	// Method to retrieve all courses enrolled by a user_id
	public List<Course> getCourseByUserId(String userId) {
			loadDriver(dbdriver);
			Connection con = getConnection();
			List<Course> courseList = new ArrayList<>();
			
			String sql = "SELECT c.course_id, c.name, c.instructor, c.start_date, c.end_date " +
										"FROM course c " +
										"JOIN enrolled e ON c.course_id = e.course_id " +
										"WHERE e.user_id = ?";
			
			try {
					PreparedStatement ps = con.prepareStatement(sql);
					ps.setString(1, userId);
					ResultSet rs = ps.executeQuery();
					
					while (rs.next()) {
							Course course = new Course();
							
							int course_id = rs.getInt("course_id");
							
							course.setCourseId(rs.getInt("course_id"));
							course.setCourseName(rs.getString("name"));
							course.setInstructor(rs.getString("instructor"));
							course.setStart_date(rs.getDate("start_date").toLocalDate());
							course.setEnd_date(rs.getDate("end_date").toLocalDate());
							
							AssignmentDao aDao = new AssignmentDao();
							List<Assignment> assignmentList;
							assignmentList = aDao.getAssignmentsByCourseId(course_id);
							course.addAssignmentList(assignmentList);
							course.calculateGrade();
							
							courseList.add(course);
					}
			} catch (SQLException e) {
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
			return courseList;
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
	
	public String removeAssignment(int assignmentId) {
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
