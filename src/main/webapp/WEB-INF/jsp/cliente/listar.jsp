<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Clientes</title>

        <jsp:include page="/WEB-INF/jspf/header.jsp" />
    </head>
    <body>
        <div class="container" style="background: whitesmoke">
            <jsp:include page="/WEB-INF/jspf/menu.jsp" />
            <jsp:include page="/WEB-INF/jspf/mensajes.jsp" />


            <div class="row">
                <div class="col">
                    <a href="clientes?op=crear" class="btn btn-success fa fa-plus"> Crear</a>
                </div>
            </div>


            <c:if test="${empty clientes}">
                No hay clientes para mostrar.
            </c:if>            

            <c:if test="${!empty clientes}">
                <!-- tabla con categorías -->
                <table class="table table-bordered table-dark">
                    <thead class="thead-inverse">
                        <tr>
                            <th>ID</th>
                            <th>RUT</th>
                            <th>Nombre</th>
                            <th>Fecha Nacimiento</th>
                            <th>Comuna</th>
                            <th>Dirección</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${clientes}" var="c">
                            <tr class="bg-info">


                                <td><dt>${c.id}</dt></td>
                        <td><dt>${c.rut}-${c.dv}</dt></td>
                        <td><dt>${c.nombre}</dt></td>
                        <td>
                        <dt>
                            <fmt:formatDate value="${c.fechaNacimiento.time}" pattern="dd MMMM yyyy" />
                        </dt>

                        </td>
                        <td><dt>${c.comuna}</dt></td>
                        <td><dt>${c.direccion}</dt></td>
                        <td>
                            <form method="get" action="clientes">
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