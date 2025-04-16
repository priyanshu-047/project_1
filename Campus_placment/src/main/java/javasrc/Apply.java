package javasrc;
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/apply")
public class Apply extends HttpServlet {
	 // JDBC configuration
    private String jdbcURL = "jdbc:mysql://localhost:3306/campus";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";
    
    protected Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");  // MySQL JDBC Driver
            return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (ClassNotFoundException | SQLException e) {
            throw new SQLException("Database connection error.", e);
        }
    }

    private boolean checkIfUserExists(String name, String email) {
        boolean exists = false;

       
        try (Connection connection = DriverManager.getConnection(jdbcURL,jdbcUsername,jdbcPassword)) {
          
            String sql = "SELECT COUNT(*) FROM users WHERE name = ? and email = ?";

            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
          
                stmt.setString(1, name);
                stmt.setString(2, email);

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        int count = rs.getInt(1);
                        exists = (count > 0);  
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                exists = true;  
            }
        } catch (SQLException e) {
            e.printStackTrace();
            exists = true; 
        }

        return exists;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
  
    System.out.println("com in");
        response.setContentType("text/plain");
        
     
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        
        if (name == null || name.isEmpty() || email == null || email.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); 
            response.getWriter().println("Name and email are required.");
            return;
        }

        boolean exists = checkIfUserExists(name, email);
        
        if(exists) {
        	 response.setStatus(HttpServletResponse.SC_CONFLICT); 
             response.getWriter().println("allredy applied");
             return;
        }else {
        	
            try (Connection connection = DriverManager.getConnection(jdbcURL,jdbcUsername, jdbcPassword)) {
          
                String sql = "INSERT INTO users (name, email) VALUES (?, ?)";

                try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                  
                    stmt.setString(1, name);
                    stmt.setString(2, email);

                   
                    int rowsInserted = stmt.executeUpdate();

                   
                    if (rowsInserted > 0) {
                        response.setStatus(HttpServletResponse.SC_OK); // 200 OK
                        response.getWriter().println("done");
                    } else {
                        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500 Internal Server Error
                        response.getWriter().println("try again");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().println("try again");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().println("try again ");
            }
        }
       
  
    }
}
