<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="entidades.MateriaHasAlumno" %>
<%@ page import="entidades.Alumno" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Materias de Alumno</title>
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
        <h2 class="text-center">Consultar Materias de Alumno</h2>
        <form action="SolicitarDatos" method="post" class="text-center">
            <input type="text" name="numeroRegistro" placeholder="Ingrese número de registro" class="form-control" style="width: 300px; display: inline-block; margin-bottom: 10px;">
            <input type="submit" value="Buscar" class="btn btn-primary">
        </form>

        <c:if test="${not empty materias}">
            <h3>Materias cursadas:</h3>
            <p>Total materias encontradas: ${materias.size()}</p>
            <table class="table table-bordered table-hover">
                <thead class="thead-dark">
                    <tr>
                        <th>Materia</th>
                        <th>Nota</th>
                        <th>Fecha</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="materia" items="${materias}">
                        <tr>
                            <td>${materia.materia.nombre}</td>
                            <td>${materia.nota}</td>
                            <td>${materia.materiaHasAlumnoPK.fecha}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${empty materias}">
            <p>No se encontraron materias para este alumno.</p>
        </c:if>
    </div>
</body>
</html>
