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
	
		<%if(request.getParameter("save") != null){%>
	       	<%//Cuando quiera guardar compruebo que el la session del tiempo no sea nula
	       	if(session.getAttribute("time")!= null){
	       		//Guardos los segundos que hay entre la fecha de la session y la fecha de ahora mismo
	       		int seconds = (int) ChronoUnit.SECONDS.between(((LocalDateTime) session.getAttribute("time")), 
	       														LocalDateTime.now());
	       		if(session.getAttribute("cont") == null){ //Si la session de contador es nula la creo
	         		session.setAttribute("cont",0);
	       		}
	       		//Ahora le asigno el tiempo que ya tenia más los segundos que he recuperado antes
	        	session.setAttribute("cont",(int) session.getAttribute("cont")+seconds);
	
	        	//Deje el projecto a nulo y despues lo busco con la id que he ocultado anteriormente
	        	Project p = null;
	        	if(request.getParameter("idProject") != null){
	         		p = DbRepository.find(Project.class, Integer.valueOf(request.getParameter("idProject")));
	        	}
	        	Employee e = null;
	        	//Recupero el empleado de la session
	        	try{
	         	e = ((Employee)session.getAttribute("employee"));
	        	}catch(Exception ex){
	        		response.sendRedirect("msgError.jsp?error="+ex.getMessage());
	        		return;
	        	}
	        	//Recupero el contador de la session
	        	int cont = 0;
	        	if(session.getAttribute("cont") != null){
	         	 cont = (int) session.getAttribute("cont");
	        	}
	        	//Y creo un employeeProject con los datos recuperados
	        	EmployeeProject ep = new EmployeeProject(p,e,cont);
	        	//Si el employeeProject existe le edito los segundos y lo edito en la base de datos
	        	if(DbRepository.find(ep) != null){
	        		ep.setMinute(DbRepository.find(ep).getMinute()+cont);
	        		DbRepository.editEntity(ep);
	        	}else{//Y si no existe lo creo
	         		DbRepository.addEntity(ep);
	        	}//Borro la session de cont para que empieze a contar de nuevo
	        	session.removeAttribute("cont");
	        	//Borro la session del tiempo
	        	session.removeAttribute("time"); 
	        	//Borro la session del tiempo
	        	session.removeAttribute("project"); 
	       		}
	       }%>
	       
		<div class="container px-5 my-5">
		  <div class="row justify-content-center">
		    <div class="col-lg-8">
		      <div class="card border-0 rounded-3 shadow-lg">
		        <div class="card-body p-4">
		          <div class="text-center">
		            <div class="h1 fw-light">Añadir horas projecto</div>
		          </div>
		          <form>
		          <%if(request.getParameter("start") == null && session.getAttribute("time") == null){ //Cuando no le de a empezar le muestro los proyectos disponibles%>
		            <div class="form-floating mb-3">
						<label for="exampleInputEmail1" class="form-label">Project's</label>
							<select id="projects" name="projects" class="custom-select" >
							<%
								Employee e = (Employee) session.getAttribute("employee");
								for (CompanyProject cp : e.getCompany().getCompanyProject()){
									if(cp.getEnd().after(Date.valueOf(LocalDate.now()))){ //Aqui compruebo que el proyecto está activo y lo muestro%>
											  <option value="<%=cp.getProject().getId()%>"><%=cp.getProject().getName()%></option>
									<%}%>
								<%}%>
							 </select>
							
		            </div>
		            <%}else if(request.getParameter("start") != null || session.getAttribute("time") != null) {
		            	//Cuando ya empieza recupero el proyecto que ha seleccionado y lo muestro
		            	if(session.getAttribute("project") == null){
			            	session.setAttribute("project", DbRepository.find(Project.class, Integer.valueOf(request.getParameter("projects"))));
		            	}
		            %>
			            <div class="form-floating mb-3">
							<label for="exampleInputEmail1" class="form-label">Project</label>
			    			<input type="text" class="form-control" id="project" name="project" value="<%=((Project)session.getAttribute("project")).getName()%>" readonly>
			            	<!-- Oculto un input con el id para después recuperarla -->
			            	<input type="text" class="form-control" id="idProject" name="idProject" value="<%=((Project)session.getAttribute("project")).getId()%>" hidden>
			            </div>
		            <%}%>		          
		            <!-- Submit button -->
		            <div class="d-grid">
		            <%if(request.getParameter("start") == null && session.getAttribute("time") == null){//Muestro el botón cuando no haya empezado%>
		             	<button class="btn btn-primary btn-lg" id="start" value="start" type="submit" name="start">Start</button>
		            <%}else{
		            	//Y cuando empieze recupero la fecha de ahora mismo y la guardo en una session
		            	if(session.getAttribute("time") == null){
			            	LocalDateTime ldt = LocalDateTime.now();
			            	session.setAttribute("time", ldt);
		            	}
		            	//Y también muestro un botón de guardar
		            %>
		            
		            <%
		            if(session.getAttribute("time") != null){ %>
          		    	<button class="btn btn-danger btn-lg" id="save" value="save" type="submit" name="save">Save</button>
		            <%}%>
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