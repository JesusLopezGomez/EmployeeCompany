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
	<%if(session.getAttribute("employee")!= null){%>
		<div class="container px-5 my-5">
		  <div class="row justify-content-center">
		    <div class="col-lg-8">
		      <div class="card border-0 rounded-3 shadow-lg">
		        <div class="card-body p-4">
		          <div class="text-center">
		            <div class="h1 fw-light">Añadir horas projecto</div>
		          </div>
		          <form>
		            <div class="form-floating mb-3">
						<label for="exampleInputEmail1" class="form-label">Project's</label>
							<select id="companys" name="projects" class="custom-select"  required>
							<%
								Employee e = (Employee) session.getAttribute("employee");
								for (CompanyProject cp : e.getCompany().getCompanyProject()){
							%>
							  <option value="<%=cp.getProject().getName()%>"><%=cp.getProject().getName()%></option>
							 <%}%>
							</select>
		            </div>		          
		            <!-- Submit button -->
		            <div class="d-grid">
		            <%if(request.getParameter("start") == null){%>
		             	<button class="btn btn-primary btn-lg" id="start" value="login" type="submit" name="start">Start</button>
		            <%}else{%>
		            	<button class="btn btn-danger btn-lg" id="stop" value="login" type="submit" name="stop">Stop</button>
		            <%}%>
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