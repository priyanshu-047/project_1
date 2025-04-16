package javasrc;

import java.io.*;  
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
 
  
@WebServlet("/reg")
@MultipartConfig(maxFileSize = 1600000)
public class studentregistration extends HttpServlet {  
 private	String validString=null;
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
public void doPost(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {  
System.out.println("hi");

//  if(request.getSession().getAttribute("valid")!=null) {
	  
  
response.setContentType("text/html");  
PrintWriter out = response.getWriter();  
          
String n=request.getParameter("email");  
String p=request.getParameter("psw");  
String e=request.getParameter("Name");   
String c=request.getParameter("sem"); 
String d=request.getParameter("cgpa");  
Part filPart=request.getPart("img2");
InputStream iStream=filPart.getInputStream();
          
try{  
	

Connection con= getConnection(); 
  
PreparedStatement ps=con.prepareStatement(  
"insert into student_login(email,password,name,sem,cgpa,img) values(?,?,?,?,?,?)");  
  
ps.setString(1,n);  
ps.setString(2,p);  
ps.setString(3,e);  
ps.setString(4,c);  
ps.setString(5,d);
ps.setBlob(6, iStream);
int i=ps.executeUpdate();  
if(i>0) {
	request.setAttribute("msg", "success");
	response.sendRedirect("registration.jsp"); 
	          
}
else {
	  request.setAttribute("errorMessage", "failed to register1");
      request.getRequestDispatcher("registration.jsp").forward(request, response);
}

}catch (Exception e2) {
	System.out.println(e2.getLocalizedMessage());
	  request.setAttribute("errorMessage", "failed to register2");
      request.getRequestDispatcher("registration.jsp").forward(request, response);
	}  
          
out.close();  
//}  
//  else {
//	  request.getRequestDispatcher("index.html").forward(request, response);
//}
  System.out.println("end");
}

}  
