<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Creación y Edición de Consolas</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <jsp:include page="/WEB-INF/jspf/header.jsp" />
    </head>
    <body>
        
        <div class="container" style="background: whitesmoke">
            <jsp:include page="/WEB-INF/jspf/menu.jsp" />
            <jsp:include page="/WEB-INF/jspf/mensajes.jsp" />
            <div class="row">
                <div class="col col-lg-6">
                    <h1>Cree y Edite Consolas</h1>
                    <form method="post" action="consolas">
                        <c:if test="${!empty consola}">
                            <div class="form-group">
                                <label for="id">ID</label>
                                <input value="${consola.id}" type="number" class="form-control" id="id" name="id" readonly="readonly" aria-describedby="id-help">
                                <small id="id-help" class="form-text text-muted">El ID de la consola se autogenera, solo se cargará cuando se edita una consola de manera informativa</small>
                            </div>
                        </c:if>
                        <div class="form-group">
                            <label for="consola">Consola (*)</label>
                            <input value="${!empty consola?consola.nombre:''}" type="text" class="form-control" id="consola" name="consola" placeholder="Ingrese el nombre de la consola" aria-describedby="consola-help">
                            <small id="consola-help" class="form-text text-muted">Ejemplo: Super nintendo</small>
                        </div>
                        <div class="form-group">
                            <label for="descripcion">Descripción</label>
                            <textarea name="descripcion" id="descripcion" class="form-control" aria-describedby="descripcion-help">${!empty consola?consola.descripcion:''}</textarea>
                            <small id="descripcion-help" class="form-text text-muted">Descripción larga de la categoría, es opcional.</small>
                        </div>

                        <button type="submit" class="btn btn-primary">Guardar</button>
                    </form>
                </div>
            </div><!-- end col-->
        </div><!-- end row-->

        <jsp:include page="/WEB-INF/jspf/footer.jsp" />
    </body>
</html>