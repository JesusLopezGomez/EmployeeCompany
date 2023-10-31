<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>nav</title>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-primary">
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link text-white" href="./listEmployee.jsp">Lista empleados</a>
      </li>
      <li class="nav-item">
        <a class="nav-link text-white" href="./listCompany.jsp">Lista compañias</a>
      </li>
      <li class="nav-item">
        <a class="nav-link text-white" href="./listCompanyProject.jsp">Lista compañias empleados</a>
      </li>
      <li class="nav-item">
        <a class="nav-link text-white" href="./addEmployee.jsp">Añadir empleado</a>
      </li>
      <li class="nav-item">
        <a class="nav-link text-white" href="./addCompanyProject.jsp">Añadir compañias projectos</a>
      </li>
    </ul>
  </div>
</nav>
</body>
</html>