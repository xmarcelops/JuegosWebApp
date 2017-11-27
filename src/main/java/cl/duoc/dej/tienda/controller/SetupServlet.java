package cl.duoc.dej.tienda.controller;

import cl.duoc.dej.tienda.entity.Consola;
import cl.duoc.dej.tienda.entity.Cliente;
import cl.duoc.dej.tienda.entity.Pedido;
import cl.duoc.dej.tienda.entity.Juego;
import cl.duoc.dej.tienda.entity.Vendedor;
import cl.duoc.dej.tienda.service.ConsolaService;
import cl.duoc.dej.tienda.service.ClienteService;
import cl.duoc.dej.tienda.service.PedidoBuilder;
import cl.duoc.dej.tienda.service.PedidoService;
import cl.duoc.dej.tienda.service.JuegoService;
import cl.duoc.dej.tienda.service.VendedorService;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "SetupServlet", urlPatterns = {"/setup"})
public class SetupServlet extends HttpServlet {

    @EJB
    ConsolaService consolaService;

    @EJB
    JuegoService juegoService;
    
    @EJB
    VendedorService vendedorService;
    
    @EJB
    ClienteService clienteService;
    
    @EJB
    PedidoService pedidoService;
    
    @EJB
    PedidoBuilder pedidoBuilder;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> mensajes = new ArrayList<>();
        List<String> errores = new ArrayList<>();

        try {
            Vendedor vendedor1 = new Vendedor("Marcelo Pereira", 18188947, '0', "mpereira", "1234");
            Vendedor vendedor2 = new Vendedor("Matias Quintanilla", 19646541, 'k', "mquintanilla", "1234");
            vendedorService.crearVendedor(vendedor1);
            vendedorService.crearVendedor(vendedor2);
            mensajes.add( String.format("Vendedor %s creado con ID %s", vendedor1.getUsuario()+":"+vendedor1.getContrasena(), vendedor1.getId()) );
            mensajes.add( String.format("Vendedor %s creado con ID %s", vendedor2.getUsuario()+":"+vendedor2.getContrasena(), vendedor2.getId()) );
 
            Calendar fechaNacimiento = Calendar.getInstance();
            fechaNacimiento.add(Calendar.YEAR, -20);
            Cliente cliente1= new Cliente("Cristobal Arevalo", 12345678, '5', "Av Mexico 10654", "Puente Alto", fechaNacimiento);
            Cliente cliente2 = new Cliente("Gonzalo Moreira", 13245678, '4', "San Carlos 6654", "Puente Alto", fechaNacimiento);
            Cliente cliente3= new Cliente("Fabiola Saez", 212345678, '3', "Concha y Toro 659", "Puente Alto", fechaNacimiento);
            Cliente cliente4= new Cliente("Diego Muñoz", 69874563, '2', "Av Colombia 56324", "Puente Alto", fechaNacimiento);
            clienteService.crearCliente(cliente1);
            clienteService.crearCliente(cliente2);
            clienteService.crearCliente(cliente3);
            clienteService.crearCliente(cliente4);
            mensajes.add(String.format("Cliente %s creado con ID %s", cliente1.getNombre(), cliente1.getId()));
            mensajes.add(String.format("Cliente %s creado con ID %s", cliente2.getNombre(), cliente2.getId()));
            mensajes.add(String.format("Cliente %s creado con ID %s", cliente3.getNombre(), cliente3.getId()));
            mensajes.add(String.format("Cliente %s creado con ID %s", cliente4.getNombre(), cliente4.getId()));

            String imagen = "https://media.nintendo.com/nintendo/bin/-9A4GoQi_d9G7DwR4sl4XOE7JOzLDFDo/O25PxyyAumX54lZSnk-MPup-k9vfJLR6.png";
            String descripcion = "- Pokemon ultra\n"
                    + "- Codigo Canjeable\n"
                    + "- Tamaño normal\n"
                    + "- Poster de Regalo\n";

            Consola consola1 = new Consola("Nintendo 3ds", "");
            consola1 = consolaService.crearConsola(consola1);
            mensajes.add( String.format("Consola %s creada con ID %s", consola1.getNombre(), consola1.getId()) );
            
            Consola consola2 = new Consola("Xbox 360", "");
            consola2 = consolaService.crearConsola(consola2);
            mensajes.add( String.format("Consola %s creada con ID %s", consola2.getNombre(), consola2.getId()) );
            
            Consola consola3 = new Consola("PlayStation 4", "");
            consola3 = consolaService.crearConsola(consola3);
            mensajes.add( String.format("Consola %s creada con ID %s", consola3.getNombre(), consola3.getId()) );

            Juego p = new Juego("Pokemon Ultra Moon", imagen, descripcion, 29990L, consola1);
            p = juegoService.crearJuego(p);
            Juego PokemonUltraMoon = p;
            mensajes.add( String.format("Juego %s creado con ID %s", p.getNombre(), p.getId()) );

            descripcion = "FIFA 18\n"
                    + "\n"
                    + "Nuevas caracteristicas en FUT 18.\n"
                    + "Historia de Iconos FUT.\n"
                    + "The Journey (Modo Historia).\n"
                    + "Tecnologia y movimiento de jugadores reales.\n";
                  
            imagen = "http://images.performgroup.com/di/library/GOAL/4d/d9/fifa-18-ps4-cover_leigi0aoegbv14bhd6vdgz37a.jpg?t=153763606";
            p = new Juego("Fifa 18", imagen, descripcion, 39990L, consola3);
            p = juegoService.crearJuego(p);
            Juego Fifa18 = p;

            mensajes.add( String.format("Juego %s creado con ID %s", p.getNombre(), p.getId()) );
            
            
            Pedido pedido = pedidoBuilder.setCliente(cliente1.getId())
                        .setVendedor(vendedor2.getId())
                        .agregarJuego(PokemonUltraMoon.getId(), 2)
                        .agregarJuego(Fifa18.getId(), 1)
                        .build();
            pedidoService.crearPedido(pedido);
            
        } catch (Exception e) {
            errores.add(e.getMessage());    
        }

        request.setAttribute("mensajes", mensajes);
        request.setAttribute("errores", errores);
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

}
