package cl.duoc.dej.tienda.service;

import cl.duoc.dej.tienda.entity.Cliente;
import cl.duoc.dej.tienda.entity.LineaPedido;
import cl.duoc.dej.tienda.entity.Pedido;
import cl.duoc.dej.tienda.entity.Juego;
import cl.duoc.dej.tienda.entity.Vendedor;
import java.io.Serializable;
import javax.ejb.EJB;
import javax.ejb.Stateless;

@Stateless
public class PedidoBuilder implements Serializable {

    static final long serialVersionUID = 52L;
    
    Pedido pedido;
    
    @EJB
    JuegoService juegoService;
    @EJB
    ClienteService clienteService;
    @EJB
    VendedorService vendedorService;
    
    public PedidoBuilder() {
        pedido = new Pedido();
    }
    
    public PedidoBuilder setCliente(Long clienteId) {
        Cliente cliente = clienteService.getClienteById(clienteId);
        pedido.setCliente(cliente);
        return this;
    }
    
    public PedidoBuilder setVendedor(Long vendedorId) {
        Vendedor vendedor = vendedorService.getVendedoryById(vendedorId);
        pedido.setVendedor(vendedor);
        return this;
    }
    
    public PedidoBuilder agregarJuego(Long juegoId, int cantidad) {
        Juego juego = juegoService.getJuegoById(juegoId);
        LineaPedido lineaPedido = new LineaPedido(juego, cantidad, juego.getPrecio());
        pedido.getLineasPedido().add(lineaPedido);
        return this;
    }

    public Pedido build() {
        Pedido p = pedido;
        pedido = new Pedido();
        return p;
    }

    
    
    
}
