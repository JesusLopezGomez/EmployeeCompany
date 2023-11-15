<%@page import="java.util.ArrayList"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="java.util.List"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Listado Empleados</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<%
	ArrayList<Employee> employes = null;
			try{
				employes = (ArrayList<Employee>) DbRepository.findAll(Employee.class);%>
				<%@include file="./nav.jsp"%>
				<%if(session.getAttribute("rol") != null){%>
					
				
				<table class="table">
					<thread>
						<tr>
							<th scope="col">Id</th>
							<th scope="col">Nombre</th>
							<th scope="col">Apellidos</th>
							<th scope="col">Email</th>
							<th scope="col">Género</th>
							<th scope="col">Fecha de nacimiento</th>
							<th scope="col">Nombre Compañía</th>
							<%if(session.getAttribute("rol").equals("ADMIN")){ %>
							<th scope="col">Editar</th>
							<th scope="col">Eliminar</th>
							<%} %>
			
						</tr>
					</thread>
					<%
					for (Employee e: employes){
					%>
							<tr>
								<td><%=e.getId()%></td>
								<td><%=e.getFirstName()%></td>
								<td><%=e.getLastName()%></td>
								<td><%=e.getEmail()%></td>
								<td><%=e.getGender()%></td>
								<td><%=e.getDateOfBirth()%></td>
								<td><%=e.getCompany().getName()%></td>
								<%if(session.getAttribute("rol").toString().equalsIgnoreCase("ADMIN")){ %>
								<td><a href="editEmployee.jsp?id=<%=e.getId()%>"><button type="button" class="btn btn-primary btn-lg">Editar</button></a></td>
								<td><a href="deleteEmployee.jsp?id=<%=e.getId()%>"><button type="button" class="btn btn-primary btn-lg">Eliminar</button></a></td>
								<%}%>
							</tr>
					<%}%>
				</table>
				<%}else{
					response.sendRedirect("./login.jsp");
				}%>
				
			<%}catch(Exception e){
				response.sendRedirect("msgError.jsp?error="+e.getMessage());
				return;
			}%>
	

</body>
</html>