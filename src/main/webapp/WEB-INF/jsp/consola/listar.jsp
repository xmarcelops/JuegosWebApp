<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Consola</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <jsp:include page="/WEB-INF/jspf/header.jsp" />
    </head>
    <body>

        <div class="container" style="background: whitesmoke">
            <jsp:include page="/WEB-INF/jspf/menu.jsp" />
            <jsp:include page="/WEB-INF/jspf/mensajes.jsp" />


            <div class="row">
                <div class="col">
                    <a href="consolas?op=crear" class="btn btn-success fa fa-plus"> Crear</a>
                </div>
            </div>


            <c:if test="${empty consolas}">
                No hay consolas para mostrar.
            </c:if>            

            <c:if test="${!empty consolas}">
                <!-- tabla con categorías -->
                <table class="table table-bordered table-dark">
                    <thead class="thead-inverse">
                        <tr>
                            <th>ID</th>
                            <th>Consola</th>
                            <th>Fecha Creación</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${consolas}" var="c">
                            <tr class="bg-info">
                                <th><dt>${c.id}<dt/></th>
                        <td><dt>${c.nombre}<dt/></td>
                        <td><dt>
                            <fmt:formatDate value="${c.fechaCreacion.time}" pattern="dd MMMM yyyy HH:mm'hrs'" />
                        <dt></td>
                        <td>
                            <form method="get" action="consolas">
                                <input type="hidden" name="op" value="eliminar" />
                                <input type="hidden" name="id" value="${c.id}" />
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