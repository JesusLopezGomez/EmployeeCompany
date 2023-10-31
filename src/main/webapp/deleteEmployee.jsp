<%@page import="java.sql.Date"%>
<%@page import="com.jacaranda.model.Company"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Eliminar empleado</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<%@include file="./nav.jsp" %>
	<%
	Employee e = null;
	ArrayList<Company> Companys = null;
	
	try{
		e = DbRepository.find(Employee.class, Integer.valueOf(request.getParameter("id")));
	}catch(Exception ex){
		response.sendRedirect("msgError.jsp?error=No has introducido id correcta");
		return;
	}
	
	try{
		Companys = (ArrayList<Company>) DbRepository.findAll(Company.class);
	}catch(Exception ex1){
		response.sendRedirect("msgError.jsp?error="+ex1.getMessage());
		return;
	}
		
	%>
	<%if(e != null){/*Si el cine que hemos introducido es diferente a null muestro la informacion del cine*/ %>
		<div class="container px-5 my-5">
		  <div class="row justify-content-center">
		    <div class="col-lg-8">
		      <div class="card border-0 rounded-3 shadow-lg">
		        <div class="card-body p-4">
		          <div class="text-center">
		            <div class="h1 fw-light">Eliminar Empleado</div>
		          </div>
				
		          <form>
		            <!-- Cip Input -->
		           	<div class="form-floating mb-3">
		    			<label for="exampleInputEmail1" class="form-label">ID</label>
		    			<input type="text" class="form-control" id="id" name="id" value='<%=request.getParameter("id")%>' readonly>
		            </div>
		           <!--<input type="text" class="form-control" id="id" name="id" value='' readonly> -->
		            <div class="form-floating mb-3">
		    			<label for="exampleInputEmail1" class="form-label">firstName</label>
		    			<input type="text" class="form-control" id="firstName" name="firstName" value='<%=e.getFirstName()%>' readonly>
		            </div>
		
		            <!-- Film title Input -->
		            <div class="form-floating mb-3">
		                <label for="exampleInputEmail1" class="form-label">lastName</label>
		    			<input type="text" class="form-control" id="lastName" name="lastName" placeholder="Enter lastName" value="<%=e.getLastName()%>" readonly>
		            </div>
		
		            <!-- Production year Input -->
		            <div class="form-floating mb-3">
						<label for="exampleInputEmail1" class="form-label">email</label>
		    			<input type="email" step="1" class="form-control" id="email" name="email" placeholder="Enter email" value="<%=e.getEmail()%>" readonly>
		            </div>
		            
		            <!-- Secundary title Input -->
		            <div class="form-floating mb-3">
						<label for="exampleInputEmail1" class="form-label">gender</label>
		    			<input type="text" class="form-control" id="gender" name="gender" placeholder="Enter gender" value="<%=e.getGender()%>" readonly>
		            </div>
		            
		            <!-- Nationality Input -->
		            <div class="form-floating mb-3">
						<label for="exampleInputEmail1" class="form-label">dateOfBirth</label>
		    			<input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" placeholder="Enter dateOfBirth" value="<%=e.getDateOfBirth()%>" readonly>
		            </div>
		            
            		<div class="form-floating mb-3">
						<label for="exampleInputEmail1" class="form-label">Company</label>
						<input type="text" class="form-control" id="companys" name="companys" placeholder="Enter dateOfBirth" value="<%=e.getCompany().getName()%>" readonly>
		            </div>
		            
		            <!-- Submit button -->
		            <div class="d-grid">
		             	<button class="btn btn-danger btn-lg" id="submitButton" value="delete" type="submit" name="delete">Confirm</button>
		             		<%if(request.getParameter("delete") != null){
								try{	    	 
							    	DbRepository.deleteEntity(Employee.class, e.getId());%>
					             	<a href="listEmployee.jsp"><button class="btn btn-info btn-lg" id="submitButton" value="list" type="button" name="list">Return list</button></a>
								<%}catch(Exception ex2){
									response.sendRedirect("msgError.jsp?error=" + ex2.getMessage());
									return;
								}
							}%>
		            </div>
		          </form>
		          <%}else{
		  			response.sendRedirect("msgError.jsp?error=No hay ningun empleado con ese id");
		          }
		          %>
		          <!-- End of contact form -->
		        </div>
		      </div>
		    </div>
		  </div>
		</div>
</body>
</html>