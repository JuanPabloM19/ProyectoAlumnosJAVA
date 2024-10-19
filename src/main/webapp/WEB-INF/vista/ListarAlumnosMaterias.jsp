<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listado de Alumnos con Materias</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f0f0f0;
        }
        h1 {
            color: #333;
        }
        table {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-center">Listado de Alumnos con Materias</h1>
        <hr>
        <table class="table table-bordered table-hover">
            <thead class="thead-dark">
                <tr>
                    <th>Registro Alumno</th>
                    <th>Nombre Alumno</th>
                    <th>Nombre Materia</th>
                    <th>Nota</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="relacion" items="${requestScope.alumnosMaterias}">
                    <tr>
                        <td>${relacion.alumno.registro}</td>
                        <td>${relacion.alumno.nombre}</td>
                        <td>${relacion.materia.nombre}</td>
                        <td>${relacion.nota}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
