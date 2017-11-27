package cl.duoc.dej.tienda.entity;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.persistence.ManyToOne;

@Embeddable
public class LineaPedido implements Serializable {

    static final long serialVersionUID = 564654L;
    
    @ManyToOne
    Juego juego;
    @Column(nullable = false)
    int cantidad;
    @Column(nullable = false)
    Long precio;

    // Constructores
    public LineaPedido() {
    }

    public LineaPedido(Juego juego, int cantidad) {
        this.juego = juego;
        this.cantidad = cantidad;
        this.precio = juego.getPrecio();
    }
    
    public LineaPedido(Juego juego, int cantidad, Long precio) {
        this.juego = juego;
        this.cantidad = cantidad;
        this.precio = precio;
    }
    
    // Cálculos
    public Long getSubtotal() {
        return cantidad * precio;
    }
    
    
    // getters y setters
    public Juego getJuego() {
        return juego;
    }

    public void setJuego(Juego juego) {
        this.juego = juego;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public Long getPrecio() {
        return precio;
    }

    public void setPrecio(Long precio) {
        this.precio = precio;
    }

}
