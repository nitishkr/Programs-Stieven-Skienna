<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Main Page</title>
<style>
#table{
      
    border: 1px solid black;
  
     width:80%;
     font-size:12px;
     height:auto;
     text-align:left;

}
#overlay {
     visibility: hidden;
     position: absolute;
     left: 0px;
     top: 0px;
     width:100%;
     height:100%;
     text-align:center;
     z-index: 1000;
     background-image:url("images/bkg.png");
}

#overlay div {
     width:300px;
     margin: 120px auto;
     background-color: #ffffff;
     border:2px solid #000;
     padding:20px;
     border-radius:10px;
     text-align:left;
}

#addp {
     visibility: hidden;
     position: absolute;
     left: 0px;
     top: 0px;
     width:100%;
     height:100%;
     text-align:center;
     z-index: 1000;
     background-image:url("images/bkg.png");
}

#addp div {
     width:400px;
     margin: 120px auto;
     background-color: #ffffff;
     border:2px solid #000;
     padding:20px;
   text-align:center;
   border-radius:10px;
}

#removep {
     visibility: hidden;
     position: absolute;
     left: 0px;
     top: 0px;
     width:100%;
     height:100%;
     text-align:center;
     z-index: 1000;
     background-image:url("images/bkg.png");
}

#removep div {
     width:400px;
     margin: 120px auto;
     background-color: #ffffff;
     border:2px solid #000;
     padding:20px;
   text-align:center;
   border-radius:10px;
}


#removec {
     visibility: hidden;
     position: absolute;
     left: 0px;
     top: 0px;
     width:100%;
     height:100%;
     text-align:center;
     z-index: 1000;
     background-image:url("images/bkg.png");
}

#removec div {
     width:400px;
     margin: 120px auto;
     background-color: #ffffff;
     border:2px solid #000;
     padding:20px;
   text-align:center;
   border-radius:10px;
}


</style>

<script type="text/javascript">
x = 0;
var cart = 0;

doit = function(x){
   prid = document.getElementById("prid"+x).innerText;
   qty = document.getElementById("txt"+x).value;
   alert(document.getElementById("txt"+x).value);
   alert(document.getElementById("prid"+x).innerText);
   if (qty !="0")
   { cart ++;
     <%
     try{
     String name= request.getParameter("Name"); 
     String qty = request.getParameter("qty");    
     String price = request.getParameter("price");
	      
	      
	        Connection connection=database.DbConnection.getConnection();
	        Statement st=connection.createStatement();
	        
	        ResultSet rs=st.executeQuery("Select max(prid) from Product");
     }catch(Exception e)
     {
    	 
     }
     %>
   
      
   }

}



function addRow(prid,prname,price,val)
{
	
	
         if (!document.getElementsByTagName) return;
         tabBody=document.getElementsByTagName("tbody").item(1);
         row=document.createElement("tr");
         cell1 = document.createElement("td");
         cell2 = document.createElement("td");
         cell3 = document.createElement("td");
         cell4 = document.createElement("td");
         cell5 = document.createElement("td");
         var textnode1=document.createElement('input');
         textnode1.type="text";
         textnode1.setAttribute("name","prid"+val.toString());
         textnode1.setAttribute("value",prid);
         textnode1.setAttribute("readOnly",true);
         textnode1.style.cssText = 'background-color:transparent;border:0px';
         textnode2=document.createTextNode(prname);
         textnode3=document.createTextNode(price);
         var input = document.createElement('input'); 
         input.type = "text";        
         input.setAttribute("name","txt"+val.toString());
         input.setAttribute("value","1");
         var btn = document.createElement("BUTTON");
         var t = document.createTextNode("Add to cart");
         btn.appendChild(t);
         btn.setAttribute("name", val.toString());
         btn.setAttribute("type", "submit");
        // btn.setAttribute("onclick","javascript:doit(this.id);");
        
         cell1.appendChild(textnode1);
         cell2.appendChild(textnode2);
         cell3.appendChild(textnode3);
         cell4.appendChild(input);
         cell5.appendChild(btn);
         row.appendChild(cell1);
         row.appendChild(cell2);
         row.appendChild(cell3);
         row.appendChild(cell4);
         row.appendChild(cell5);
         tabBody.appendChild(row);


}

function fillcheckout()
{
 
	document.getElementById('checkout').style.display="block" ;
	document.getElementById('blank').style.display="none" ;
	<%
	String email="",creditcard="";
	Connection connection=database.DbConnection.getConnection();
    Statement st=connection.createStatement();
    ResultSet rs = st.executeQuery("select * from User where uid = "+session.getAttribute("uid")) ;
    while(rs.next())
    {
    	email = rs.getString("email");
    	creditcard = rs.getString("creditcard");
    }
	%>
	  var prdid ='<%=email%>';
		var prname ='<%=creditcard%>';
		document.getElementById("email").value = prdid;
		document.getElementById("credit").value = prname;
}
function addOption()
{
	var sel = document.getElementById('drop');
	<%
	String product="";
	
   rs = st.executeQuery("select * from Product order by name ") ;
    while(rs.next())
    {
    	product = rs.getString("name");
    %>
	var opt = document.createElement('option'); // create new option element
	 var prdid ='<%=product%>';
	opt.appendChild( document.createTextNode(prdid) );
	 // set value property of opt
	sel.appendChild(opt);
    <%
   
	

	

    }
   	%>
}
function searchdb()
{	
	var val = 0;
	// 
	var Msg ='<%=session.getAttribute("sstring")%>';
	if (Msg == "null")
		document.getElementById("searchstring").value= "";
	else
		{
		document.getElementById('table').style.visibility="visible" ;
		document.getElementById("searchstring").value= Msg;
		}
	
<%
  if (session.getAttribute("sstring") != "null")
  {
	
	
    rs = st.executeQuery("select * from Product where name like '%"+session.getAttribute("sstring")+"%'") ;
    while(rs.next())
    {
    	int prid = rs.getInt("prid");
    	String prn = rs.getString("name");
    	double price = rs.getDouble("price");
    	String pid = String.valueOf(prid);
    	String prices = String.valueOf(price);
    	
   %>
	
   var prdid ='<%=pid%>';
	var prname ='<%=prn%>';
	var prprice ='<%=prices%>';
	
  	addRow(prdid,prname,prprice,val);
	val++;
    <%
    }
   	session.setAttribute("sstring","null");
   	}%>
 
}
function msg(x)
{
	
alert(x);
}

function overlay() {
	el = document.getElementById("overlay");
	el.style.visibility = (el.style.visibility == "visible") ? "hidden" : "visible";
}

function addp() {
	el = document.getElementById("addp");
	el.style.visibility = (el.style.visibility == "visible") ? "hidden" : "visible";
}

function removep() {
	el = document.getElementById("removep");
	el.style.visibility = (el.style.visibility == "visible") ? "hidden" : "visible";
}

function removec() {
	el = document.getElementById("removec");
	el.style.visibility = (el.style.visibility == "visible") ? "hidden" : "visible";
}
function addUser()
{
	var sel = document.getElementById('dropc');
	<%
	 product="";
	
   rs = st.executeQuery("select * from user order by name") ;
    while(rs.next())
    {
    	product = rs.getString("name");
    %>
	var opt = document.createElement('option'); // create new option element
	 var prdid ='<%=product%>';
	opt.appendChild( document.createTextNode(prdid) );
	 // set value property of opt
	sel.appendChild(opt);
    <%
   
	

	

    }
   	%>
}

var Msg ='<%=session.getAttribute("getAlert")%>';
	var comment ='<%=session.getAttribute("message")%>';
	var size='<%=session.getAttribute("cartsize")%>';
	var cartadd='<%=session.getAttribute("cartadd")%>';
	var product='<%=session.getAttribute("productpresent")%>';
	var admin='<%=session.getAttribute("admin")%>';
    if (Msg != null) {
 function alertName(){
	
	 if (size=="null")
		 size="0";
	 document.getElementById("cartmessage").innerHTML='<button><img src="images/cart.png" id="cartmsg" alt="Cart" style="vertical-align:middle;width:35px;height:35px;"/>&nbsp;CART &nbsp;'+size+'</button>';
	
	if (admin == 0)
		{
		document.getElementById("rights").style.display="none" ;
		}
	 if (comment!='null')
 		{
		alert(comment);
		
		<% 
		session.setAttribute("message","null");
		%>
 		}
	 if (product !="null")
		 {
		 fillcheckout();
		 }
	 if (cartadd!='null')
		{
		
		alert("Product added successfully in cart");
		 <% 
			session.setAttribute("cartadd","null");
		 %>
		
		}
	 
 } 
 }

</script>
</head>
<body bgcolor="#27ae60" link= "#f39c12">
<table style="width: 100%; ">
<tr style="height: auto;">
<td style="font-size: 30px;font-weight: bold;">Fookart.com</td>
<td align="right" id="cartmessage"><button><img src="images/cart.png" id="cartmsg" alt="Cart" style="vertical-align:middle;width:35px;height:35px;"/>&nbsp;CART &nbsp;0</button></td>
</tr>
<tr>
<td > Welcome <%=session.getAttribute("name") %></td>
<td  align="right"><form method="link" action="LogOut" >
    <input type="submit" value="Logout"/>
</form></td>
</tr>
</table>
<br/>

<hr/>
 

 <br/> 
<div id="rights" align="right"> <a href="#" onclick="overlay()">Add Users</a> &nbsp;&nbsp;&nbsp;  <a href="#" onclick="removec();addUser()">Delete Users</a> &nbsp;&nbsp;&nbsp;  <a href="#" onclick="addp()"">Add product</a> &nbsp;&nbsp;&nbsp;  <a href="#" onclick="removep();addOption()">Delete Product</a>
</div>

<br/>
<br/>

<form  action="Search" method="post"  align="center"  >
<input type="text" id="searchstring"  name="searchstr" placeholder="So, what are you wishing for today ?" style="border-radius:5px;height:40px;font-size:14pt;width: 600px">
<button type="submit"  " style="border-width:1px;border-radius:5px;height:40px;font-size:14pt;width: 150px;cursor:pointer;background-color:   #f1c40f";>Search</button>
</form>


<br>


<form action="cart" method="post">
<table border='1' id='table' align="center" style="visibility: hidden;">
 <TH>ID</TH>
                <TH>Name</TH>
                <TH>Price</TH>
                <TH>Quantity</TH>
                <TH> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</TH>
           
<tbody>

</tbody>
</table>
</form>



<!--  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
<div id="overlay">
     <div >
    <form  action="AddCustomer" method="post"    >  
Username&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;
<input id ="uname" type="text" style="color: #c0392b;height:20px;width:170px" name="Name"/>
<br/>
<br/>
Card Number:&nbsp;&nbsp;&nbsp;&nbsp;
<input id="cc" type="text" style="color: #c0392b;height:20px;width:170px" name="card"/>
<br/>
<br/>

Email&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input id="cc" type="text" style="color: #c0392b;height:20px;width:170px" name="email"/>
<br/>
<br/>
<input type="checkbox" name="isadmin" > User is an admin<br>
<br/>

<button type="submit" value="Submit" style="height:25px; width:60px">Submit </button>  
<button type="button" onclick="overlay()" value="Close" style="height:25px; width:60px">Close</button>
</form>  
         
     </div>
</div>
<!--  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ -->
<div id="addp">
     <div >
    <form  action="AddProduct" method="post"    >  
Product Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;
<input type="text" style="color: #c0392b;height:20px;width:170px" name="Name"/>
<br/>
<br/>
Quantity:&nbsp;&nbsp;&nbsp;&nbsp;
<input  type="text" style="color: #c0392b;height:20px;width:170px" name="qty"/>
<br/>
<br/>

Price:&nbsp;&nbsp;&nbsp;&nbsp;
<input  type="text" style="color: #c0392b;height:20px;width:170px" name="price"/>
<br/>
<br/>


<button type="submit" value="Submit" style="height:25px; width:60px">Submit </button>  
<button type="button" onclick="addp()" value="Close" style="height:25px; width:60px">Close</button>
</form>  
         
     </div>
</div>
<br/>
<br/>

<form id="checkout" action="checkout.jsp" style="display: none;">
<hr/>
<br/>
<h3>CheckOut Form</h3>
Email:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input  id="email" type="text" style="color: #c0392b;height:20px;width:170px" name="email"/><br/><br/>
Credit card:&nbsp;&nbsp;&nbsp;&nbsp;
<input  id="credit" type="text" style="color: #c0392b;height:20px;width:170px" name="email"/><br/><br/>

<button type="submit" style="border-width:1px;border-radius:5px;height:40px;font-size:14pt;width: 150px;cursor:pointer;background-color:   #f1c40f";>CheckOut</button>
<br/>
<br/>
</form>
<div id="blank" style="display: block;">
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>

<br/>
<br/>
</div>
<hr/>
<br/>
<br/>
<div id="removep">
<div >
<form  action="DeleteProduct" method="post">
<select id ="drop" name="droplist"></select>
<br/><br/>
<button type="submit" value="Submit" style="height:25px; width:60px">Submit </button>  
<button type="button" onclick="removep()" value="Close" style="height:25px; width:60px">Close</button>
 </form>
</div>
</div>


<div id="removec">
<div >
<form action="RemoveCustomer" method="post">
<select id ="dropc" name="droplist"></select>
<br/><br/>
<button type="submit" value="Submit" style="height:25px; width:60px">Submit </button>  
<button type="button" onclick="removec()" value="Close" style="height:25px; width:60px">Close</button>
 </form>
</div>
</div>
<div id="footer" style="text-align:center;vertical-align: middle;">
		<p>~~ © 2007-2016 All rights reserved ~~</p>
</div>

</body>
<script type="text/javascript"> window.onload = alertName(); </script>
<script type="text/javascript"> window.onload = searchdb(); </script>
</html>