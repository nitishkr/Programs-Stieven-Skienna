package Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class RemoveCustomer
 */
@WebServlet("/RemoveCustomer")
public class RemoveCustomer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RemoveCustomer() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String deletecustomeremail=request.getParameter("droplist");
		response.getWriter().append("Served at: ").append(deletecustomeremail);
		//response.getWriter().append("Served at: ").append(request.getContextPath()).append(deletecustomeremail);
        try{
           Connection connection=database.DbConnection.getConnection();
           Statement st=connection.createStatement();
           int chk=st.executeUpdate("delete from user where name='"+deletecustomeremail+"'");
           HttpSession session=request.getSession();
           session.setAttribute("getAlert", "Yes");
  	       session.setAttribute("message", "User removed Successfully !");
        	
        	 
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
