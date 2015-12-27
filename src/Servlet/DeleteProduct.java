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
 * Servlet implementation class DeleteProduct
 */
@WebServlet("/DeleteProduct")
public class DeleteProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteProduct() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String deletecustomeremail=request.getParameter("droplist");
		response.getWriter().append("Served at: ").append(request.getContextPath()).append(deletecustomeremail);
        try{
           Connection connection=database.DbConnection.getConnection();
           Statement st=connection.createStatement();
           int chk=st.executeUpdate("delete from product where name='"+deletecustomeremail+"'");
           HttpSession session=request.getSession();
           session.setAttribute("getAlert", "Yes");
  	       session.setAttribute("message", "Product deleted Successfully !");
        	 
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
