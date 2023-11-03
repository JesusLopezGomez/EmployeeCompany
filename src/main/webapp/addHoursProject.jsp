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
	<%if(session.getAttribute("employee") != null){%>
		<div class="container px-5 my-5">
		  <div class="row justify-content-center">
		    <div class="col-lg-8">
		      <div class="card border-0 rounded-3 shadow-lg">
		        <div class="card-body p-4">
		          <div class="text-center">
		            <div class="h1 fw-light">Añadir horas projecto</div>
		          </div>
		          <form>
		          <%if(request.getParameter("start") == null){%>
		            <div class="form-floating mb-3">
						<label for="exampleInputEmail1" class="form-label">Project's</label>
							<select id="projects" name="projects" class="custom-select" >
							<%
								Employee e = (Employee) session.getAttribute("employee");
								for (CompanyProject cp : e.getCompany().getCompanyProject()){
									if(cp.getEnd().after(Date.valueOf(LocalDate.now()))){%>
											  <option value="<%=cp.getProject().getId()%>"><%=cp.getProject().getName()%></option>
									<%}%>
								<%}%>
							 </select>
							
		            </div>
		            <%}else if(request.getParameter("start") != null){
		            	Project	p = DbRepository.find(Project.class, Integer.valueOf(request.getParameter("projects")));
		            %>
			            <div class="form-floating mb-3">
							<label for="exampleInputEmail1" class="form-label">Project</label>
			    			<input type="text" class="form-control" id="project" name="project" value="<%=p.getName()%>" readonly>
			            </div>
		            <%}%>		          
		            <!-- Submit button -->
		            <div class="d-grid">
		            <%if(request.getParameter("start") == null){%>
		             	<button class="btn btn-primary btn-lg" id="start" value="start" type="submit" name="start">Start</button>
		            <%}else{
		            	LocalDateTime ldt = LocalDateTime.now();
		            	session.setAttribute("time", ldt);
		            %>
		            	<button class="btn btn-danger btn-lg" id="stop" value="stop" type="submit" name="stop">Stop</button>
		            <%}%>
		            <%if(request.getParameter("stop") != null){%>
		            	<%
		            	if(session.getAttribute("time")!= null){
		            		int seconds = (int) ChronoUnit.SECONDS.between(((LocalDateTime) session.getAttribute("time")), 
		            														LocalDateTime.now());
		            		out.println(seconds);
		            		if(session.getAttribute("cont") == null){
				            	session.setAttribute("cont",0);
		            		}
			            	session.setAttribute("cont",(int) session.getAttribute("cont")+seconds);
		            		out.println(session.getAttribute("cont"));
			            	session.removeAttribute("time");
		            	}
		            	%>
		            <%}%>
		            <button class="btn btn-danger btn-lg" id="save" value="save" type="submit" name="save">Save</button>
		            <%if(request.getParameter("save") != null){
		            	Project p = null;
		            	if(request.getParameter("projects") != null){
			            	 p = DbRepository.find(Project.class, Integer.valueOf(request.getParameter("projects")));
		            	}
		            	Employee e = null;
		            	
		            	try{
			            	e = ((Employee)session.getAttribute("employee"));
		            	}catch(Exception ex){
		            		response.sendRedirect("msgError.jsp?error="+ex.getMessage());
		            		return;
		            	}
		            	
		            	int cont = 0;
		            	if(session.getAttribute("cont") != null){
			            	 cont = (int) session.getAttribute("cont");
		            	}
		            	
		            	EmployeeProject ep = new EmployeeProject(p,e,cont);
		            	
		            	if(DbRepository.find(ep) != null){
		            		ep.setMinute(DbRepository.find(ep).getMinute()+cont);
		            		DbRepository.editEntity(ep);
		            	}else{
			            	DbRepository.addEntity(ep);
		            	}
		            	session.removeAttribute("cont");
		            }%>
		            </div>
		          </form>
		          <!-- End of contact form -->
		        </div>
		      </div>
		    </div>
		  </div>
		</div>
		<%}else{
			response.sendRedirect("./login.jsp");
		}%>
</body>
</html>