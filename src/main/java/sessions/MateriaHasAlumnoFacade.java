/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package sessions;

import entidades.Alumno;
import entidades.Materia;
import entidades.MateriaHasAlumno;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import java.util.List;

/**
 *
 * @author Juan Pablo
 */
@Stateless
public class MateriaHasAlumnoFacade extends AbstractFacade<MateriaHasAlumno> {

    @PersistenceContext(unitName = "com.mycompany_alumno_war_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public MateriaHasAlumnoFacade() {
        super(MateriaHasAlumno.class);
    }

    // Método para obtener la lista de alumnos con sus materias
    public List<MateriaHasAlumno> findAlumnosConMaterias() {
        // Consulta para obtener la relación entre alumno y materia
        TypedQuery<MateriaHasAlumno> query = em.createQuery(
                "SELECT m FROM MateriaHasAlumno m JOIN FETCH m.alumno a JOIN FETCH m.materia",
                MateriaHasAlumno.class
        );
        return query.getResultList();
    }

    public List<MateriaHasAlumno> findMateriasByRegistro(int registro) {
        TypedQuery<MateriaHasAlumno> query = em.createQuery(
                "SELECT m FROM MateriaHasAlumno m JOIN FETCH m.alumno a JOIN FETCH m.materia WHERE a.registro = :registro",
                MateriaHasAlumno.class
        );
        query.setParameter("registro", registro);
        return query.getResultList();
    }

    public List<Alumno> findAlumnosByMateria(Materia materia) {
        return em.createQuery("SELECT m.alumno FROM MateriaHasAlumno m WHERE m.materia = :materia", Alumno.class)
                .setParameter("materia", materia)
                .getResultList();
    }

}
