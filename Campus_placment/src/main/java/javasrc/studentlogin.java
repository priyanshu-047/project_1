package javasrc;
import java.io.*;
import java.sql.*;

import javax.naming.Context;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/log")
public class studentlogin extends HttpServlet {
    
    // JDBC configuration
    private String jdbcURL = "jdbc:mysql://localhost:3306/campus";
    private String jdbcUsername = "root";
    private String jdbcPassword = "";
    
    private static final String LOGIN_SQL = "SELECT * FROM student_login WHERE email = ? AND password = ?";

    // Initialize JDBC connection
    protected Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");  // MySQL JDBC Driver
            return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (ClassNotFoundException | SQLException e) {
            throw new SQLException("Database connection error.", e);
        }
    }

    // Handle POST request for login
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("in");
        String email = request.getParameter("student_email");
        String password = request.getParameter("student_password");
        
        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("errorMessage", "Email or password cannot be empty.");
            request.getRequestDispatcher("student.jsp").forward(request, response);
            return;
        }

        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(LOGIN_SQL)) {

            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);
            
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                // User is authenticated
                HttpSession session = request.getSession();
                session.setAttribute("userEmail", email);
                String id=  "" +  resultSet.getInt("id");
                session.setAttribute("id", id);
                String name1=resultSet.getString("name");
                System.out.println("name"+name1);
                session.setAttribute("name1", name1);
                System.out.println("id ="+id);
                int cgpa=     resultSet.getInt("cgpa");
                session.setAttribute("cgpa", cgpa);
                byte[] imageBytes=  resultSet.getBytes("img");
                System.out.println(imageBytes);
                String pathString=String.format("D:\\java_2024\\Campus_placment\\src\\main\\webapp\\upload\\%s.jpg",id);
                OutputStream outputStream=new FileOutputStream(pathString);
                 outputStream.write(imageBytes);
                
                response.sendRedirect("student_home.jsp"); // Redirect to the welcome page
            } else {
                // Invalid login
                request.setAttribute("errorMessage", "Invalid email or password.");
                request.getRequestDispatcher("welcome.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while accessing the database.");
            request.getRequestDispatcher("welcome.jsp").forward(request, response);
        }
        System.out.println("out");
        
    }
}
