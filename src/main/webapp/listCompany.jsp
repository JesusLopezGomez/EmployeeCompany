<%@page import="com.jacaranda.model.CompanyProject"%>
<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.model.Company"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Listado Company</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<%
	ArrayList<Company> companys = null;
			try{
				companys = (ArrayList<Company>) DbRepository.findAll(Company.class);%>
				<%@include file="./nav.jsp"%>
				<table class="table">
					<thead>
						<tr>
							<th scope="col">Id</th>
							<th scope="col">Nombre</th>
							<th scope="col">Direccion</th>
							<th scope="col">Ciudad</th>
							<th scope="col">Empleados</th>
						</tr>
					</thead>
					<%
					for (Company c: companys){
					%>
							<tr>
								<td><%=c.getId()%></td>
								<td><%=c.getName()%></td>
								<td><%=c.getAddress()%></td>
								<td><%=c.getCity()%></td>
								<td><table class="table">
									<%
										for (Employee e: c.getEmpleados()){
									%>
									<tr>
									<td>
										<%=e.getFirstName()%>
									</td>
									<tr>
									<%}%>
								</table>	
								<td>
					<%}%>			
				</table>
				
			<%}catch(Exception e){
				response.sendRedirect("msgError.jsp?error="+e.getMessage());
				return;
			}%>
	
</body>
</html>