<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>registration</title>
<style type="text/css">
* {box-sizing: border-box}
body{
 background-color: #f4f4f4;}
/* Add padding to containers */
.container {
  padding: 16px;
  width:50%;
  margin: 20px auto;
  background-color: white;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* Full-width input fields */
input[type=text], input[type=password] {
  width: 100%;
  padding: 15px;
  margin: 5px 0 22px 0;
  display: inline-block;
  border: none;
  background: #f1f1f1;
}

input[type=text]:focus, input[type=password]:focus {
  background-color: #ddd;
  outline: none;
}

/* Overwrite default styles of hr */
hr {
  border: 1px solid #f1f1f1;
  margin-bottom: 25px;
}

/* Set a style for the submit/register button */
.registerbtn {
  background-color:  rgb(90, 20, 170);
  color: white;
  padding: 16px 20px;
  margin: 8px 20%;
  border: none;
  cursor: pointer;
  width: 50%;
  opacity: 0.9;
  border-radius: 15px;
}

.registerbtn:hover {
  opacity:1;
}

/* Add a blue text color to links */
a {
  color: dodgerblue;
}

/* Set a grey background color and center the text of the "sign in" section */
.signin {
  background-color: #f1f1f1;
  text-align: center;
}
@media screen and (max-width:600px) {
	.container{
	width:80%;}
}
</style>
</head>
<body>
           <form action="reg" method="post" enctype="multipart/form-data">
            <%
            request.getSession().setAttribute("valid", "yes");
            String msg=null;
            msg=(String)request.getAttribute("errorMessage");
           if(msg!=null){
        	out.print(msg);
        }
        %>
        <% 
        String  email=(String) session.getAttribute("teachEmail");
         if(request.getAttribute("msg")!=null){
        	 out.print(request.getAttribute("msg"));
         }
        if(email==null){
        	response.sendRedirect("admin_login.jsp");
        }
        else{
        	
        }
        %>
  <div class="container">
    <h1 style="text-align: center;">Register</h1>
    
    <hr>

    <label for="email"><b>Email</b></label>
    <input type="text" placeholder="Enter Email" name="email" id="email" required>

    <label for="psw"><b>Password</b></label>
    <input type="password" placeholder="Enter Password" name="psw" id="psw" required>

     <label for="name"><b>Name</b></label>
    <input type="text" placeholder="Enter name" name="Name" id="name" required>

      <label for="sem"><b>Semester</b></label>
    <input type="number" placeholder="Enter semester" name="sem" id="sem" required>
    <br><br>
     <label for="cgpa"><b>CGPA</b></label>
    <input type="number" placeholder="Enter cgpa" name="cgpa" id="cgpa" required>
    <br><br>
    <label for="img1"><b>photo</b></label>
    <input type="file" placeholder="photo" id="img1" name="img2" required="required">
  <br><br>
   
    <button type="submit" class="registerbtn">Register</button>
  </div>


    
  </div>
</form>
</body>
</html>