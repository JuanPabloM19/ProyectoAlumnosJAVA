<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Lista de Carreras</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f0f0f0;
        }
        h1 {
            color: #333;
        }
        ul {
            margin-top: 20px;
            list-style-type: none;
        }
        li {
            background-color: #fff;
            padding: 10px;
            margin: 5px 0;
            border-radius: 4px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Carreras de la Facultad: ${facultad.nombre}</h1>
        <ul>
            <c:choose>
                <c:when test="${not empty listaCarreras}">
                    <c:forEach var="carrera" items="${listaCarreras}">
                        <li>${carrera.nombre}</li>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <li>No hay carreras disponibles para esta facultad.</li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</body>
</html>
