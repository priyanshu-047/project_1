package javasrc;



import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/enter")
public class com_entry extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get data from form
    	System.out.println("enter in enter");
    	 RequestDispatcher rDispatcher=request.getRequestDispatcher("admin_dash.jsp");
        String name = request.getParameter("name");
        String cat = request.getParameter("cat");
        String loc = request.getParameter("loc");
        String sal = request.getParameter("sal");
        String mincgpa = request.getParameter("mincgpa");

        // Database credentials
        String jdbcURL = "jdbc:mysql://localhost:3306/campus"; // Change this to your DB URL
        String dbUser = "root"; // Replace with your database username
        String dbPassword = ""; // Replace with your database password

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            // Establish a connection to the database
            Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL JDBC driver
            connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // SQL query to insert data
            String sql = "INSERT INTO com(name,cat ,location,salary,mincgpa) VALUES (?,?,?,?,?)"; // Make sure table 'users' exists in your DB
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, cat);
            preparedStatement.setString(3, loc);
            preparedStatement.setString(4,sal );
            preparedStatement.setString(5,mincgpa );

            // Execute the query
            int rowsAffected = preparedStatement.executeUpdate();

            // Provide feedback to the user
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
           
            out.println("<html><body>");
            if (rowsAffected > 0) {
                out.println("<h3 style=\"text-align: center\">Data successfully inserted!</h3>");
              
            } else {
            	out.println("<h3>Error inserting data.</h3>");
            	
                
            }
            out.println("</body></html>");

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().println("<h3>Error occurred: " + e.getMessage() + "</h3>");
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        rDispatcher.include(request, response);
//        rDispatcher.forward(request, response);
    }
}
