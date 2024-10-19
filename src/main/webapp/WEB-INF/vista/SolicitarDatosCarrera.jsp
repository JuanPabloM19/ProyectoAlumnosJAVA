<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Solicitar Datos Carrera</title>
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
        <h2>Registrar Nueva Carrera</h2>
        <form action="RegistrarCarrera" method="post">
            <div class="form-group">
                <label for="nombre">Nombre de la Carrera:</label>
                <input type="text" class="form-control" id="nombre" name="nombre" required>
            </div>
            <div class="form-group">
                <label for="facultad">Seleccionar Facultad:</label>
                <select class="form-control" id="facultad" name="facultad" required>
                    <option value="">Seleccionar...</option>
                    <c:forEach var="facultad" items="${listaFacultades}">
                        <option value="${facultad.idfacultad}">${facultad.nombre}</option>
                    </c:forEach>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Registrar</button>
        </form>
        <div class="mt-3">
            <a href="./index.jsp" class="btn btn-secondary">Volver</a>
        </div>
    </div>
</body>
</html>
