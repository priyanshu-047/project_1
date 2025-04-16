package javasrc;

import java.io.IOException;

import org.apache.catalina.connector.Response;

import jakarta.security.auth.message.callback.PrivateKeyCallback.Request;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/logout")
public class log_out extends HttpServlet{
        @Override
        protected void service(HttpServletRequest arg0, HttpServletResponse arg1) throws ServletException, IOException {
            arg0.getSession().removeAttribute("userEmail");
            arg0.getRequestDispatcher("index.html").forward(arg0, arg1);
            
        }
}
