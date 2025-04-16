package javasrc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.eclipse.jdt.internal.compiler.ast.ReturnStatement;

import jakarta.servlet.http.HttpSession;

public class getvalues {
	 private	String validString=null;
	 private String jdbcURL = "jdbc:mysql://localhost:3306/campus";
	 private String jdbcUsername = "root";
	 private String jdbcPassword = "";
	 private static final String LOGIN_SQL = "SELECT * FROM com ";

	 protected Connection getConnection() throws SQLException {
	     try {
	         Class.forName("com.mysql.cj.jdbc.Driver");  // MySQL JDBC Driver
	         return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
	     } catch (ClassNotFoundException | SQLException e) {
	         throw new SQLException("Database connection error.", e);
	     }
	 }
	 
 public ArrayList<Com_details> getdata() throws SQLException{
	  ArrayList<Com_details> objCom_details=new ArrayList<>();
	 
	try (Connection connection = getConnection();
	             PreparedStatement preparedStatement = connection.prepareStatement(LOGIN_SQL)) {
	            ResultSet resultSet = preparedStatement.executeQuery();
              
	            
	            
	            while(resultSet.next()) {
	                Com_details o=new Com_details();
	                o.setCatString( resultSet.getString("cat"));
	                o.setLocString(resultSet.getString("location"));
	                o.setMincgp(resultSet.getInt("mincgpa"));
	                o.setSalaryString( resultSet.getInt("salary"));
	                o.setNameString(resultSet.getString("name"));
	                objCom_details.add(o);
	            } 
	}
	 return objCom_details;
	}
	 
}
