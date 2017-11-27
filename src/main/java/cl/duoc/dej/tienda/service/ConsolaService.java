package cl.duoc.dej.tienda.service;

import cl.duoc.dej.tienda.entity.Consola;
import cl.duoc.dej.tienda.exception.ConsolaNoEncontradaException;
import java.io.Serializable;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

@Stateless
public class ConsolaService implements Serializable {

    static final long serialVersionUID = 12L;
    
    @PersistenceContext
    EntityManager em;    
    
    Logger logger = Logger.getLogger(this.getClass().getSimpleName());

    // Constructores
    public ConsolaService() {
    }

    // métodos
    public Consola crearConsola(Consola consola) {
        em.persist(consola);
        return consola;
    }
    
    public Consola getConsolaById(Long consolaId) {
        Consola consola = em.find(Consola.class, consolaId);
        return consola;
    }
    
    public List<Consola> getConsolas() {
        TypedQuery<Consola> query = em.createQuery("SELECT c FROM Consola c", Consola.class);
        return query.getResultList();
    }
    
    public void eliminarConsola(Long consolaId) throws ConsolaNoEncontradaException {
        Consola c = getConsolaById(consolaId);
        if (c == null) {
            String mensajeException = String.format("Consola con ID %s no encontrada para ser eliminada", consolaId);
            logger.log(Level.SEVERE, mensajeException);
            throw new ConsolaNoEncontradaException(mensajeException);
        }
        em.remove(c);
    }
}
