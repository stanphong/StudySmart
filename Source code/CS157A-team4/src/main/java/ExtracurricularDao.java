import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ExtracurricularDao {
	
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
	  
	  public String insert(Extracurricular ec, String userId) {
		  	loadDriver(dbdriver);
			Connection con = getConnection();
			String result = "Extracurricular entered successfully";
			String extracurricularInsertSql = "INSERT INTO extracurricular (activity_name, description, start_date, end_date) VALUES (?, ?, ?, ?)";
			String involvedInInsertSql = "INSERT INTO involvedin (user_id, extracurricular_id) VALUES (?, ?)";
			
			try {
				// Insert extracurricular and retrieve generated extracurricular_id
				PreparedStatement psExtracurricular = con.prepareStatement(extracurricularInsertSql, PreparedStatement.RETURN_GENERATED_KEYS);
				psExtracurricular.setString(1, ec.getActivityName());
				psExtracurricular.setString(2, ec.getDescription());
				psExtracurricular.setDate(3, java.sql.Date.valueOf(ec.getStart_date()));
				psExtracurricular.setDate(4, java.sql.Date.valueOf(ec.getEnd_date()));
				
				int affectedRows = psExtracurricular.executeUpdate();

				if (affectedRows == 0) {
						throw new SQLException("Inserting extracurricular failed, no rows affected.");
				}
				
				// Get the generated extracurricular_id
				ResultSet generatedKeys = psExtracurricular.getGeneratedKeys();
				if (generatedKeys.next()) {
						int extracurricularId = generatedKeys.getInt(1);

						// Insert into enrolled table (user_id and extracurricular_id)
						PreparedStatement psEnrolled = con.prepareStatement(involvedInInsertSql);
						psEnrolled.setString(1, userId); // Set user_id
						psEnrolled.setInt(2, extracurricularId);    // Set extracurricular_id
						psEnrolled.executeUpdate();
				} else {
						throw new SQLException("Inserting extracurricular failed, no ID obtained.");
				}
			} catch (SQLException e) {
					e.printStackTrace();
					result = "extracurricular not entered";
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
	  
	public String deleteExtracurricularById(int extracurricular_id, String userId) throws SQLException {
		loadDriver(dbdriver);
		Connection con = getConnection();
		String result = "Extracurricular deleted sucessfully";
		
		try {
			String extracurricularSql = "DELETE FROM extracurricular WHERE extracurricular_id = ?";
			String involvedInSql = "DELETE FROM involvedin WHERE extracurricular_id = ? AND user_id = ?";
			PreparedStatement ps = con.prepareStatement(extracurricularSql);
			PreparedStatement ps1 = con.prepareStatement(involvedInSql);
			ps.setInt(1, extracurricular_id);
			ps1.setInt(1, extracurricular_id);
			ps1.setString(2, userId);
			
			con.setAutoCommit(false); // Start transaction
		    ps1.executeUpdate(); // Delete from involvedIn
		    ps.executeUpdate(); // Delete from extracurricular
		    con.commit(); // Commit transaction
		}
		catch (Exception e) {
			con.rollback(); //revert if someting goes wrong
			e.printStackTrace();
		}
		return result;
	}
	  
	// Method to retrieve all extracurriculars user is involved in by a user_id
	public List<Extracurricular> getExtracurricularByUserId(String userId) {
			loadDriver(dbdriver);
			Connection con = getConnection();
			List<Extracurricular> extracurricularList = new ArrayList<>();
			
			String sql = "SELECT e.extracurricular_id, e.activity_name, e.description, e.start_date, e.end_date " +
										"FROM extracurricular e " +
										"JOIN involvedin i ON e.extracurricular_id = i.extracurricular_id " +
										"WHERE i.user_id = ?";
			
			try {
					PreparedStatement ps = con.prepareStatement(sql);
					ps.setString(1, userId);
					ResultSet rs = ps.executeQuery();
					
					while (rs.next()) {
							Extracurricular ec = new Extracurricular();
							ec.setExtracurricularId(rs.getInt("extracurricular_id"));
							ec.setActivityName(rs.getString("activity_name"));
							ec.setDescription(rs.getString("description"));
							ec.setStart_date(rs.getDate("start_date").toLocalDate());
							ec.setEnd_date(rs.getDate("end_date").toLocalDate());
							
							extracurricularList.add(ec);
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
			return extracurricularList;
	}
}
