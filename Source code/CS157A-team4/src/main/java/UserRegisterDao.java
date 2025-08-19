import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserRegisterDao {
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
	public int insert(User user){
		loadDriver(dbdriver);
		Connection con=getConnection();
		//String result="data entered successfully";
		int affectedRows = 0;
		
		String result="data entered successfully";
		String sql="insert into user values(?,?,?,?,?,?)";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, user.getuser_id());  
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getName());
			ps.setString(4, user.getPassword());
			ps.setString(5, user.getProfile_date_created());
			ps.setString(6, user.getProfilePicture());
			affectedRows = ps.executeUpdate();
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
		return affectedRows;
	}

	// Validate user login
    public boolean validateUser(String username, String password) {
        loadDriver(dbdriver);
        Connection con = getConnection();
        boolean isValid = false;
        String sql = "SELECT * FROM user WHERE user_id = ? AND password = ?";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            isValid = rs.next(); // Returns true if a record exists
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
        return isValid;
    }
		public User getUser(String username, String password) {
			loadDriver(dbdriver);
			Connection con = getConnection();
			User user = null;
			String query = "SELECT * FROM user WHERE user_id = ? AND password = ?";
			try (PreparedStatement stmt = con.prepareStatement(query)) {
					stmt.setString(1, username);
					stmt.setString(2, password);
	
					ResultSet rs = stmt.executeQuery();
					if (rs.next()) {
							// Create User object matching database column order
							user = new User(
									rs.getString("user_id"),  // This is the username/user_id
									rs.getString("email"),
									rs.getString("name"),
									rs.getString("password"),
									rs.getString("profilePicture")
							);
					}
			} catch (SQLException e) {
					e.printStackTrace();
			} finally {
					try {
							if (con != null) con.close();
					} catch (SQLException e) {
							e.printStackTrace();
					}
			}
			return user;
	}
}
