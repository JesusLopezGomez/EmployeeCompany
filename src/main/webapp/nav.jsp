<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>nav</title>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-secondary">
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
<% 
	if(session.getAttribute("employee") == null){
		response.sendRedirect("./login.jsp");
		return;
	}
%>
  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link text-white" href="./listEmployee.jsp">Lista empleados</a>
      </li>
      <li class="nav-item">
        <a class="nav-link text-white" href="./listCompany.jsp">Lista compañias</a>
      </li>
      <li class="nav-item">
        <a class="nav-link text-white" href="./listCompanyProject.jsp">Lista compañias projectos</a>
      </li>
      <li class="nav-item">
        <a class="nav-link text-white" href="./addEmployee.jsp">Añadir empleado</a>
      </li>
      <li class="nav-item">
        <a class="nav-link text-white" href="./addCompanyProject.jsp">Añadir compañias projectos</a>
      </li>
      <li class="nav-item">
        <a class="nav-link text-white" href="./addHoursProject.jsp">Añadir horas projecto</a>
      </li>
      <li class="nav-item">
        <a class="nav-link text-white" href="./addHoursMultipleProject.jsp">Añadir horas varios projectos</a>
      </li>
    </ul>
    <form>
		<div class="justify-content-end">
			<%if(session.getAttribute("employee") != null){ %>
				<button class="btn btn-outline-warning btn-lg" id="logOut" value="logOut" type="submit" name="logOut">Log out</button>
			<%}%>
		</div>
	</form>
      <!-- Cuando le de al botón de logOut borro la session del empleado y se redirecciona al login -->
     <%if(request.getParameter("logOut") != null){
   	  	session.removeAttribute("employee");
		response.sendRedirect("./login.jsp");
		return;
     }%>
  </div>
</nav>
</body>
</html>