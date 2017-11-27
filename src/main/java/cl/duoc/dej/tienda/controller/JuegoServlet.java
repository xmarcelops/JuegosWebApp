package cl.duoc.dej.tienda.controller;

import cl.duoc.dej.tienda.entity.Consola;
import cl.duoc.dej.tienda.entity.Juego;
import cl.duoc.dej.tienda.exception.ConsolaNoEncontradaException;
import cl.duoc.dej.tienda.exception.JuegoNoEncontradoException;
import cl.duoc.dej.tienda.service.ConsolaService;
import cl.duoc.dej.tienda.service.JuegoService;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "JuegoServlet", urlPatterns = {"/catalogo"})
public class JuegoServlet extends HttpServlet {

    @EJB
    JuegoService juegoService;
    @EJB
    ConsolaService consolaService;

    private final String JSP_LISTA_PRODUCTOS = "/WEB-INF/jsp/juego/listar.jsp";
    private final String JSP_CREAR = "/WEB-INF/jsp/juego/crear.jsp";
    Logger logger = Logger.getLogger(this.getClass().getSimpleName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String operacion = request.getParameter("op");
        operacion = operacion != null ? operacion : "";
        switch (operacion) {
            case "crear":
                request.setAttribute("consolas", consolaService.getConsolas());
                request.getRequestDispatcher(JSP_CREAR).forward(request, response);
                break;
            case "buscar":
                buscar(request, response);
                break;
            case "eliminar":
                eliminar(request, response);
                break;
            case "listar":
            default:
                listar(request, response);
        }
    }

    private void listar(HttpServletRequest request, HttpServletResponse response, List<Juego> juegos) throws ServletException, IOException {
        List<Consola> consolas = consolaService.getConsolas();

        request.setAttribute("juegos", juegos);
        request.setAttribute("consolas", consolas);
        request.getRequestDispatcher(JSP_LISTA_PRODUCTOS).forward(request, response);
    }

    private void listar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Juego> juegos = juegoService.getJuegos();
        listar(request, response, juegos);
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> errores = new ArrayList<>();
        List<String> mensajes = new ArrayList<>();
        String error = "";
        String mensaje = "";

        String stringId = request.getParameter("id");
        Long juegoId = 0L;
        try {
            juegoId = Long.parseLong(stringId);
            juegoService.eliminarJuego(juegoId);
            mensaje = String.format("Se ha eliminado correctamente el juego con ID %s", juegoId);
            logger.log(Level.INFO, mensaje);
            request.setAttribute("mensajes", mensajes);
            mensajes.add(mensaje);
        } catch (NumberFormatException nfe) {
            error = String.format("Formato de ID inválido");
            logger.log(Level.SEVERE, error);
            errores.add(error);
        } catch (JuegoNoEncontradoException ex) {
            error = String.format("No se pudo encontrar el juego con el ID especificado");
            logger.log(Level.SEVERE, error);
            errores.add(error);
        }

        listar(request, response);
    }

    private void buscar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String juegoBuscado = request.getParameter("juego");
        String stringConsola = request.getParameter("consola");
        Long consolaId = null;
        try {
            if (stringConsola != null) {
                consolaId = Long.parseLong(stringConsola);
            }
        } catch (NumberFormatException nfe) {
            logger.log(Level.INFO, "La Consola ID entregada no corresponde a un ID válido");
        }
        List<Juego> juegos = juegoService.buscarJuego(juegoBuscado, consolaId);
        listar(request, response, juegos);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> errores = new ArrayList<>();
        List<String> mensajes = new ArrayList<>();
        String error = "";
        String mensaje = "";
        
        String nombre = request.getParameter("juego");
        String stringConsola = request.getParameter("consola");
        String stringPrecio = request.getParameter("precio");
        String imagen = request.getParameter("imagen");
        String descripcion = request.getParameter("descripcion");
        Long precio = 0L;
        Consola consola = null;
        request.setAttribute("consolas", consolaService.getConsolas());
        try {
            Long consolaId = Long.parseLong(stringConsola);
            consola = consolaService.getConsolaById(consolaId);
            if(consola == null) {
                request.setAttribute("consolas", consolaService.getConsolas());
                throw new ConsolaNoEncontradaException("No se encontró la consola asignada al juego");
            }
            precio = Long.parseLong(stringPrecio);
            Juego juego = new Juego(nombre, imagen, descripcion, precio, consola);
            juego = juegoService.crearJuego(juego);
            mensaje = String.format("Juego %s creada correctamente con ID %s", juego.getNombre(), juego.getId());
            mensajes.add(mensaje);
            
        } catch(NumberFormatException nfe) {
            errores.add("Formato numérico incompatible");
        } catch (ConsolaNoEncontradaException ex) {
            errores.add(ex.getMessage());
        }
        
        request.setAttribute("errores", errores);
        request.setAttribute("mensajes", mensajes);
        request.getRequestDispatcher(JSP_CREAR).forward(request, response);
    }

}
