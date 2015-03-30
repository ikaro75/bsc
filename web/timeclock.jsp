<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@page import="mx.org.fide.modelo.Usuario" %>
<%@page import="mx.org.fide.modelo.Consulta" %>
<%@page import="mx.org.fide.modelo.Fallo" %>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="mx.org.fide.utilerias.Utilerias"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title id="title">Reloj checador</title>
        <link href="img/ilce.ico" type="image/x-icon" rel="shortcut icon" />

        <link type="text/css" href="css/start/jquery.ui.all.css"  rel="stylesheet"/>
        <link type="text/css" href="css/reloj.css"  rel="stylesheet"/>
        <script type="text/javascript" src="jQuery/js/jquery-1.7.2.min.js" /></script>
        <script type="text/javascript" src="jQuery/js/reloj.js" /></script>
    </head>
    <body>
        <img src="img/logo_intranet_4.png">
    	<div id="contenedor">
            <header id="cabecera">
                <div class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
                    <h1 align="center">Reloj checador</h1>
                </div>
            </header>

<%  
    String mensajeChecador = "";
    String mensaje = "";
    StringBuilder resultado = new StringBuilder();
    Integer claveTipoEvento = 1;
    Integer claveUsuario = 0;
    Usuario user = new Usuario();
    Usuario u = new Usuario();
    Consulta cnsAsistenciaEmpleado;
    
    user = (Usuario) request.getSession().getAttribute("usuario");
    
    if (user == null) {
        request.getRequestDispatcher("/login.jsp?$app=timeclock").forward(request, response);
    } else {
        try {
            if (request.getParameter("id") == null || request.getParameter("id")=="") {
                mensaje = "Por favor, pase su código por el dispositivo lector"; %>
            <br><br><br><br><br><br><br><br><br><br>
            <p class="spanTexto1" align="center"><%= mensaje %></p>
            <footer></footer>          
        </div>
    </body>
</html>
                
<%                
            } else {
                claveUsuario = Integer.parseInt(request.getParameter("id"));

                //1. Verifica si existe el usuario
                u.setCx(user.getCx());
                u.setClave(claveUsuario);

                //2. Sincroniza el reloj con el servidor de la BD
                Date fechaActual = Utilerias.getDateServidor();
                SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy,MM,dd,HH,mm,ss");
                String fechaActualFormat = formatoFecha.format(fechaActual);
                
                
                //3. Verifica si en ese dia hay otro registro del empleado con clave_tipo_evento=1 , entonces clave_tipo_evento=4
                if (u.isChecoHoyEntrada()) {
                    claveTipoEvento = 4;
                }

                //4. Inserta registro
                cnsAsistenciaEmpleado = new Consulta(330, "insert", "0", "", user);
                cnsAsistenciaEmpleado.getCampos().get("clave_empleado").setValor(claveUsuario.toString());
                cnsAsistenciaEmpleado.getCampos().get("fecha_registro").setValor("%ahora");
                cnsAsistenciaEmpleado.getCampos().get("clave_tipo_evento").setValor(claveTipoEvento.toString());

                resultado.append(cnsAsistenciaEmpleado.insert(true));
                if (claveTipoEvento == 1) {
                    mensajeChecador="Entrada";
                } else {
                    mensajeChecador="Salida";
                } %>
            <nav id="menu">
                <br><input type="hidden" value="<%= fechaActualFormat %>" id="fechaActual" />
                <div class="clock">
                    <div id="Date"></div>
                    <ul align="center">
                        <li id="hrs"></li>
                        <li id="point">:</li>
                        <li id="min"></li>
                        <li id="point">:</li>
                        <li id="seg"></li>
                    </ul>
                </div>
            </nav>
            <% if (u.getClave() != null) { %>
            <aside id="columna">
                <img src="<%=u.getFoto()%>" width="120px">
            </aside>
            <section id="seccion">
                <div id="parrafos">
                    <div class="spanTexto1"><%= u.getNombre()%> <%= u.getApellidos()%></div>
                            <%      u = null; 
                } %>
                    <br>
                    <div class="spanTexto2">-- <%=mensajeChecador%> --</div>
                </div>
            </section>
            <footer></footer>
        </div>
    </body>
</html>    
<%          } 
        } catch (Exception e) {
            mensaje = e.getMessage();
        }
    }
%>