package controlador;

import entidades.Alumno;
import entidades.Carrera;
import entidades.Docente;
import entidades.Facultad;
import entidades.Materia;
import entidades.MateriaHasAlumno;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.ws.rs.NotSupportedException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import sessions.AlumnoFacade;
import sessions.CarreraFacade;
import sessions.DocenteFacade;
import sessions.FacultadFacade;
import sessions.MateriaFacade;
import sessions.MateriaHasAlumnoFacade;

@WebServlet(name = "Manejador",
        loadOnStartup = 1, //Para que el sevlet se  instancia e inicia cdo se depliega 
        urlPatterns = {
            "/SolicitarDatosAlumno",
            "/AgregarAlumno",
            "/Listar",
            "/ListarCarrera",
            "/ListarMaterias",
            "/ListarAlumnosMaterias",
            "/SolicitarDatosCarrera",
            "/RegistrarCarrera",
            "/SolicitarDatosMateria",
            "/RegistrarMateria",
            "/SolicitarDatosFacultad",
            "/RegistrarFacultad",
            "/SolicitarDatos",
            "/Facultad",
            "/SolicitarDatosDocente"
        }
)

public class Manejador extends HttpServlet {

    @EJB
    private AlumnoFacade alumnoF;
    @EJB
    private CarreraFacade carreraF;
    @EJB
    private MateriaFacade materiaF;
    @EJB
    private FacultadFacade facultadF;
    @EJB
    private MateriaHasAlumnoFacade materiaAlumnoF;
    @EJB
    private DocenteFacade docenteF;

    @Override
    public void init() throws ServletException {
        // Almacena la lista de facultades en el contexto del Servlet
        getServletContext().setAttribute("facultades", facultadF.findAll());
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, jakarta.transaction.NotSupportedException, jakarta.transaction.RollbackException {
        try {
            //response.setContentType("text/html;charset=UTF-8");
            String pathUsuario = request.getServletPath();
            System.out.println("path = " + pathUsuario);
            String url = null;
            switch (pathUsuario) {

                case "/SolicitarDatosAlumno":

                    request.setAttribute("listaCarreras", carreraF.findAll());
                    url = "/WEB-INF/vista/" + pathUsuario + ".jsp";
                    break;

                case "/AgregarAlumno":

                    String registro = (String) request.getParameter("registro");
                    String nombre = (String) request.getParameter("nombre");
                    String carrera = (String) request.getParameter("carrera");

                    Alumno a = new Alumno();
                    a.setRegistro(Integer.valueOf(registro));
                    a.setNombre(nombre);

                    // buscar la carrera
                    Carrera carreraEntidad = carreraF.find(Integer.valueOf(carrera));
                    a.setCarreraIdcarrera(carreraEntidad);

                    alumnoF.create(a);
                    url = "index.jsp";
                    break;

                case "/Listar":

                    request.setAttribute("lista", alumnoF.findAll());
                    url = "/WEB-INF/vista/" + pathUsuario + ".jsp";
                    break;

                case "/ListarCarrera":

                    request.setAttribute("carreras", carreraF.findAll());
                    url = "/WEB-INF/vista/ListarCarrera.jsp";
                    break;

                case "/ListarMaterias":

                    request.setAttribute("materias", materiaF.findAll());
                    url = "/WEB-INF/vista/ListarMaterias.jsp";
                    break;

                case "/ListarAlumnosMaterias":

                    List<MateriaHasAlumno> alumnosConMaterias = materiaAlumnoF.findAlumnosConMaterias();
                    request.setAttribute("alumnosMaterias", alumnosConMaterias);
                    url = "/WEB-INF/vista/ListarAlumnosMaterias.jsp";
                    break;

                case "/SolicitarDatosCarrera":

                    request.setAttribute("listaFacultades", facultadF.findAll());
                    url = "/WEB-INF/vista/" + pathUsuario + ".jsp";
                    break;

                case "/RegistrarCarrera":

                    String nombreC = (String) request.getParameter("nombre");
                    String facultadId = request.getParameter("facultad");

                    Facultad fac = facultadF.find(Integer.valueOf(facultadId));
                    Carrera c = new Carrera();

                    c.setNombre(nombreC);
                    c.setFacultadIdfacultad(fac);

                    carreraF.create(c);
                    url = "index.jsp";
                    break;

                case "/SolicitarDatosMateria":

                    url = "/WEB-INF/vista/" + pathUsuario + ".jsp";
                    break;

                case "/RegistrarMateria":

                    String nombreM = (String) request.getParameter("nombre");
                    Materia m = new Materia();
                    m.setNombre(nombreM);
                    materiaF.create(m);
                    url = "index.jsp";
                    break;

                case "/SolicitarDatosFacultad":

                    url = "/WEB-INF/vista/" + pathUsuario + ".jsp";
                    break;

                case "/RegistrarFacultad":

                    String nombreF = (String) request.getParameter("nombre");
                    Facultad f = new Facultad();
                    f.setNombre(nombreF);
                    facultadF.create(f);
                    url = "index.jsp";
                    break;

                case "/SolicitarDatos":
                    String numeroRegistro = request.getParameter("numeroRegistro"); // Recibir el número de registro del alumno

                    if (numeroRegistro != null && !numeroRegistro.trim().isEmpty()) {
                        try {
                            int numeroRegistroInt = Integer.parseInt(numeroRegistro); // Convertir el número de registro a int

                            // Depurar: imprimir el número de registro que estás buscando
                            System.out.println("Buscando materias para el alumno con registro: " + numeroRegistroInt);

                            // Busca las materias por el número de registro del alumno
                            List<MateriaHasAlumno> materiasAlumno = materiaAlumnoF.findMateriasByRegistro(numeroRegistroInt);

                            if (materiasAlumno != null && !materiasAlumno.isEmpty()) {
                                request.setAttribute("materias", materiasAlumno);
                            } else {
                                System.out.println("No se encontró ningún alumno con materias para el registro: " + numeroRegistroInt);
                                request.setAttribute("error", "No se encontró ningún alumno con ese número de registro.");
                            }
                        } catch (NumberFormatException e) {
                            request.setAttribute("error", "El número de registro debe ser un valor numérico válido.");
                        }
                    } else {
                        request.setAttribute("error", "Debe proporcionar un número de registro.");
                    }

                    url = "/WEB-INF/vista/SolicitarDatos.jsp";
                    break;

                case "/Facultad":
                    String facultadIdStr = request.getParameter("facultadId"); 
                    if (facultadIdStr != null && !facultadIdStr.isEmpty()) {
                        try {
                            Integer nroFacultad = Integer.parseInt(facultadIdStr);  // Convierte el parámetro a entero
                            entidades.Facultad miFacu = facultadF.find(nroFacultad); // Encuentra la facultad
                            Collection<Carrera> listaCarreras = miFacu.getCarreraCollection(); // Obtiene las carreras
                            getServletContext().setAttribute("facultad", miFacu);
                            getServletContext().setAttribute("listaCarreras", listaCarreras); // Pasa la lista de carreras al JSP
                            url = "/WEB-INF/vista/ListarFacuCarre.jsp";
                        } catch (NumberFormatException e) {
                            // Manejar el error de formato numérico
                            request.setAttribute("error", "El código de la facultad no es válido.");
                            url = "/WEB-INF/vista/error.jsp";
                        }
                    } else {
                        // Manejar el caso donde el parámetro es nulo o vacío
                        request.setAttribute("error", "No se recibió el código de la facultad.");
                        url = "/WEB-INF/vista/error.jsp";
                    }
                    break;

                case "/SolicitarDatosDocente":
                    String docenteIdStr = request.getParameter("docenteId");
                    if (docenteIdStr != null && !docenteIdStr.isEmpty()) {
                        try {
                            int docenteId = Integer.parseInt(docenteIdStr);
                            List<Object[]> resultado = docenteF.getMateriasYAlumnosPorDocente(docenteId);
                            if (resultado != null && !resultado.isEmpty()) {
                                request.setAttribute("alumnosDocente", resultado);
                            } else {
                                request.setAttribute("error", "No se encontraron alumnos para este docente.");
                            }
                        } catch (NumberFormatException e) {
                            request.setAttribute("error", "El ID del docente debe ser un valor numérico válido.");
                        }
                    } else {
                        request.setAttribute("error", "Debe proporcionar un ID de docente.");
                    }
                    url = "/WEB-INF/vista/SolicitarDatosDocente.jsp";
                    break;

            }
            // usa RequestDispatcher para reTransmitir el requerimiento
            try {
                request.getRequestDispatcher(url).forward(request, response);
            } catch (ServletException | IOException ex) {
            }

        } catch (NotSupportedException ex) {
            Logger.getLogger(Manejador.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (jakarta.transaction.NotSupportedException | jakarta.transaction.RollbackException ex) {
            Logger.getLogger(Manejador.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (jakarta.transaction.NotSupportedException | jakarta.transaction.RollbackException ex) {
            Logger.getLogger(Manejador.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
