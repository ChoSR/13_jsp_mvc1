<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>main</title>

 <!-- Bootstrap core CSS -->
<link href="../css/bootstrap.min.css" rel="stylesheet"> 
<link href="../css/new-age.min.css" rel="stylesheet">
</head>
<body id="page-top">
	  <header class="masthead">
	    <div class="container h-100">
	      <div class="row h-100">
	        <div class="col-lg-7 my-auto">
	          <div class="header-content mx-auto">
	<%
				String id = (String)session.getAttribute("id");	
       			
				if (id == null) {
	%>
         			<h1 class="mb-5">JUST DO IT!</h1>
         			<a href="01_insert.jsp" class="btn btn-outline btn-xl js-scroll-trigger">Join!</a>
         			<a href="03_login.jsp" class="btn btn-outline btn-xl js-scroll-trigger">Login!</a>			         
	<% 
       			} 
       			else { 
	%>
					<h1 class="mb-5">Welcome!<%=id %></h1>
         			<a href="05_logout.jsp" class="btn btn-outline btn-xl js-scroll-trigger">Logout!</a>
         			<a href="06_delete.jsp" class="btn btn-outline btn-xl js-scroll-trigger">Delete!</a>
         			<a href="08_update.jsp" class="btn btn-outline btn-xl js-scroll-trigger">Modify!</a>
	<% 			          	
       			} 
	%>
		  	 </div>
           </div>
         <div class="col-lg-5 my-auto">
          <div class="device-container">
            <div class="device-mockup iphone6_plus portrait white">
              <div class="device">
                <div class="screen">
                  <img src="../img/main_image.PNG" class="img-fluid" alt="nike store">
                </div>         
              </div>
            </div>
          </div>
         </div>
      </div>
    </div>
  </header>				
</body>
</html>

