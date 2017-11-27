<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c>
    <body BACKGROUND="img/fondoFinal.jpg">
</c>

<div id="usuario" class="text-right"><dt>Bienvenido ${vendedor.nombre}</dt> <a href="login?op=logout"><dt>Cerrar sesión</dt></a></div>



<nav class="navbar navbar-expand-lg navbar-dark" style="background-color:cadetblue;">
    <a id="logo" href="index.jsp">
        <img src="img/logoFinal.png" alt="logotipo" style="width: 200px; height: auto;" />
    </a>
    <br /><br />



    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent" >
        <ul class="navbar-nav mr-auto">
            <li class="nav-item" >
                <a class="${pageContext.request.servletPath=='/index.jsp'?'active ':''}nav-link" href="index.jsp">Inicio</a>
            </li>
            <li class="nav-item">
                <a class="${pageContext.request.servletPath=='/WEB-INF/jsp/carrito/carrito.jsp'?'active ':''}nav-link" href="carrito">Carrito</a>
            </li>            
            <li class="nav-item">
                <a class="${pageContext.request.servletPath=='/WEB-INF/jsp/juego/listar.jsp'?'active ':''}nav-link" href="catalogo">Juegos</a>
            </li>            
            <li class="nav-item">
                <a class="${pageContext.request.servletPath=='/WEB-INF/jsp/consola/listar.jsp'?'active ':''}nav-link" href="consolas">Consola</a>
            </li>            
            <li class="nav-item">
                <a class="${pageContext.request.servletPath=='/WEB-INF/jsp/pedido/listar.jsp'?'active ':''}nav-link" href="pedidos">Pedidos</a>
            </li>
            <li class="nav-item">
                <a class="${pageContext.request.servletPath=='/WEB-INF/jsp/cliente/listar.jsp'?'active ':''}nav-link" href="clientes">Clientes</a>
            </li>            
        </ul>


        <form action="catalogo" method="get" class="form-inline my-2 my-lg-0">
            <input type="hidden" name="op" value="buscar" />
            <input name="juego" class="form-control mr-sm-2" type="text" placeholder="Buscar" aria-label="Buscar">
            <button class="btn btn-outline-light my-2 my-sm-0" type="submit"><font color="black">Buscar</font></button>
        </form>
    </div>
</nav>
<br />