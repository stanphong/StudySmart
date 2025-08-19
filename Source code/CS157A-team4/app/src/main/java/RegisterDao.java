import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RegisterDao {
	private String dburl="jdbc:mysql://localhost:3306/userdb";
	private String dbuname="root";
	private String dbpassword="brawlstars";
	private String dbdriver="com.mysql.jdbc.Driver";
	public void loadDriver(String dbdriver){
		try{
			Class.forName(dbdriver);
		}catch(ClassNotFoundException e){
			e.printStackTrace();
		}
	}
	public Connection getConnection(){
		Connection con=null;
		try{
			con=DriverManager.getConnection(dburl, dbuname, dbpassword);
		}catch(SQLException e){
			e.printStackTrace();
		}
		return con;
	}
	public String insert(Member member){
		loadDriver(dbdriver);
		Connection con=getConnection();
		String result="data entered successfully";
		String sql="insert into userdb.demo values(?,?,?,?)";
		try {
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, member.getUname());
			ps.setString(2, member.getPassword());
			ps.setString(3, member.getEmail());
			ps.setString(4, member.getPhone());
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			result="data not entered";
		}
		return result;
	}
}
