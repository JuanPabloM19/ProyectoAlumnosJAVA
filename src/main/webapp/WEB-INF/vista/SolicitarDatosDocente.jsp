<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Alumnos por Docente</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f0f0f0;
        }
        h2 {
            color: #333;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Consultar Alumnos por Docente</h2>
        <form action="SolicitarDatosDocente" method="post" class="mb-4">
            <input type="text" name="docenteId" placeholder="Ingrese ID de docente" class="form-control" required>
            <button type="submit" class="btn btn-primary mt-2">Buscar</button>
        </form>

        <c:if test="${not empty alumnosDocente}">
            <h3>Alumnos que rindieron materias:</h3>
            <table class="table table-bordered table-hover">
                <thead class="thead-dark">
                    <tr>
                        <th>Materia</th>
                        <th>Alumno</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="fila" items="${alumnosDocente}">
                        <tr>
                            <td>${fila[0]}</td> <!-- Materia -->
                            <td>${fila[1]}</td> <!-- Alumno -->
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${empty alumnosDocente}">
            <p>No se encontraron alumnos para este docente.</p>
        </c:if>
        <c:if test="${not empty error}">
            <p style="color:red;">${error}</p>
        </c:if>
    </div>
</body>
</html>
