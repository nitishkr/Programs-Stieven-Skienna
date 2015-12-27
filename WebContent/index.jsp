<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Page</title>

<script type="text/javascript">
	function validate() {
		var em = document.getElementById("em").value;
		var pw = document.getElementById("pw").value;

		if (em.length <= 0) {
			alert(" please enter email ");
			return false;
		}

		if (!validateEmail(em)) {
			alert("Please enter valid email id with this format(anything@anythig.anything)");
			return false;
		}

		if (pw.length <= 0) {
			alert(" please enter password ");
			return false;
		}
		if (!checkPassword(pw)) {
			alert("Make sure that password contain atleast one number, one lowercase and one uppercase letter and six characters long");
			return false;
		}
		return;
	}

	function validateEmail(email) {
		var rex = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
		return rex.test(email);
	}

	function checkPassword(str) {
		// at least one number, one lowercase and one uppercase letter
		// at least six characters
		var rex = /(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}/;
		return rex.test(str);
	}
</script>

</head>
<body bgcolor="#27ae60">

<%
String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
 String DB_URL = "jdbc:mysql://localhost/new";
 String USER = "root";
String PASS = "dbadmin";
Connection conn = null;
Statement stmt = null;
PreparedStatement pstmt = null;
double total = 0;
int oid=23, uid, prid,qty,poid=0,price = 0;;
try{
   //STEP 2: Register JDBC driver
   Class.forName("com.mysql.jdbc.Driver");

   //STEP 3: Open a connection
   System.out.println("Connecting to database...");
   conn = DriverManager.getConnection(DB_URL,USER,PASS);
   Connection conn1 = DriverManager.getConnection(DB_URL,USER,PASS);
   //STEP 4: Execute a query
   System.out.println("Creating statement...");
   stmt = conn.createStatement();
  Statement stmt1 = conn.createStatement(); 
   String sql="",sql1="";
   sql = "SELECT * FROM xyz";
   ResultSet rs = stmt.executeQuery(sql);

   //STEP 5: Extract data from result set
   while(rs.next()){
      //Retrieve by column name
       oid  = rs.getInt("tt");
    
   
   }
  System.out.println(oid);
   rs.close();
   stmt.close();
   conn.close();
}catch(SQLException se){
   //Handle errors for JDBC
	   
   se.printStackTrace();
}catch(Exception e){
   //Handle errors for Class.forName
   e.printStackTrace();
}finally{
   //finally block used to close resources
   try{
      if(stmt!=null)
         stmt.close();
   }catch(SQLException se2){
   }// nothing we can do
   try{
      if(conn!=null)
         conn.close();
   }catch(SQLException se){
      se.printStackTrace();
   }//end finally try
}//end try

%>
</h1>
</body>
</html>