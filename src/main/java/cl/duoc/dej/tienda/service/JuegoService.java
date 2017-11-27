package cl.duoc.dej.tienda.service;

import cl.duoc.dej.tienda.entity.Juego;
import cl.duoc.dej.tienda.exception.JuegoNoEncontradoException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

@Stateless
public class JuegoService {

    static final long serialVersionUID = 11L;
    
    @PersistenceContext
    EntityManager em;

    Logger logger = Logger.getLogger(this.getClass().getSimpleName());

    public JuegoService() {
    }

    public Juego crearJuego(Juego juego) {
        em.persist(juego);
        return juego;
    }

    public List<Juego> getJuegos() {
        TypedQuery<Juego> query = em.createQuery("SELECT p FROM Juego p", Juego.class);
        return query.getResultList();
    }

    /**
     *
     * @param id
     * @return retorna el juego o nulo en caso de no ser encontrado
     */
    public Juego getJuegoById(Long id) {
        return em.find(Juego.class, id);
    }

    public List<Juego> buscarJuego(String nombreJuego, Long consolaId) {
        if (nombreJuego != null && !nombreJuego.isEmpty() && consolaId != null && consolaId > 0) {
            String jpql = "SELECT p FROM Juego p WHERE LOWER(p.nombre) LIKE :nombre AND p.consola.id = :consolaId";
            TypedQuery<Juego> query = em.createQuery(jpql, Juego.class);
            query.setParameter("nombre", "%" + nombreJuego + "%");
            query.setParameter("consolaId", consolaId);
            return query.getResultList();
        }

        if (nombreJuego != null && !nombreJuego.isEmpty()) {
            String jpql = "SELECT p FROM Juego p WHERE LOWER(p.nombre) LIKE :nombre";
            TypedQuery<Juego> query = em.createQuery(jpql, Juego.class);
            query.setParameter("nombre", "%" + nombreJuego + "%");
            return query.getResultList();
        }

        if (nombreJuego == null || nombreJuego.isEmpty()) {
            if (consolaId != null && consolaId > 0) {
                String jpql = "SELECT p FROM Juego p WHERE p.consola.id = :consolaId";
                TypedQuery<Juego> query = em.createQuery(jpql, Juego.class);                
                query.setParameter("consolaId", consolaId);
                return query.getResultList();
            }

        }

        // sino devuelve la lista completa de juegos
        return getJuegos();
    }

    public void eliminarJuego(Long juegoId) throws JuegoNoEncontradoException {
        Juego p = getJuegoById(juegoId);
        if (p == null) {
            String mensajeException = String.format("Juego con ID %s no encontrado para ser eliminado", juegoId);
            logger.log(Level.SEVERE, mensajeException);
            throw new JuegoNoEncontradoException(mensajeException);
        }
        em.remove(p);
    }

}
