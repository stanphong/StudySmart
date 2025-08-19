import java.util.Date;
import java.text.SimpleDateFormat;

public class User {
	
	private String user_id; //username
    private String name;
    private String email;
    private String password;
    private String profile_date_created;
    private String profilePicture;
    
    public User(String user_id, String email, String name, String password, String profilePicture) {
        this.user_id = user_id; //username rather than number ID?
    	this.name = name;
        this.email = email;
        this.password = password;
        this.profilePicture = profilePicture;
        generateCreationDate();
    }

    // Getters and Setters
    public String getuser_id(){ return user_id; }
    public void setuser_id(String user_id) { this.user_id = user_id; } 
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getProfilePicture() { return profilePicture; }
    public void setProfilePicture(String profilePicture) { this.profilePicture = profilePicture; }
	public String getProfile_date_created() { return profile_date_created; }
	//MM/dd/yyyy format for setting date [ex: 2024-10-13]
	public void setProfile_date_created(String profile_date_created) { this.profile_date_created = profile_date_created; }
	public void generateCreationDate() {
		String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		this.profile_date_created = currentDate;
	}
    
    
}



