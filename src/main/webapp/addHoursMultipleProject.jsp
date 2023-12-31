<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.mysql.cj.x.protobuf.MysqlxDatatypes.Array"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
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
<title>Añadir horas varios projectos</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<%if(session.getAttribute("employee") != null){ /*Cuando se ha logeado muestro el contenido*/%>
		
		<!-- Inicializo el mapa con el valor de la variable de session si esta no es nula
		y si es una inicializo el mapa vacío -->
		<%Map<Integer,LocalDateTime> mapProject = session.getAttribute("mapaProject") != null 
													? (HashMap<Integer,LocalDateTime>) session.getAttribute("mapaProject") 
															: new HashMap<Integer,LocalDateTime>();
		
		/*Cuando empieza a trabajar añado la key del proyecto con valor de ahora mismo al mapa y actualizo
		la variable de session si no ha ocurrido ningun problema*/
	    if(request.getParameter("start") != null){
	  	  try{		    		  
	  	  	mapProject.put(Integer.valueOf(request.getParameter("start")), LocalDateTime.now());
	  	  	session.setAttribute("mapaProject", mapProject);
	  	  }catch(Exception ex){
	  		  response.sendRedirect("msgError.jsp?error="+ex.getMessage());
	  	  }
  	  	
  	  	/*Cuando quiere parar de trabajar recupero el proyecto donde a trabajado, los segundos que ha trabajado
  	  	estos los recupero con el id del proyecto buscando en el mapa, recupero el empleado de la session,
  	  	creo un employeeProject con las claves que he recogido y el tiempo, una vez que lo creo compruebo si existe,
  	  	si existe edito el tiempo de trabajo, y si no existe creo el employeeProject con las claves y el tiempo, y
  	  	por último borro el id del proyecto del mapa y actualizo de nuevo la variable de session del mapa.*/
	    }else if(request.getParameter("stop") != null){
	   	  	try{		    	
	   	  		
	   	  		Project p = null;
	   	  		
	   	  		try{
	   	  			p = DbRepository.find(Project.class, Integer.valueOf(request.getParameter("stop")));
	   	  		}catch(Exception ex1){
		   	  		  response.sendRedirect("msgError.jsp?error="+ex1.getMessage());
	   	  		}
	       		
	   	  		int seconds = 0;
	   	  		try{
	   	  			seconds = (int) ChronoUnit.SECONDS.between(mapProject.get(Integer.valueOf(request.getParameter("stop"))), 
							LocalDateTime.now());
	   	  		}catch(Exception ex2){
		   	  		  response.sendRedirect("msgError.jsp?error="+ex2.getMessage());
	   	  		}
	   	  		
	   	  		EmployeeProject ep = new EmployeeProject(p,((Employee)session.getAttribute("employee")),seconds);
	   	  		
	        	if(DbRepository.find(ep) != null){
	        		ep.setMinute(DbRepository.find(ep).getMinute()+seconds);
	        		DbRepository.editEntity(ep);
	        	}else{//Y si no existe lo creo
	         		DbRepository.addEntity(ep);
	        	}
	   	  		
	   	  	  	mapProject.remove(Integer.valueOf(request.getParameter("stop")));
	   	  	  	session.setAttribute("mapaProject", mapProject);
	   	 	}catch(Exception ex){
	   	  		  response.sendRedirect("msgError.jsp?error="+ex.getMessage());
	   	  	  }
	    }
	
	%>
	<%@include file="nav.jsp" %>
		<div class="container px-5 my-5">
		  <div class="row justify-content-center">
		    <div class="col-lg-8">
		      <div class="card border-0 rounded-3 shadow-lg">
		        <div class="card-body p-4">
		          <div class="text-center">
		            <div class="h1 fw-light">Añadir horas varios projectos</div>
		          </div>
		          <br>
		          <form>
		            <div class="form-floating mb-3">
						<label for="exampleInputEmail1" class="form-label">Project's</label><br>
							<table class="table">
							<%
							/*Recupero la variable de session del empleado y recorro sus companyProjects,
							me mostrará todos los nombres de los proyectos activos a dia de hoy, y mostraré el botón
							de empezar a trabajar cuando no esté el id de proyecto en el mapa y mostraré el botón
							de para de trabajar en caso contrario, es decir cuando el mapa contenga el id del proyecto*/
								Employee e = (Employee) session.getAttribute("employee");
								for (CompanyProject cp : e.getCompany().getCompanyProject()){
									if(cp.getEnd().after(Date.valueOf(LocalDate.now()))){ //Aqui compruebo que el proyecto está activo y lo muestro%>
									<tr>
										<td><%=cp.getProject().getName()%></td>
										<%if(!mapProject.containsKey(cp.getProject().getId())){ %>
											<td><button class="btn btn-primary" type="submit" value="<%=cp.getProject().getId()%>" name="start">Empezar a trabajar</button></td>  		
										<%}else{%>
											<td><button class="btn btn-danger" type="submit" value="<%=cp.getProject().getId()%>" name="stop">Dejar de trabajar</button></td>  													
										<%}%>
									</tr>
									<%}%>
								<%}%>
							</table>
		            </div>		          
		            <!-- Submit button -->
		          <!-- End of contact form -->
         		   <button class="btn btn-info btn-ms mt-2" id="nameE" value="nameE" type="button" name="nameE"><%=((Employee)session.getAttribute("employee")).getFirstName()%></button>
		        </div>
		         </form>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- En el caso de no estar logeado se redirecciona al login -->
		<%}else{ 
			response.sendRedirect("./login.jsp");
			return;
		}%>
</body>
</html>