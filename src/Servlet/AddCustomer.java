package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Array;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jdk.nashorn.internal.runtime.regexp.joni.SearchAlgorithm;
/**

/**
 * Servlet implementation class AddCustomer
 */
@WebServlet("/AddCustomer")
public class AddCustomer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddCustomer() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int x,i=-1;
		try{
			String name= request.getParameter("Name"); 
	        String card = request.getParameter("card");    
	        String admin = request.getParameter("isadmin");
	        String email = request.getParameter("email");
		     //   response.getWriter().append(name).append(card).append(admin);
		       if (admin==null)
		    	   x =0;
		       else 
		    	   x = 1;
		        Connection connection=database.DbConnection.getConnection();
		        Statement st=connection.createStatement();
		        
		        ResultSet rs=st.executeQuery("Select max(Uid) from User");
		        
		        while(rs.next())
		        {
		        	 i =rs.getInt(1);
		        	response.getWriter().append(" "+String.valueOf(i));
		        }
		        HttpSession session=request.getSession();
		        
		        if (name == "")
		        {
		        	 session.setAttribute("getAlert", "Yes");
		  	       session.setAttribute("message", "Please enter a username !"); 
		  	     response.sendRedirect("search.jsp"); 
		  	     return;
		        	//request.setAttribute("errorMessage", "Name Field empty !!");
		        	//request.getRequestDispatcher("/Login.jsp").forward(request, response);
		        } 
		        if (card == "")
		        {
		        	 session.setAttribute("getAlert", "Yes");
		  	       session.setAttribute("message", "Please enter a credit card number !"); 
		  	     response.sendRedirect("search.jsp"); 
		  	     return;
		        	//request.setAttribute("errorMessage", "Name Field empty !!");
		        	//request.getRequestDispatcher("/Login.jsp").forward(request, response);
		        } 
		        
		       st.executeUpdate("INSERT INTO User VALUES ("+String.valueOf(i+1)+",'"+name+"',"+card+","+String.valueOf(x)+",'"+email+"')");
	       
		       session.setAttribute("getAlert", "Yes");
	  	       session.setAttribute("message", "User added successfully !"); 
	  	     response.sendRedirect("search.jsp"); 
	        
	    
	          
      		 
	  
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
