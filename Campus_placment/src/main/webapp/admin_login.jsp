<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Campus</title>
<style media="screen">
      *,
*:before,
*:after{
    padding: 0;
    margin: 0;
    box-sizing: border-box;
}
body{
     background-color: #f4f4f4;
    color:black;
    overflow: hidden;
}
.background{
    width: 430px;
    height: 520px;
    position: absolute;
    transform: translate(-50%,-50%);
    left: 50%;
    top: 50%;
}
.background .shape{
    height: 200px;
    width: 200px;
    position: absolute;
    border-radius: 50%;
}
.shape:first-child{
    background: linear-gradient(
        #1845ad,
        #23a2f6
    );
    
    left: -80px;
    top: -80px;
    animation-name:move;
    animation-duration:2s;
    animation-fill-mode:both;
    animation-iteration-count:infinite;
}

@keyframes move{
0%{
 transform: translateX(0vh);
}
50%{
 transform: translateX(50vh);
}
100%{
 transform: translateY(60vh);
}
}


.shape:last-child{
    background: linear-gradient(
        to right,
        #ff512f,
        #f09819
    );
    right: -30px;
    bottom: -80px;
    animation-name:move2;
    animation-duration:2s;
    animation-fill-mode:both;
    animation-iteration-count:infinite;
}
@keyframes move2{
0%{

}
50%{
 transform: translateX(-50vh);
}
100%{
 transform: translateY(-60vh);}
}
form{
    height: 520px;
    width: 400px;
    background-color: rgba(255,255,255,0.13);
    position: absolute;
    transform: translate(-50%,-50%);
    top: 50%;
    left: 50%;
    border-radius: 10px;
    backdrop-filter: blur(10px);
    border: 2px solid rgba(255,255,255,0.1);
    box-shadow: 0 0 40px rgba(8,7,16,0.6);
    padding: 50px 35px;
}
form *{
    font-family: 'Poppins',sans-serif;
    color: black;
    letter-spacing: 0.5px;
    outline: none;
    border: none;
}
form h3{
    font-size: 32px;
    font-weight: 500;
    line-height: 42px;
    text-align: center;
}

label{
    display: block;
    margin-top: 30px;
    font-size: 16px;
    font-weight: 500;
}
input{
    display: block;
    height: 50px;
    width: 100%;
    background-color: #ccc;
    border-radius: 3px;
    padding: 0 10px;
    margin-top: 8px;
    font-size: 14px;
    font-weight: 300;
}
::placeholder{
    color: #e5e5e5;
}
button{
    margin-top: 50px;

    width: 100%;
    background-color: rgb(90, 20, 170);
       color:white;
    width: 100%;
    height: 40px;
    border-radius: 5px;
    border-color: transparent;

}



</style>
</head>
<body>
    <div class="background">
        <div class="shape"></div>
        <div class="shape"></div>
    </div>
    <form action="teacher" method="post">
        <h3>Admin</h3>

        <label for="username">Email</label>
        <input type="email" placeholder="Email" name="teacher_email" id="username">

        <label for="password">Password</label>
        <input type="password" placeholder="Password" name="teacher_password" id="password">
        <%
        String msg=null;
        msg=(String)request.getAttribute("errorMessage");
        if(msg!=null){
        out.print(msg);
        }%>
        <button>Log In</button>
       
    </form>
</body>
</html>