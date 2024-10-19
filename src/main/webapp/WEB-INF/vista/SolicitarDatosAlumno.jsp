<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE HTML>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Agregar Alumno</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f0f0f0;
        }
        h1 {
            color: #333;
        }
        form {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Nuevo Alumno</h1>
        <form action="AgregarAlumno" method="post">
            <div class="form-group">
                <label for="registro">Registro:</label>
                <input type="text" class="form-control" id="registro" name="registro" required>
            </div>
            <div class="form-group">
                <label for="nombre">Nombre:</label>
                <input type="text" class="form-control" id="nombre" name="nombre" required>
            </div>
            <div class="form-group">
                <label for="carrera">Carrera:</label>
                <select class="form-control" id="carrera" name="carrera" required>
                    <option value="">Seleccionar...</option>
                    <c:forEach var="carrera" items="${listaCarreras}">
                        <option value="${carrera.idcarrera}">${carrera.nombre}</option>
                    </c:forEach>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Crear</button>
        </form>
        <div class="mt-3">
            <a href="javascript:window.history.back();" class="btn btn-secondary">&laquo; Volver atrás</a>
            <a href="./index.jsp" class="btn btn-secondary">Volver</a>
        </div>
    </div>
</body>
</html>
