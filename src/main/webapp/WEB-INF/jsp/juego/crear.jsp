<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Creación y Edición de Juegos</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <jsp:include page="/WEB-INF/jspf/header.jsp" />
    </head>
    <body>
        <div class="container" style="background: whitesmoke">
            <jsp:include page="/WEB-INF/jspf/menu.jsp" />

            <div class="row">
                <div class="col col-lg-6">
                    <h1>Cree y Edite Juegos</h1>
                    
                    <jsp:include page="/WEB-INF/jspf/mensajes.jsp" />
                    
                    <form method="post" action="catalogo">
                        <div class="form-group">
                            <label for="id">ID</label>
                            <input type="number" class="form-control" id="id" name="id" readonly="readonly" aria-describedby="id-help">
                            <small id="id-help" class="form-text text-muted">El ID del juego se autogenera, solo se cargará cuando se edita un juego de manera informativa</small>
                        </div>
                        <div class="form-group">
                            <label for="juego">Juego</label>
                            <input type="text" class="form-control" id="juego" name="juego" placeholder="Ingrese el nombre de su juego" aria-describedby="juego-help">
                            <small id="juego-help" class="form-text text-muted">Ejemplo: Tazón personalizable</small>
                        </div>
                        <div class="form-group">
                            <label for="consola">Consola</label>
                            <select class="form-control" name="consola" id="consola">
                                <option value="0">Seleccione una consola</option>
                                <c:forEach items="${consolas}" var="c">
                                    <option value="${c.id}">${c.nombre}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="precio">Precio</label>
                            <div class="input-group">
                                <span class="input-group-addon">$</span>
                                <input type="number" class="form-control" id="precio" name="precio" placeholder="Ingrese el precio del juego" aria-describedby="precio-help">
                            </div><!-- end input-group-->
                            <small id="precio-help" class="form-text text-muted">Ejemplo: Ingresa el precio del juego con sólo números, no comas, puntos ni otro tipo de caracteres.</small>
                        </div>
                        <div class="form-group">
                            <label for="juego">Imagen</label>
                            <div class="input-group">
                                <span class="input-group-addon">http://</span>
                                <input type="text" class="form-control" id="imagen" name="imagen" placeholder="Ingrese la URL de la imagen" aria-describedby="imagen-help">
                            </div><!-- end input-group-->
                            <small id="imagen-help" class="form-text text-muted">Ejemplo: http://www.site.com/a/imagen.jpg</small>
                        </div>
                        <div class="form-group">
                            <label>Descripción</label>
                            <textarea name="descripcion" class="form-control"></textarea>
                            <small class="form-text text-muted">Descripción extensa del juego</small>
                        </div>

                        <button type="submit" class="btn btn-primary">Guardar</button>
                    </form>
                </div>
            </div><!-- end col-->
        </div><!-- end row-->

        <jsp:include page="/WEB-INF/jspf/footer.jsp" />
    </body>
</html>