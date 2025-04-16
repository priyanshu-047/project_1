<%@page import="javax.xml.crypto.Data"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javasrc.Com_details"%>
<%@page import="java.util.List"%>
<%@page import="javasrc.getvalues"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.mysql.cj.Session"%>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.lang.Exception" %>
<%@page errorPage="error.jsp" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Profile</title>
    <link rel="stylesheet" href="style.css">
    <style type="text/css">
    @keyframes slidshow {
    0%{
       
    }

    100%{
        transform: translateX(0px);
        visibility: visible;
    }
}
    /* Reset some default styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* Set the basic font and background color */
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    color: #333;
}

/* Container for the entire page */
.container {
    width: 80%;
    margin: 10px auto;
    padding: 20px;
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* Header styles */
header {
    text-align: center;
    margin-bottom: 30px;
}

header h1 {
    font-size: 2.5rem;
    color: #2c3e50;
}

/* Profile section styles */
.profile {
    display: flex;
    flex-direction: column;
    align-items: center;
}

.profile-header {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
}

.profile-pic {
    width: 100px;
    height: 100px;
    border-radius: 50%;
    object-fit: cover;
    margin-right: 20px;
}

.username h2 {
    font-size: 1.5rem;
    color: #2c3e50;
}

.username p {
    font-size: 1rem;
    color: #7f8c8d;
}

/* Table Styles */
.student-details table {
    width:100%;
    border-collapse: collapse;
    margin-top: 20px;
    
    
}
button{
  
    background-color: rgb(90, 20, 170);
    color:white;
    width: 100px;
    height: 30px;
    border-radius: 5px;
     border-color: transparent;
    }
.student-details th, .student-details td {
    padding: 8px;
    text-align: left;
    border-bottom: 1px solid #ccc;
}
.student-details{
width:100%;
overflow: scroll;
margin-left: 20px;
margin-right: 20px;
}
.student-details th {
    background-color:  rgb(90, 20, 170);
    color: white;
}

.student-details td {
    background-color: #ecf0f1;
}

/* Footer Styles */
footer {
    text-align: center;
    margin-top: 40px;
    font-size: 1rem;
    color: #7f8c8d;
}

footer span {
    font-weight: bold;
}

#left{
    animation-name: slidshow;
    animation-duration: 1s;
    animation-timing-function: linear;
    animation-delay: 5ms;
    visibility: hidden;
    transform: translateX(-200px);
    /* animation-iteration-count: infinite; */
    animation-fill-mode: forwards;}
    
#left1{
    animation-name: slidshow;
    animation-duration: 1s;
    animation-timing-function: linear;
    animation-delay: 5ms;
    visibility: hidden;
    transform: translateY(-200px);
    /* animation-iteration-count: infinite; */
    animation-fill-mode: forwards;}
   
.username{
  animation-name: slidshow;
    animation-duration: 1s;
    animation-timing-function: linear;
    animation-delay: 5ms;
    visibility: hidden;
    transform: translateX(200px);
    /* animation-iteration-count: infinite; */
    animation-fill-mode: forwards;
}
@keyframes slidshow {
    0%{
       
    }

    100%{
        transform: translateX(0px);
        visibility: visible;
    }
}
#place:active {
	color: white;
	background-color: black;
}
    </style>
</head>
<body>
         <%! String email=null; %>
         <%email=(String)session.getAttribute("userEmail");
           if(request.getAttribute("msg")!=null){
           out.print(request.getAttribute("msg"));
           }
           if(email==null){
           response.sendRedirect("welcome.jsp");
           }%>
    <div class="container">
        <header>
            <h1>Student </h1>
            <a id="left1" href="logout" style="position: absolute;left: 220px"><button>log_out</button></a>
        </header>
        
        <section class="profile">
            <div class="profile-header">
            <%String s =(String) session.getAttribute("id");
            String n=(String)session.getAttribute("name1");%>
                <img id="left" src="upload/<%=s %>.jpg" alt="Profile Picture" class="profile-pic">
                <div class="username">
                    <h2><%=n %></h2>
                    <p id='email1'><%=email%></p>
                </div>
            </div>
            <br>
          <hr><hr>
          <br>
            <h1 style="text-align: center;">Companies</h1>
            <div class="student-details">
                <table id="mytable">
                    <thead>
                        <tr>
                            <th>NAME</th>
                            <th>LOCATION</th>
                            <th>STREEM</th>
                            <th>MINIMUM CGPA</th>
                            <th>SALARY</th>
                        </tr>
                    </thead>
                    <tbody>
                        
                        <%
                        getvalues obj1=new getvalues();
                        ArrayList<Com_details> newdata=obj1.getdata();
                        for(Com_details c:newdata){
                        	if((int)session.getAttribute("cgpa")>=c.getMincgp()){
                        	
                        		
                        %>
                        <tr>
                        
                            <td><%=c.getNameString() %></td>
                            <td><%=c.getLocString() %></td>
                            <td><%=c.getCatString() %></td>
                            <td><%=c.getMincgp() %></td>
                            <td><%=c.getSalaryString() %></td>
                            <td><button id="place" value="<%=c.getNameString()%>">apply</button></td>
                            
                        </tr>
                     <%}} %>
                    </tbody>
                </table>
            </div>
        </section>
        
        <footer>
            <p>Last updated on: <span id="current-date"></span></p>
        </footer>
    </div>

    <script>
        // Set current date in the footer
        const currentDate = new Date().toLocaleDateString();
        document.getElementById('current-date').textContent = currentDate;
        
        const table=document.getElementById("mytable");
        console.log(table);
        table.addEventListener("click",(event)=>{
        	console.log(event.target.innerText);
        	if(event.target.innerText=="done"){
        		console.log("same");
        	}
        	else{
        		
        	  var element=event.target;
        	  var name = element.value;
              var email1 = document.getElementById("email1");
              console.log(email1);
             var email=email1.innerText;

         
              var xhr = new XMLHttpRequest();

              // Prepare the data to be sent (URL encoded)
              var data = "name=" + encodeURIComponent(name) + "&email=" + encodeURIComponent(email);

            
              xhr.open("POST", "apply", true); // Replace 'YourServletURL' with your servlet URL

            
              xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

   
              xhr.onload = function() {
                  if (xhr.status === 200) {
                      element.innerHTML = xhr.responseText;
                  } else if(xhr.status=== 409){
                	  element.innerHTML = xhr.responseText;
                  }
                  else if(xhr.status===500){
                	  element.innerHTML = xhr.responseText;
                  }
                  else {
                      element.innerHTML = "try again";
                  }
              };

             
              xhr.send(data);
        	}
        });
    </script>
</body>
</html>
