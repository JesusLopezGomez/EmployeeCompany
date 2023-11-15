<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
<%@page import="java.sql.Date"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.Company"%>
<%@page import="java.util.ArrayList"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Añadir empleado</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<%	
		ArrayList<Company> Companys = null;
			try{
				Companys = (ArrayList<Company>) DbRepository.findAll(Company.class);%>
				<%@include file="./nav.jsp"%>
				<div class="container px-5 my-5">
				  <div class="row justify-content-center">
				    <div class="col-lg-8">
				      <div class="card border-0 rounded-3 shadow-lg">
				        <div class="card-body p-4">
				          <div class="text-center">
				            <div class="h1 fw-light">Registrar empleado</div>
				          </div>
				
				          <form method="get">
			
				            <div class="form-floating mb-3">
				    			<label for="exampleInputEmail1" class="form-label">First Name</label>
				    			<input type="text" class="form-control" id="fisrtName" name="fisrtName" placeholder="Enter First Name" required>
				            </div>
				
				            <div class="form-floating mb-3">
				                <label for="exampleInputEmail1" class="form-label">Last Name</label>
				    			<input type="text" class="form-control" id="lastName" name="lastName" placeholder="Enter Last Name" required>
				            </div>
				
				            <div class="form-floating mb-3">
								<label for="exampleInputEmail1" class="form-label">Email</label>
				    			<input type="email" class="form-control" id="email" name="email" placeholder="Enter Email" required>
				            </div>
				            
				            <div class="form-floating mb-3">
								<label for="exampleInputEmail1" class="form-label">Gender</label>
				    			<input type="text" class="form-control" id="gender" name="gender" placeholder="Enter Gender" required>
				            </div>
				            
				            <div class="form-floating mb-3">
								<label for="exampleInputEmail1" class="form-label">Date of Birth</label>
				    			<input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" placeholder="Enter Date of Birth" required>
				            </div>
				            
				            <div class="form-floating mb-3">
								<label for="exampleInputEmail1" class="form-label">Company's</label>
									<select id="companys" name="companys" class="custom-select"  required>
									<%
										for (Company c : Companys ){
									%>
									  <option value="<%=c.getId()%>"><%=c.getName()%></option>
									 <%}%>
									</select>
				            </div>
				            
        				    <div class="form-floating mb-3">
								<label for="exampleInputEmail1" class="form-label">Password</label>
				    			<input type="password" class="form-control" id="password" name="password" placeholder="Enter Password" required>
				            </div>
				            
				            <div class="form-floating mb-3">
								<label for="exampleInputEmail1" class="form-label">Confirm password</label>
				    			<input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Repeat password" required>
				            </div>
				            <!-- Submit button -->
				            <div class="d-grid">
				              	<button class="btn btn-primary btn-lg" id="submitButton" type="submit" name="submit">Save</button>
				            </div>
				          </form>
				        </div>
					        <%if(request.getParameter("submit") != null){ 
					      	  	String name = request.getParameter("fisrtName");
					      	  	String lastName = request.getParameter("lastName");
					      	  	String mail = request.getParameter("email");
					      	  	String gender = request.getParameter("gender");
					      	  	int id = Integer.valueOf(request.getParameter("companys"));;
					      	  	Date date;
							
					      	  	try{	        	  		
					       	  	date = Date.valueOf(request.getParameter("dateOfBirth"));
					      	  	}catch(Exception e){
					  				response.sendRedirect("msgError.jsp?error=Fecha erronea formato adecuado : yyyy-mm-dd");
					  				return;
					      	  	}
					
					      	  	String password = request.getParameter("password");
					      	  	String confirmPassword = request.getParameter("confirmPassword");
					
					      	  	
					      	  	if(password.equals(confirmPassword)){
					       	  	Company c = DbRepository.find(Company.class, id);
					       	  	
						       	DbRepository.addEntity(new Employee(name,
											lastName,
											mail,
											gender,
											date,
											c,
											password));  		
					      	  	}else{
					      	  		out.println("Error las contraseñas introducidas no son iguales.");
					      	  	}
					        }%>	
				      </div>
				    </div>
				  </div>
				</div>
				<%}catch(Exception e){
					response.sendRedirect("msgError.jsp?error="+e.getMessage());
					return;
				}%>
	
</body>
</html>