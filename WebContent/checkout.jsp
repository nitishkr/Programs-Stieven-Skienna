<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Build Order</title>
<script type="text/javascript">
function addRow(prid,prname,price,val)
{
	//asdasdad
	//dfghhhe
         if (!document.getElementsByTagName) return;
         tabBody=document.getElementsByTagName("tbody").item(1);
         row=document.createElement("tr");
         cell1 = document.createElement("td");
         cell2 = document.createElement("td");
         cell3 = document.createElement("td");
         cell4 = document.createElement("td");
         cell5 = document.createElement("td");
          textnode1=document.createTextNode(prid);
         
         textnode2=document.createTextNode(prname);
         textnode3=document.createTextNode(price);
         textnode4=document.createTextNode(val);
        // btn.setAttribute("onclick","javascript:doit(this.id);");
        
         cell1.appendChild(textnode1);
         cell2.appendChild(textnode2);
         cell3.appendChild(textnode3);
         cell4.appendChild(textnode4);
   
         row.appendChild(cell1);
         row.appendChild(cell2);
         row.appendChild(cell3);
         row.appendChild(cell4);
  
         tabBody.appendChild(row);


}


function searchdb()
{	
	var cost = 1;
	var totalprice = 0;
	var Msg ='<%=session.getAttribute("admin")%>';
    if (Msg == 1)
    	cost = .7;
	
<%
  if (session.getAttribute("uid") != "null")
  {
	  String pname="",prices,prn,pid;
	  double price=0.0;int qt;
      double totalprice = 0.0;	
 	  Connection connection=database.DbConnection.getConnection();
	    Statement st=connection.createStatement();
	    Statement st1 = connection.createStatement();
    ResultSet rs = st.executeQuery("select * from cart where uid ="+session.getAttribute("uid")) ;
    while(rs.next())
    {
    	int prid = rs.getInt("prid");
    	qt = rs.getInt("qty");
    	
    	 pid = String.valueOf(prid);
    	
    	ResultSet r = st1.executeQuery("select * from product where prid ="+pid);
    	while(r.next())
    	{
    		pname = r.getString("name");
    		 price = r.getDouble("price");
    		 prices = String.valueOf(price);
    	}
    	
   %>
	
   var prname ='<%=pname%>';
   var prprice ='<%=price%>';
	var qty ='<%=qt%>';
	
	totalprice += prprice*qty*cost;
  	addRow(prname,prprice.toString(),qty.toString(),(prprice*qty*cost).toString());
<%
    }
  }
 %>  
 document.getElementById("total").innerHTML = "Total price is "+totalprice.toString();
}
</script>
</head>
<body bgcolor="#27ae60" link= "#f39c12">
<table style="width: 100%; ">
<tr style="height: auto;">
<td style="font-size: 30px;font-weight: bold;">Fookart.com</td>
<td align="right" id="cartmessage"></td>
</tr>
<tr>
<td > Welcome <%=session.getAttribute("name") %></td>
<td  align="right">
<form method="link" action="LogOut" >
    <input type="submit" value="Logout"/>
</form></td>
</tr>
</table>
<br/>


<hr/>
<h4>Your order is : </h4>

<table border='1' id='table' align="center" width="75%" >

                <TH>Product Name</TH>
                <TH>Price(per item)</TH>
                <TH>Quantity</TH>
                <TH> SubTotal</TH>
           
<tbody>

</tbody>
</table>
<br/>
<br/>
<h3 id="total"></h3>
</body>
<script type="text/javascript"> window.onload = searchdb(); </script>
</html>