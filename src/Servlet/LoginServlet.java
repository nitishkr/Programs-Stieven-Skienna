package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		
		try{int i=0;
	        String name= request.getParameter("Name");     
	        response.getWriter().append(name);
	       
	        Connection connection=database.DbConnection.getConnection();
	        Statement st=connection.createStatement();
	        
	        ResultSet rs=st.executeQuery("select * from User where name ='"+name+"'");
	        if (name == "")
	        {
	        	request.setAttribute("errorMessage", "Name Field empty !!");
	        	request.getRequestDispatcher("/Login.jsp").forward(request, response);
	        }
	        if(rs.next()){
	        	int usid = rs.getInt("uid");
	        	int admin = rs.getInt("admin");
	        	  HttpSession session=request.getSession();
	        	  session.setAttribute("name",name);
                session.setAttribute("admin", admin);
                session.setAttribute("uid",usid );
	        	
	        	  rs = st.executeQuery("Select COUNT(Distinct prid) from cart where uid="+session.getAttribute("uid" ) );
					while(rs.next())
			        {
			        	 i =rs.getInt(1);
			        	 
			        	response.getWriter().append(" "+String.valueOf(i));
			        }
					 session.setAttribute("cartsize",String.valueOf(i));
					 if (i!=0)
						 session.setAttribute("productpresent", "true");
                  
                  
      		   response.sendRedirect("search.jsp");
         }else{
        	  request.setAttribute("errorMessage", "User not present !!");
        	  request.getRequestDispatcher("/Login.jsp").forward(request, response);
            //response.sendRedirect("login.html");
         }       
	        
	      
	       
	   
	       
	        
	  
		}catch(Exception e)
        {
        	e.printStackTrace();
        }
		
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}



