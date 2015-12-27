package Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Search
 */
@WebServlet("/Search")
public class Search extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Search() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int size = 0;
		String query= request.getParameter("searchstr"); 
		response.getWriter().append("Served at: ").append(query);
	     HttpSession session=request.getSession();
	     if (query == "")
	     session.setAttribute("sstring", "null");
	     else
	     {
	    	 Connection connection=database.DbConnection.getConnection();
	         Statement st;
			try {
				st = connection.createStatement();
				 ResultSet rs = st.executeQuery("select * from Product where name like '%"+query+"%'") ;
			    while (rs.next())
			    {
			    	size++;
			    }
			
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	          
	    	 session.setAttribute("sstring", query);
	     }
	     session.setAttribute("size", String.valueOf(size));
	     response.getWriter().append("Served at: ").append(String.valueOf(size));
	     try{
	    	 int i=0;;
	     Connection connection=database.DbConnection.getConnection();
         Statement st = connection.createStatement();
	    ResultSet  rs = st.executeQuery("Select COUNT(Distinct prid) from cart where uid="+session.getAttribute("uid" ) );
			while(rs.next())
	        {
	        	 i =rs.getInt(1);
	        	 
	        	response.getWriter().append(" "+String.valueOf(i));
	        }
			 session.setAttribute("cartsize",String.valueOf(i));
			 if (i!=0)
				 session.setAttribute("productpresent", "true");
	     }catch(Exception e)
	     {
	    	 
	     }
       
	     response.sendRedirect("search.jsp"); 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
