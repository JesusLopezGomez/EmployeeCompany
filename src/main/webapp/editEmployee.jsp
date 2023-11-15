<%@page import="org.apache.commons.codec.digest.DigestUtils"%>
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
	Employee es = (Employee)session.getAttribute("employee");
	
	Employee e = null;
	ArrayList<Company> companys = null;
	
	boolean verifyPassword = false;
	boolean verifyPasswordIncorrect = false;
	boolean invalidatePassword = false;
	boolean validateModify = false;
	
	if(es.getRole().equals("ADMIN") || String.valueOf(es.getId()).equals(request.getParameter("id"))){
			
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
	        	 
				e.setCompany(c);e.setDateOfBirth(date);e.setEmail(mail);e.setFirstName(name);
				e.setGender(gender);e.setLastName(lastName);
				
				if(request.getParameter("password") != ""){
					if(request.getParameter("password").toString().equals(request.getParameter("confirmPassword").toString())){
						e.setPassword(request.getParameter("password"));
						verifyPassword = true;
					}else{
						invalidatePassword = true;
					}
				}
	        	
		    	DbRepository.editEntity(e);
				validateModify = true;
	    	  	
			}catch(Exception ex2){
				response.sendRedirect("msgError.jsp?error=" + ex2.getMessage());
				return;
			}
		}if(request.getParameter("verifyOldpwd") != null || (request.getParameter("oldpassword") != null && !request.getParameter("oldpassword").equals(""))){
			verifyPassword = e.getPassword().equals(DigestUtils.md5Hex(request.getParameter("oldpassword").toString()));
			verifyPasswordIncorrect = !verifyPassword;

		}
	}else{%>
		<h3 class="text-info" align="center">Error los usuarios solo pueden editar sus datos, si tiene algún problema contacta con un admin.</h3>
	<%}%>
	
	
	<%if(e != null){/*Si el cine que hemos introducido es diferente a null muestro la informacion del cine*/ %>
        <%if(invalidatePassword){%>
        	<h3 class="text-info" align="center">Error las contraseñas deben coincidir</h3>
        <%}else if(validateModify){%>
        	<h3 class="text-info" align="center">Empleado modificado con éxito</h3>
        <%}%>
        <%if(es.getRole().toString().equalsIgnoreCase("admin") || verifyPassword){%>
        <form>
        <div class="container px-5 my-5">
		  <div class="row justify-content-center">
		    <div class="col-lg-8">
		      <div class="card border-0 rounded-3 shadow-lg">
		        <div class="card-body p-4">
		          <div class="text-center">
		            <div class="h1 fw-light">Editar empleado</div>
		          </div>
		            <!-- Cip Input -->
		           	<div class="form-floating mb-3">
		    			<label for="exampleInputEmail1" class="form-label">ID</label>
		    			<input type="text" class="form-control" id="id" name="id" value='<%=request.getParameter("id")%>' readonly>
		            </div>
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
						<%if(verifyPassword){%>
							<input type="email" step="1" class="form-control" id="email" name="email" placeholder="Enter email" value="<%=e.getEmail()%>" required readonly>						
		            	<%}else{%>
							<input type="email" step="1" class="form-control" id="email" name="email" placeholder="Enter email" value="<%=e.getEmail()%>" required>						
		            	<%}%>
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
								for (Company c : companys){
									if(c.getId() == e.getCompany().getId()){%>
										<option value="<%=c.getId()%>" selected><%=c.getName()%></option>
									<%}else{ %>
										<option value="<%=c.getId()%>"><%=c.getName()%></option>
									<%}
							 }%>
							</select>
		            </div>
               		<div class="form-floating mb-3">
       				    <div class="form-floating mb-3">
							<label for="exampleInputEmail1" class="form-label">New password</label>
			    			<input type="password" class="form-control" id="password" name="password" placeholder="Enter new password">
			            </div>
			            
			            <div class="form-floating mb-3">
							<label for="exampleInputEmail1" class="form-label">Confirm password</label>
			    			<input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Repeat new password">
			            </div>          	
		           	</div>
                    <div class="form-floating mb-3">
						<label for="exampleInputEmail1" class="form-label">Role</label>
						<%if(verifyPassword){%>
        			    	<input type="text" class="form-control" id="role" name="role" value="<%=e.getRole()%>" readonly>
		            	<%}else{%>
        			    	<input type="text" class="form-control" id="role" name="role" value="<%=e.getRole()%>">
		            	<%}%>
		            </div>
		            
		            <input type="text" class="form-control"  id="oldpassword" name="oldpassword" value="<%=request.getParameter("oldpassword") != null ? request.getParameter("oldpassword") : "" %>" hidden>
		            <!-- Submit button -->
		            <div class="d-grid">
		             	<button class="btn btn-danger btn-lg" id="submitButton" value="edit" type="submit" name="edit">Confirm</button>
		            </div>
		          <!-- End of contact form -->
		        </div>
		      </div>
		    </div>
		  </div>
		</div>
		</form>
        <%}else{%>
        <form>
        <%if(verifyPasswordIncorrect){%>
        	<h3 class="text-info" align="center">Contraseña incorrecta</h3>
        <%}%>
			<div class="container px-5 my-5">
				<div class="row justify-content-center">
					<div class="col-lg-8">
						<div class="card border-0 rounded-3 shadow-lg">
							<div class="card-body p-4">
		 						<div class="h1 fw-light text-center">Verify password</div>
								<label for="exampleInputEmail1" class="form-label">Old password</label> 
								<input type="text" class="form-control" id="id" name="id" value="<%=request.getParameter("id")%>" hidden>
								<input type="password" class="form-control"  id="oldpassword" name="oldpassword" placeholder="Enter your old password">
								<br>
								<button class="btn btn-outline-success btn-sm" id="verifyOldpwd" value="verifyOldpwd" type="submit" name="verifyOldpwd">Verify</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
		<%}%>	
	<%}%>
</body>
</html>