/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package sessions;

import entidades.Docente;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import java.util.List;

/**
 *
 * @author Juan Pablo
 */
@Stateless
public class DocenteFacade extends AbstractFacade<Docente> {

    @PersistenceContext(unitName = "com.mycompany_alumno_war_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public DocenteFacade() {
        super(Docente.class);
    }

    public List<Object[]> getMateriasYAlumnosPorDocente(int docenteId) {
        String sql = "SELECT m.nombre AS materia, a.nombre AS alumno "
                + "FROM materia m "
                + "JOIN materia_has_docente md ON m.idmateria = md.materia_idmateria "
                + "JOIN docente d ON md.docente_iddocente = d.iddocente "
                + "JOIN materia_has_alumno ma ON m.idmateria = ma.materia_idmateria "
                + "JOIN alumno a ON ma.alumno_idalumno = a.idalumno "
                + "WHERE d.iddocente = " + docenteId; 

        Query query = em.createNativeQuery(sql);
        return query.getResultList();
    }

}
