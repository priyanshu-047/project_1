<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*, java.util.*" %>
        <%! String email=null; %>
       <%
       email=(String) session.getAttribute("teachEmail");
         if(request.getAttribute("msg")!=null){
        	 out.print(request.getAttribute("msg"));
         }
        if(email==null){
        	response.sendRedirect("admin_login.jsp");
        }
       
       %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin</title>
<style type="text/css">
 * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        .main{
         width: 80%;
    margin: 10px auto;
    padding: 20px;
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f7f9fb;
            color: #333;
            line-height: 1.6;
        }
        
        h1 {
            text-align: center;
            font-size: 2.5rem;
            color: #333;
            margin: 20px 0;
        }

        /* Container for the content */
        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Table Styling */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
            background-color: #fff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
              background-color: rgb(90, 20, 170);
            color: white;
            font-weight: bold;
        }

        td {
            background-color: #fafafa;
        }

        /* Row hover effect */
        tr:hover {
            background-color: #f1f1f1;
        }

        /* Buttons and Links */
        a {
            text-decoration: none;
        }

        button {
              background-color: rgb(90, 20, 170);
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            font-size: 1rem;
            transition: background-color 0.3s;
        }

        button:hover {
            opacity: 0.8;
        }

        .register-btn {
            display: inline-block;
            margin: 20px 0;
            text-align: right;
            width: 100%;
        }

        /* Responsive styling */
        @media (max-width: 768px) {
            table {
                font-size: 14px;
            }

            th, td {
                padding: 12px;
            }

            h1 {
                font-size: 2rem;
            }
        }

        @media (max-width: 480px) {
            h1 {
                font-size: 1.8rem;
            }

            .container {
                width: 95%;
            }
        }
        .profile-pic {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    object-fit: cover;
  
}
 
.fix{display: flex;
justify-content: center;
align-items: center;
width: 100%;
flex-wrap: wrap;
}
</style>
</head>
<body>
<div class="main">
          <div> <h1 style="text-align: center">admin</h1>
           <div class="fix">   <img id="left" src="img/admin.webp" alt="Profile Picture" class="profile-pic">
           
           <h4 style="text-align: center"><%=email %></h4></div> </div>
        
           <a href="registration.jsp"><button>register student</button></a>      
       <br>
       <hr>
       <br>
        <h1 style="text-align: center">Enter company details</h1>
       <div class="container">
      <div>
       <form action="enter" method="post">
       <label for="name">Name</label>
       <input type="text" name="name" required="required" id="name"><br>
       <label for="loc">Location</label>
       <input type="text" name="loc" required="required" id="loc"><br>
       <label for="sal">Salary</label>
       <input type="number" name="sal" required="required" id="sal"><br>
       <label for="mincgpa"> Min cgpa</label>
      <input type="number" name="mincgpa" required="required" id="mincgpa"><br>
      <label for="cat">Ctagory</label>
      <input type="text" name="cat" required="required" id="cat"><br>
       <button type="submit" style="width: 50%; margin: 10px 50px;">enter</button> 
       </form>
       </div>
       </div>
       <hr><br>
        <h1 style="text-align: center;">Interested student</h1>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
            </tr>
        </thead>
        <tbody>
            <% 
               
                String dbURL = "jdbc:mysql://localhost:3306/campus"; 
                String dbUsername = "root"; 
                String dbPassword = ""; 

                Connection connection = null;
                Statement statement = null;
                ResultSet resultSet = null;

                try {
                 
                    Class.forName("com.mysql.cj.jdbc.Driver");

                   
                    connection = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

                  
                    statement = connection.createStatement();
                    String sql = "SELECT * FROM users"; 
                    resultSet = statement.executeQuery(sql);

                  
                    while (resultSet.next()) {
                        int id1 = resultSet.getInt("id");
                        String name1 = resultSet.getString("name");
                        String email1 = resultSet.getString("email");
            %>
                        <tr>
                            <td><%= id1 %></td>
                            <td><%= name1 %></td>
                            <td><%= email1 %></td>
                        </tr>
            <% 
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    
                    try {
                        if (resultSet != null) resultSet.close();
                        if (statement != null) statement.close();
                        if (connection != null) connection.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </tbody>
    </table>
       </div>
</body>
</html>