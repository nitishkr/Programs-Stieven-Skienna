package Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class AddProduct
 */
@WebServlet("/AddProduct")
public class AddProduct extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddProduct() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	//	response.getWriter().append("Served at: ").append(request.getContextPath());
		
		int x,i=1;
		try{
			String name= request.getParameter("Name"); 
	        String qty = request.getParameter("qty");    
	        String price = request.getParameter("price");
		      response.getWriter().append(name).append(qty).append(price);
		      
		        Connection connection=database.DbConnection.getConnection();
		        Statement st=connection.createStatement();
		        
		        ResultSet rs=st.executeQuery("Select max(prid) from Product");
		        
		        while(rs.next())
		        {
		        	 i =rs.getInt(1);
		        	 
		        	response.getWriter().append(" "+String.valueOf(i));
		        }
		        HttpSession session=request.getSession();
		        
		        if (name == "")
		        {
		        	 session.setAttribute("getAlert", "Yes");
		  	       session.setAttribute("message", "Please enter a product name !"); 
		  	     response.sendRedirect("search.jsp"); 
		  	     return;
		        	//request.setAttribute("errorMessage", "Name Field empty !!");
		        	//request.getRequestDispatcher("/Login.jsp").forward(request, response);
		        } 
		        if (qty == "")
		        {
		        	 session.setAttribute("getAlert", "Yes");
		  	       session.setAttribute("message", "Please enter a quantity  !"); 
		  	     response.sendRedirect("search.jsp"); 
		  	     return;
		        	//request.setAttribute("errorMessage", "Name Field empty !!");
		        	//request.getRequestDispatcher("/Login.jsp").forward(request, response);
		        } 
		        if (price == "")
		        {
		        	 session.setAttribute("getAlert", "Yes");
		  	       session.setAttribute("message", "Please enter price !"); 
		  	     response.sendRedirect("search.jsp"); 
		  	     return;
		        	//request.setAttribute("errorMessage", "Name Field empty !!");
		        	//request.getRequestDispatcher("/Login.jsp").forward(request, response);
		        } 
		        
		       st.executeUpdate("INSERT INTO Product VALUES ("+String.valueOf(i+1)+",'"+name+"',"+qty+","+price+")");
	       
		       session.setAttribute("getAlert", "Yes");
	  	       session.setAttribute("message", "Product added successfully !"); 
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
