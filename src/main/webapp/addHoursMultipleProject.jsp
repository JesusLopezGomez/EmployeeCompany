<%@page import="com.jacaranda.model.EmployeeProject"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.chrono.ChronoLocalDateTime"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.sql.Date"%>
<%@page import="com.jacaranda.model.CompanyProject"%>
<%@page import="com.jacaranda.model.Project"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.model.User"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Añadir horas projecto</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<%if(session.getAttribute("employee") != null){ /*Cuando se ha logeado muestro el contenido*/%>
	<%@include file="nav.jsp" %>
		<div class="container px-5 my-5">
		  <div class="row justify-content-center">
		    <div class="col-lg-8">
		      <div class="card border-0 rounded-3 shadow-lg">
		        <div class="card-body p-4">
		          <div class="text-center">
		            <div class="h1 fw-light">Añadir horas projecto</div>
		          </div>
		          <form>
		          <%if(request.getParameter("start") == null ){ //Cuando no le de a empezar le muestro los proyectos disponibles%>
		            <div class="form-floating mb-3">
						<label for="exampleInputEmail1" class="form-label">Project's</label>
							<select id="projects" name="projects" class="custom-select" multiple="multiple">
							<%
								Employee e = (Employee) session.getAttribute("employee");
								for (CompanyProject cp : e.getCompany().getCompanyProject()){
									if(cp.getEnd().after(Date.valueOf(LocalDate.now()))){ //Aqui compruebo que el proyecto está activo y lo muestro%>
											  <option value="<%=cp.getProject().getId()%>"><%=cp.getProject().getName()%></option>
									<%}%>
								<%}%>
							 </select>
		            </div>
		            <%}else if(request.getParameter("start") != null ) {
		            	//Cuando ya empieza recupero el proyecto que ha seleccionado y lo muestro
		            	out.println(request.getParameter("projects"));
		            	Project	p = DbRepository.find(Project.class, Integer.valueOf(request.getParameter("projects")));
		            %>
			            <div class="form-floating mb-3">
							<label for="exampleInputEmail1" class="form-label">Project</label>
			    			<input type="text" class="form-control" id="project" name="project" value="<%=p.getName()%>" readonly>
			            	<!-- Oculto un input con el id para después recuperarla -->
			            	<input type="text" class="form-control" id="idProject" name="idProject" value="<%=p.getId()%>" hidden>
			            </div>
		            <%}%>		          
		            <!-- Submit button -->
		            <div class="d-grid">
		            <%if(request.getParameter("start") == null){//Muestro el botón cuando no haya empezado%>
		             	<button class="btn btn-primary btn-lg" id="start" value="start" type="submit" name="start">Start</button>
		            <%}else{
		            	//Y cuando empieze recupero la fecha de ahora mismo y la guardo en una session
		            	LocalDateTime ldt = LocalDateTime.now();
		            	session.setAttribute("time", ldt);
		            	//Y también muestro un botón de guardar
		            %>
		            <button class="btn btn-danger btn-lg" id="save" value="save" type="submit" name="save">Save</button>
		            <%}%>
		            </div>
		          <!-- End of contact form -->
         		   <button class="btn btn-info btn-ms mt-2" id="nameE" value="nameE" type="button" name="nameE"><%=((Employee)session.getAttribute("employee")).getFirstName()%></button>
		        </div>
		   		       <button class="btn btn-danger btn-lg" id="logOut" value="logOut" type="submit" name="logOut">Log out</button>
		          </form>
		      </div>
		      
		      <%if(request.getParameter("logOut") != null){
		    	  //Cuando le de al botón de logOut borro la session del empleado y lo mando al login
		    	  	session.removeAttribute("employee");
					response.sendRedirect("./login.jsp");
		      }%>
		    </div>
		  </div>
		</div>
		<%}else{ //Lo mando al login en el caso de que no esté logeado
			response.sendRedirect("./login.jsp");
		}%>
</body>
</html>