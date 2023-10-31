<%@page import="com.jacaranda.model.CompanyProject"%>
<%@page import="com.jacaranda.model.Project"%>
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
<title>Añadir compañia projecto</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
	<%@include file="./nav.jsp" %>
	<%
	ArrayList<Project> projects = null;
	ArrayList<Company> companys = null;
	
	try{
		projects = (ArrayList<Project>) DbRepository.findAll(Project.class);
	}catch(Exception ex){
		response.sendRedirect("msgError.jsp?error=" + ex.getMessage());
		return;
	}
	
	try{
		companys = (ArrayList<Company>) DbRepository.findAll(Company.class);
	}catch(Exception ex1){
		response.sendRedirect("msgError.jsp?error="+ex1.getMessage());
		return;
	}
	
	%>
		<div class="container px-5 my-5">
		  <div class="row justify-content-center">
		    <div class="col-lg-8">
		      <div class="card border-0 rounded-3 shadow-lg">
		        <div class="card-body p-4">
		          <div class="text-center">
		            <div class="h1 fw-light">Añadir compañia projecto</div>
		          </div>
				<%if(projects != null && companys != null){/*Si el cine que hemos introducido es diferente a null muestro la informacion del cine*/ %>
		          <form>
            		<div class="form-floating mb-3">
						<label for="exampleInputEmail1" class="form-label">Company's</label>
							<select id="companys" name="companys" class="custom-select" required>
							<%
								for (Company c : companys ){%>
									<option value="<%=c.getId()%>"><%=c.getName()%></option>
							 <%}%>
							</select>
		            </div>
		            
		           	<div class="form-floating mb-3">
						<label for="exampleInputEmail1" class="form-label">Project's</label>
							<select id="companys" name="projects" class="custom-select" required>
							<% 
								for (Project p : projects){%>
									<option value="<%=p.getId()%>"><%=p.getName()%></option>
							 <%}%>
							</select>
		            </div>
		            
		        	<div class="form-floating mb-3">
						<label for="exampleInputEmail1" class="form-label">Start date</label>
		    			<input type="date" class="form-control" id="startDate" name="startDate" placeholder="Enter Start date">
		            </div>
		            
		            <div class="form-floating mb-3">
						<label for="exampleInputEmail1" class="form-label">End date</label>
		    			<input type="date" class="form-control" id="endDate" name="endDate" placeholder="Enter End date">
		            </div>
		            
		            <%}%>
		            <!-- Submit button -->
		            <div class="d-grid">
		             	<button class="btn btn-primary btn-lg" id="submitButton" value="save" type="submit" name="save">Save</button>
		            </div>
		            <% 
		            	if(request.getParameter("save") != null){
		            		Company c = null;
		            		Project p = null;
		            		
		            		try{
		            			c = DbRepository.find(Company.class, Integer.valueOf(request.getParameter("companys")));
		            		}catch(Exception ex){
		            			response.sendRedirect("msgError.jsp?error=" + ex.getMessage());
		            			return;
		            		}
		            		
		            		try{
		            			p = DbRepository.find(Project.class, Integer.valueOf(request.getParameter("projects")));
		            		}catch(Exception ex1){
		            			response.sendRedirect("msgError.jsp?error=" + ex1.getMessage());
		            			return;
		            		}
		            		
		            		if(p == null || c == null){
		            			response.sendRedirect("msgError.jsp?error=" + "Compañia o projecto inexistente");
		            			return;
		            		}
		            		
		            		try{
		            			CompanyProject cp = new CompanyProject(c,p,Date.valueOf(request.getParameter("startDate")),
		            														Date.valueOf(request.getParameter("endDate")));
		            			DbRepository.addEntity(cp);
		            		}catch(Exception ex2){
		            			response.sendRedirect("msgError.jsp?error=" + ex2.getMessage());
		            			return;

		            		}
		            	}
		            %>
		          </form>
		          <!-- End of contact form -->
		        </div>
		      </div>
		    </div>
		  </div>
		</div>
</body>
</html>