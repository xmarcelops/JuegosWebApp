<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Creación y Edición de Clientes</title>
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
                    <h1>Crear Clientes</h1>
                    <form method="post" action="clientes">
                        <fieldset>

                            <div class="form-group">
                                <label for="rut">Rut</label>
                                <input value="${!empty consola.rut}" type="number" class="form-control" id="rut" name="rut"  placeholder="Ingrese rut del cliente" aria-describedby="id-help">
                                <small id="id-help" class="form-text text-muted">Ejemplo: 12345678-9</small>
                            </div>

                            <div class="form-group">
                                <label for="dv">DV</label>
                                <input value="${!empty cliente?cliente.dv:''}" type="text" class="form-control" id="dv" name="dv" placeholder="Ingrese digito verificador" aria-describedby="consola-help">
                                <small id="consola-help" class="form-text text-muted">Ejemplo: k</small>
                            </div>
                            <div class="form-group">
                                <label for="nombre">Nombre Completo</label>
                                <input value="${!empty cliente?cliente.nombre:''}" type="text" class="form-control" id="nombre" name="nombre" placeholder="Ingrese el nombre del cliente" aria-describedby="descripcion-help">
                                
                            </div>

                            <div class="form-group">
                                <label for="direccion">Direccion</label>
                                <input value="${!empty cliente?cliente.direccion:''}" type="text" class="form-control" id="direccion" name="direccion" placeholder="Ingrese direccion" aria-describedby="descripcion-help">
                                
                            </div>

                            <div class="form-group">
                                <label for="fechanacimiento">Fecha de nacimiento</label>
                                <input type="text" class="form-control" name="fechanacimiento" id="fechanacimiento" />
                            </div>       

                            <div class="form-group">
                                <label>Comuna</label>
                                <select name="comuna" id="comuna" class="form-control">
                                    <option value="">Seleccione una comuna</option>
                                    <option>Cerrillos</option>
                                    <option>Cerro Navia</option>
                                    <option>Maipú</option>
                                    <option>Santiago</option>
                                    <option>Pudahuel</option>
                                    <option>Puente Alto</option>
                                </select>
                            </div>



                            <button type="submit" class="btn btn-primary">Guardar</button>
                        </fieldset>

                    </form>
                </div>
            </div><!-- end col-->
        </div><!-- end row-->

    </form>    
    <jsp:include page="/WEB-INF/jspf/footer.jsp" />
    <script type="text/javascript">
        jQuery(function () {
            jQuery("#fechanacimiento").datepicker({
                changeMonth: true
                , changeYear: true
                , dateFormat: 'yy-mm-dd'
                , minDate: new Date(1940, 1, 1)
                , maxDate: new Date()
            });

            jQuery("#rut").blur(function () {
                var url = "${pageContext.request.contextPath}/clientes";
                var d = {op: "ws", rut: jQuery(this).val()};
                jQuery.ajax({
                    type: "GET"
                    , url: url
                    , data: d
                    , dataType: "json"
                }).done(function (res) {
                    console.log("procesando respuesta JSON");
                    jQuery("#dv").val(res.dv);
                    jQuery("#nombre").val(res.nombre);
                    jQuery("#direccion").val(res.direccion);
                    jQuery("#comuna").val(res.dv);
                    jQuery("#fechanacimiento").val(res.fechaNacimiento);
                }).fail(function (jqXHR, textStatus, errorThrown) {
                    console.log("AJAX call failed: " + textStatus + ", " + errorThrown);
                });
            });
        });

    </script>
</body>
</html>