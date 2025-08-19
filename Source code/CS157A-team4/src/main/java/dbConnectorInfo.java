
public class dbConnectorInfo {
	
	/*
	 * The purpose of this class is so that you only have to fill in your db info (like password) once
	 * without having to change them for all the Dao classes
	 * 
	 * If you wish to create a new Dao class then copy this into it:
	 * 
	  	private String dburl= dbConnectorInfo.dburl();
		private String dbuname= dbConnectorInfo.dbuname();
		private String dbpassword= dbConnectorInfo.dbpassword(); 
		private String dbdriver= dbConnectorInfo.dbdriver();
	 */
	
	private static String dburl="jdbc:mysql://localhost:3306/studysmart";
	private static String dbuname="root";
	private static String dbpassword="#Ben01226723853"; //Remember to put your own password
	private static String dbdriver="com.mysql.jdbc.Driver";
	
	public static String dburl() {
		return dburl;
	}
	
	public static String dbuname() {
		return dbuname;
	}
	
	public static String dbpassword() {
		return dbpassword;
	}
	
	public static String dbdriver() {
		return dbdriver;
	}
}
