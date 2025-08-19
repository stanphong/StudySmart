import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UpdateProfileDao {
	private String dburl = dbConnectorInfo.dburl();
	private String dbuname = dbConnectorInfo.dbuname();
	private String dbpassword = dbConnectorInfo.dbpassword();
	private String dbdriver = dbConnectorInfo.dbdriver();

	public void loadDriver(String dbdriver) {
			try {
					Class.forName(dbdriver);
			} catch (ClassNotFoundException e) {
					e.printStackTrace();
			}
	}

	public Connection getConnection() {
			Connection con = null;
			try {
					con = DriverManager.getConnection(dburl, dbuname, dbpassword);
			} catch (SQLException e) {
					e.printStackTrace();
			}
			return con;
	}

	public boolean updateUser(User user) {
			loadDriver(dbdriver);
			Connection con = getConnection();
			boolean success = false;

			String sql = "UPDATE user SET name = ?, email = ?, password = ?, profilePicture = ? WHERE user_id = ?";

			try (PreparedStatement ps = con.prepareStatement(sql)) {
					ps.setString(1, user.getName());
					ps.setString(2, user.getEmail());
					ps.setString(3, user.getPassword());
					ps.setString(4, user.getProfilePicture());
					ps.setString(5, user.getuser_id());

					int rowsAffected = ps.executeUpdate();
					success = rowsAffected > 0;
			} catch (SQLException e) {
					e.printStackTrace();
			} finally {
					try {
							if (con != null) con.close();
					} catch (SQLException e) {
							e.printStackTrace();
					}
			}
			return success;
	}
}