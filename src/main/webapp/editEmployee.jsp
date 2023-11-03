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
<title>Editar empleado</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<%@include file="./nav.jsp" %>
	<%
	Employee e = null;
	ArrayList<Company> companys = null;
	
	try{
		e = DbRepository.find(Employee.class, Integer.valueOf(request.getParameter("id")));
	}catch(Exception ex){
		response.sendRedirect("msgError.jsp?error=No has introducido id correcta");
		return;
	}
	
	try{
		companys = (ArrayList<Company>) DbRepository.findAll(Company.class);
	}catch(Exception ex1){
		response.sendRedirect("msgError.jsp?error="+ex1.getMessage());
		return;
	}
	
	if(request.getParameter("edit") != null){
		try{
    	  	String name = request.getParameter("firstName");
    	  	String lastName = request.getParameter("lastName");
    	  	String mail = request.getParameter("email");
    	  	String gender = request.getParameter("gender");
    	  	int id = 0;
    	  	try{
        	  	id = Integer.valueOf(request.getParameter("companys"));
    	  	}catch(Exception ex4){
				response.sendRedirect("msgError.jsp?error=Id de compañia incorrecto");
				return;
    	  	}

    	  	Date date;		
    	  	
    	  	try{	        	  		
        	  	date = Date.valueOf(request.getParameter("dateOfBirth"));
    	  	}catch(Exception ex3){
				response.sendRedirect("msgError.jsp?error=Fecha erronea formato adecuado : yyyy-mm-dd");
				return;
    	  	}
        	Company c = DbRepository.find(Company.class, id);
        	 
	    	e = new Employee(id,name,lastName,mail,gender,date,c);
	    	 
	    	DbRepository.editEntity(e);
    	  	
		}catch(Exception ex2){
			response.sendRedirect("msgError.jsp?error=" + ex2.getMessage());
			return;
		}
	}
	
	//if(session.getAttribute("rol") != null){

	%>
		<div class="container px-5 my-5">
		  <div class="row justify-content-center">
		    <div class="col-lg-8">
		      <div class="card border-0 rounded-3 shadow-lg">
		        <div class="card-body p-4">
		          <div class="text-center">
		            <div class="h1 fw-light">Editar empleado</div>
		          </div>
				<%if(e != null){/*Si el cine que hemos introducido es diferente a null muestro la informacion del cine*/ %>
		          <form>
		            <!-- Cip Input -->
		           	<div class="form-floating mb-3">
		    			<label for="exampleInputEmail1" class="form-label">ID</label>
		    			<input type="text" class="form-control" id="id" name="id" value='<%=request.getParameter("id")%>' readonly>
		            </div>
		           <!--<input type="text" class="form-control" id="id" name="id" value='' readonly> -->
		            <div class="form-floating mb-3">
		    			<label for="exampleInputEmail1" class="form-label">firstName</label>
		    			<input type="text" class="form-control" id="firstName" name="firstName" value='<%=e.getFirstName()%>' required>
		            </div>
		
		            <!-- Film title Input -->
		            <div class="form-floating mb-3">
		                <label for="exampleInputEmail1" class="form-label">lastName</label>
		    			<input type="text" class="form-control" id="lastName" name="lastName" placeholder="Enter lastName" value="<%=e.getLastName()%>" required>
		            </div>
		
		            <!-- Production year Input -->
		            <div class="form-floating mb-3">
						<label for="exampleInputEmail1" class="form-label">email</label>
		    			<input type="email" step="1" class="form-control" id="email" name="email" placeholder="Enter email" value="<%=e.getEmail()%>" required>
		            </div>
		            
		            <!-- Secundary title Input -->
		            <div class="form-floating mb-3">
						<label for="exampleInputEmail1" class="form-label">gender</label>
		    			<input type="text" class="form-control" id="gender" name="gender" placeholder="Enter gender" value="<%=e.getGender()%>">
		            </div>
		            
		            <!-- Nationality Input -->
		            <div class="form-floating mb-3">
						<label for="exampleInputEmail1" class="form-label">dateOfBirth</label>
		    			<input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" placeholder="Enter dateOfBirth" value="<%=e.getDateOfBirth()%>">
		            </div>
		            
            		<div class="form-floating mb-3">
						<label for="exampleInputEmail1" class="form-label">Company's</label>
							<select id="companys" name="companys" class="custom-select" required>
							<%
								for (Company c : companys ){
									if(c.getId() == e.getCompany().getId()){%>
										<option value="<%=c.getId()%>" selected><%=c.getName()%></option>
									<%}else{ %>
										<option value="<%=c.getId()%>"><%=c.getName()%></option>
									<%}
							 }%>
							</select>
		            </div>
		            
		            <%}%>
		            <!-- Submit button -->
		            <div class="d-grid">
		             	<button class="btn btn-danger btn-lg" id="submitButton" value="edit" type="submit" name="edit">Confirm</button></a>
		            </div>
		          </form>
		          <!-- End of contact form -->
		        </div>
		        <%//}%>
		      </div>
		    </div>
		  </div>
		</div>
</body>
</html>