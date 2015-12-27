package Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class cart
 */
@WebServlet("/cart")
public class cart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public cart() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String button;
		int i;
		 HttpSession session=request.getSession();
		int  size = Integer.parseInt((String) session.getAttribute("size"));
	
		
		for ( i = 0;i<size;i++)
		{
			button = request.getParameter(String.valueOf(i));
			if (button == "")
				break;
		}
		String qty = request.getParameter("txt"+String.valueOf(i));
		// session.setAttribute("uid",usid );
		String prid = request.getParameter("prid"+String.valueOf(i));
		response.getWriter().append(String.valueOf(i)+"  "+qty+" "+prid);
		 Connection connection=database.DbConnection.getConnection();
	        try {
				Statement st=connection.createStatement();
				System.out.println(session.getAttribute("uid"));
				//ResultSet rs=st.executeQuery("Select * from cart where prid="+prid+"AND uid ="+session.getAttribute("uid" ));
				ResultSet rs=st.executeQuery("Select * from cart where prid="+prid+" AND uid ="+session.getAttribute("uid" ));
				if (rs.next())
				{
					int qnty = rs.getInt("qty");
					st.executeUpdate("UPDATE cart SET qty="+String.valueOf(Integer.parseInt(qty)+qnty)+" WHERE prid="+prid+" AND uid ="+session.getAttribute("uid" ));
				}
				else
				st.executeUpdate("INSERT INTO cart VALUES ("+session.getAttribute("uid" )+","+prid+","+qty+")");
				
			    rs = st.executeQuery("Select COUNT(Distinct prid) from cart where uid="+session.getAttribute("uid" ) );
				while(rs.next())
		        {
		        	 i =rs.getInt(1);
		        	 
		        	response.getWriter().append(" "+String.valueOf(i));
		        }
				 session.setAttribute("cartsize",String.valueOf(i));
				 session.setAttribute("cartadd","true");
				 session.setAttribute("productpresent", "true");
				  response.sendRedirect("search.jsp");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
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
