<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alumnos</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/vista.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }

        .navbar-brand {
            color: #28b2a4 !important;
        }

        .navbar-nav .nav-link {
            font-size: 18px;
            padding: 10px 20px;
        }

        .carousel-inner > .carousel-item > img {
            margin: 0 auto;
            width: 100%;
            max-height: 500px;
            object-fit: cover;
        }

        .footer {
            text-align: center;
            padding: 20px;
            background-color: #f8f9fa;
            border-top: 1px solid #e7e7e7;
            position: relative;
            bottom: 0;
            width: 100%;
        }

        .footer a {
            color: #28b2a4;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <img alt="Logo" src="imagen/humo.png" style="width:50px; height:auto;">
                SISTEMA <span style="color:#28b2a4;">ALUMNOS</span>
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link" href="#">Inicio</a></li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="facultadesDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Facultades</a>
                        <div class="dropdown-menu" aria-labelledby="facultadesDropdown">
                            <c:forEach var="facultad" items="${facultades}">
                                <a class="dropdown-item" href="Facultad?facultadId=${facultad.idfacultad}">${facultad.nombre}</a>
                            </c:forEach>
                        </div>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="alumnosDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Alumnos</a>
                        <div class="dropdown-menu" aria-labelledby="alumnosDropdown">
                            <a class="dropdown-item" href="Listar">Listar Alumnos</a>
                            <a class="dropdown-item" href="ListarCarrera">Listar Carreras</a>
                            <a class="dropdown-item" href="ListarMaterias">Listar Materias</a>
                            <a class="dropdown-item" href="ListarAlumnosMaterias">Listar Alumnos con Materias</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="insertarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Insertar</a>
                        <div class="dropdown-menu" aria-labelledby="insertarDropdown">
                            <a class="dropdown-item" href="SolicitarDatosAlumno">Agregar Alumno</a>
                            <a class="dropdown-item" href="SolicitarDatosMateria">Agregar Materias</a>
                            <a class="dropdown-item" href="SolicitarDatosCarrera">Agregar Carreras</a>
                            <a class="dropdown-item" href="SolicitarDatosFacultad">Agregar Facultad</a>
                        </div>
                    </li>
                    <li class="nav-item"><a class="nav-link" href="SolicitarDatos">AlumnoMateria</a></li>
                    <li class="nav-item"><a class="nav-link" href="SolicitarDatosDocente">ListarDocente</a></li>
                </ul>
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item"><a class="nav-link" href="#"><img src="imagen/facenegro.png" alt="Facebook" style="width: 20px;"></a></li>
                    <li class="nav-item"><a class="nav-link" href="#"><img src="imagen/twitnegro.png" alt="Twitter" style="width: 20px;"></a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Carousel -->
    <div class="container my-4">
        <div id="myCarousel" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#myCarousel" data-slide-to="1"></li>
                <li data-target="#myCarousel" data-slide-to="2"></li>
                <li data-target="#myCarousel" data-slide-to="3"></li>
            </ol>

            <div class="carousel-inner" role="listbox">
                <div class="carousel-item active">
                    <img src="imagen/imagen1.jpg" alt="Imagen 1" class="d-block w-100">
                </div>
                <div class="carousel-item">
                    <img src="imagen/imagen2.jpg" alt="Imagen 2" class="d-block w-100">
                </div>
                <div class="carousel-item">
                    <img src="imagen/imagen3.jpg" alt="Imagen 3" class="d-block w-100">
                </div>
                <div class="carousel-item">
                    <img src="imagen/imagen5.jpg" alt="Imagen 5" class="d-block w-100">
                </div>
            </div>

            <!-- Controls -->
            <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2020 - Cátedra Tecnologías Web - <a href="http://www.unsj.edu.ar" target="_blank">unsj</a></p>
    </div>
</body>
</html>
