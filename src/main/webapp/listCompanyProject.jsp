<%@page import="com.jacaranda.model.Employee"%>
<%@page import="com.jacaranda.model.Company"%>
<%@page import="com.jacaranda.repository.DbRepository"%>
<%@page import="com.jacaranda.model.CompanyProject"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Lista CompanyProject</title>
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
						<th scope="col">Nombre</th>
						<th scope="col">Num empleados</th>
						<th scope="col">Num proyecto</th>
					</tr>
				</thead>
				<%
				for (Company c: companys){
				%>
						<tr>
							<td><%=c.getName()%></td>
							<td><%=c.getEmpleados().size()%></td>
							<td><%=c.getCompanyProject().size()%></td>
							<tr>
								<td>
								<b>Empleados</b>
								</td>
								<tr>
								 <%
									for (Employee e: c.getEmpleados()){
								%>
									<tr>
										<td><%=e.getFirstName()%></td>
									</tr>
								<%}%>
								<td></td>
								</tr>
							</tr>
												<tr>
								<td>
								<b>Projectos</b>
								</td>
								<tr>
								 <%
									for (CompanyProject e: c.getCompanyProject()){
								%>
									<tr>
										<td><%=e.getProject().getName() + ", " + e.getProject().getButget()%></td>
									</tr>
								<%}%>
								<td></td>
								</tr>
							</tr>
						</tr>	
				<%}%>			
			</table>
				
			<%}catch(Exception e){
				response.sendRedirect("msgError.jsp?error="+e.getMessage());
				return;
			}%>
	
	

</body>
</html>