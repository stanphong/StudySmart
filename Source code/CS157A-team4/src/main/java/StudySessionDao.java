import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.Map;
import java.sql.Date;
import java.sql.ResultSet;

public class StudySessionDao {
  private String dburl = dbConnectorInfo.dburl();
  private String dbuname = dbConnectorInfo.dbuname();
  private String dbpassword = dbConnectorInfo.dbpassword();
  private String dbdriver = dbConnectorInfo.dbdriver();
  
  // Load driver method (same as other DAOs)
  public void loadDriver(String dbdriver) {
      try {
          Class.forName(dbdriver);
      } catch (ClassNotFoundException e) {
          e.printStackTrace();
      }
  }
  
  // Get connection method (same as other DAOs)
  public Connection getConnection() {
      Connection con = null;
      try {
          con = DriverManager.getConnection(dburl, dbuname, dbpassword);
      } catch (SQLException e) {
          e.printStackTrace();
      }
      return con;
  }
  
  // Record a new study session
  public int recordSession(StudySession session, String userId) {
      loadDriver(dbdriver);
      Connection con = getConnection();
      int sessionId = -1;
      
      String insertSessionSql = "INSERT INTO studysession (start_time, end_time, date_recorded) VALUES (?, ?, ?)";
      String insertStudiesSql = "INSERT INTO studies (user_id, session_id) VALUES (?, ?)";
      
      try {
          // Insert into studysession table
          PreparedStatement psSession = con.prepareStatement(insertSessionSql, PreparedStatement.RETURN_GENERATED_KEYS);
          psSession.setTime(1, Time.valueOf(session.getStartTime()));
          psSession.setTime(2, Time.valueOf(session.getEndTime()));
          psSession.setDate(3, Date.valueOf(session.getDateRecorded()));
          
          psSession.executeUpdate();
          
          // Get generated session_id
          ResultSet rs = psSession.getGeneratedKeys();
          if (rs.next()) {
              sessionId = rs.getInt(1);
              
              // Insert into studies table
              PreparedStatement psStudies = con.prepareStatement(insertStudiesSql);
              psStudies.setString(1, userId);
              psStudies.setInt(2, sessionId);
              psStudies.executeUpdate();
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
      return sessionId;
  }

  public Map<String, Double> getStudyData(String userId, LocalDate startDate) {
    Map<String, Double> data = new LinkedHashMap<>();
    LocalDate endDate = startDate.plusDays(6); // Get 7 days of data
    
    // Initialize map with dates
    LocalDate current = startDate;
    while (!current.isAfter(endDate)) {
        data.put(current.toString(), 0.0);
        current = current.plusDays(1);
    }

    loadDriver(dbdriver);
    Connection con = getConnection();
    
    try {
        String sql = "SELECT ss.date_recorded, " +
                    "SUM(TIMESTAMPDIFF(MINUTE, ss.start_time, ss.end_time)) as total_minutes " +
                    "FROM studysession ss " +
                    "JOIN studies st ON ss.session_id = st.session_id " +
                    "WHERE st.user_id = ? AND ss.date_recorded BETWEEN ? AND ? " +
                    "GROUP BY ss.date_recorded";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, userId);
        ps.setDate(2, Date.valueOf(startDate));
        ps.setDate(3, Date.valueOf(endDate));

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            LocalDate date = rs.getDate("date_recorded").toLocalDate();
            double hours = rs.getDouble("total_minutes") / 60.0;
            data.put(date.toString(), hours);
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
    
    return data;
  }
}