<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Juegos</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <jsp:include page="/WEB-INF/jspf/header.jsp" />
    </head>
    <body>
        <div class="container" style="background: whitesmoke">
            <jsp:include page="/WEB-INF/jspf/menu.jsp" />

            <!-- formulario de búsqueda -->
            <form method="get" action="catalogo">
                <input type="hidden" name="op" value="buscar" />
                <div class="form-row align-items-center">
                    <div class="col-6">
                        <label class="sr-only" for="juego">Juego</label>
                        <input type="text" name="juego" id="juego" value="${fn:escapeXml(juegoBuscado)}" class="form-control form-control-lg mb-2 mb-sm-0" placeholder="Ingrese el nombre del juego a buscar">
                    </div>
                    <div class="col-auto">
                        <label class="sr-only" for="consola">Consola</label>
                        <select name="consola" id="consola" class="custom-select mb-2 mr-sm-2 mb-sm-0">
                            <option selected>Escoja una categoría</option>
                            <c:forEach items="${consolas}" var="c">
                                <option value="${c.id}" ${c.id == consolaBuscada?'selected="true"':''}>${c.nombre}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-auto">
                        <button type="submit" class="btn btn-warning">Buscar</button>
                    </div>
                </div>
            </form>
            <!-- END formulario de búsqueda -->


            <jsp:include page="/WEB-INF/jspf/mensajes.jsp" />

            <div class="row">
                <div class="col">
                    <a href="catalogo?op=crear" class="btn btn-success fa fa-plus"> Crear</a>
                </div>
            </div>

            <c:if test="${empty juegos}">
                No hay juegos para mostrar.
            </c:if>            

            <c:if test="${!empty juegos}">
                <!-- tabla con juegos -->

                <table class="table table-bordered table-dark">

                    <thead class="thead-inverse">
                        <tr>

                            <th scope="col">ID</th>
                            <th scope="col">Imagen</th>
                            <th scope="col">Juego</th>
                            <th scope="col">Precio</th>
                            <th scope="col">Consola</th>
                            <th scope="col">Fecha Creación</th>
                            <th scope="col">Acciones</th>                   

                        </tr>
                    </thead>             


                    <tbody>
                        <c:forEach items="${juegos}" var="p">
                            <tr class="bg-info">
                                <th>${p.id}</th>
                                <td>
                                    <img src="${p.imagen}" alt="${p.nombre}" style="height: 100px; width: auto;" />
                                </td>
                                <td><dt>${p.nombre}<dt></td>
                        <td><dt>
                            $<fmt:formatNumber value="${p.precio}" />
                        </dt></td>

                        <td><dt>${p.consola.nombre}</dt></td>


                        <td><dt>
                            <fmt:formatDate value="${p.fechaCreacion.time}" pattern="dd MMMM yyyy HH:mm'hrs'" />
                        </dt></td>
                        <td>
                            <!-- agregar al carro -->
                            <form method="post" action="carrito" class="form-inline">
                                <div class="form-group">
                                    <input name="cantidad" value="1" type="number" min="1" max="10" />
                                    <input type="hidden" name="juegoId" value="${p.id}" />
                                </div>
                                <button type="submit" class="btn btn-primary">Add</button>
                            </form>
                            <!-- eliminar form> -->
                            <form method="get" action="catalogo">
                                <input type="hidden" name="id" value="${p.id}" />
                                <input type="hidden" name="op" value="eliminar" />
                                <button type="submit" class="btn btn-danger">Eliminar</button>
                            </form>
                        </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
        <jsp:include page="/WEB-INF/jspf/footer.jsp" />
    </body>
</html>