<%@ page import="mx.org.fide.modelo.*" %>
<%

    response.setContentType("text/html;charset=ISO-8859-1");
    request.setCharacterEncoding("UTF8");
        
    Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
    if (usuario == null) {
        request.getRequestDispatcher("/login.jsp");
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>SIAP 2.0 - Monitor de actividades</title>
        <link href="img/ilce.ico" type="image/x-icon" rel="shortcut icon" />

        <!-- librerias para cargar dialogo  -->
        <script type="text/javascript" src="jQuery/js/jquery-1.4.4.min.js"></script>
        <script type="text/javascript" src="jQuery/js/jquery-ui-1.8.16.custom.min.js"></script>

        <!-- jqGrid -->
        <script type="text/javascript" src="jQuery/js/grid.locale-es.js" ></script>
        <script type="text/javascript" src="jQuery/js/jquery.jqGrid.min.js"></script>
        <script type="text/javascript" src="jQuery/js/grid.subgrid.js"></script>

        <!-- splitter -->
        <script type="text/javascript" src="jQuery/js/splitter.js" ></script>

        <!-- Cookie for splitter -->
        <script type="text/javascript"  src="jQuery/js/jquery.cookie.js" ></script>

        <!--Datetime picker -->
        <script src="jQuery/js/jquery-ui-timepicker-addon.js" type="text/javascript"></script>

        <!-- Menu -->
        <script src="jQuery/js/jquery.ui.menu.js" type="text/javascript"></script>

        <!-- Tooltip -->
        <script src="jQuery/js/jquery.tooltip.min.js" type="text/javascript"></script>

        <!-- form plugin para considerar uploads  -->
        <script type="text/javascript" src="jQuery/js/jquery.form.js"></script>

        <link type="text/css" href="css/agile_carousel.css" rel="stylesheet"/>
        <link rel="stylesheet" type="text/css" media="screen" href="css/cupertino/jquery-ui.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="jQuery/js/jqGrid/css/ui.jqgrid.css"/>
        <link rel="stylesheet" type="text/css" media="screen" href="css/jquery.tooltip.css"/>
        <link rel="stylesheet" type="text/css" media="screen" href="css/style.css"/>
        <link rel="stylesheet" type="text/css" media="screen" href="css/vista.css"/>


        <script src="jQuery/js/funciones.js" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.gridqueueMonitor.js" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.field_toolbar.js" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.session.js" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.form.js" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.formqueue.js" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.accordion.js" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.tab.js" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.gridMonitor.js" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.treeMenu.js" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.appmenu.js" type="text/javascript"></script>
        <script>
            $(document).ready(function() {            
            
                $("#divwait").dialog({
                    height: 140,
                    modal: true,
                    autoOpen: true,
                    closeOnEscape:false
            
                });
                
                $("#session_menu").sessionmenu(); 
                $("#tabs").tabs();
                $('#tabUser').tabs();
                $('.queued_grids:first').gridqueueMonitor();    
                
            }); //close $(
        </script>

    </head>
    <body>
        <div id="banner">   
            <div style="float: left; position: relative; ">
                <img src="img/logo sicap1.png" class="logo_plataforma"/>
            </div>
            <div id="session_menu" style="float: right; position: relative; "></div>
        </div>
        <div id="tabcontainer">
            <div id="tabs">

                <div style="padding-right: 5px; float: right; padding-top: 3px; position: relative; top: -30px; width:300px">
                    <div id="switcher"  style="float:right; height: 25px"></div>
                </div>
                <div id="tabInicioMonitor">
                    <div id="tabMonitor">    
                        <ul>
                            <li><a href="#tabPendientes">Actividades</a></li>
                        </ul>
                        <div id="tabPendientes">
                            <div id="grid_2_256_0" class="queued_grids" app="1" form="256" wsParameters="" titulo="Monitor de actividades" leyendas="Nueva actividad, Editar actividad" inDesktop="true" openKardex="false" ></div>
                            <div class="blank_space">&nbsp;</div>
                        </div>
                    </div>

                </div>
            </div>

        </div>
        <input type="hidden" name="_ce_" id="_ce_" value="<%=usuario.getClave()%>" />
        <input type="hidden" name="_cp_" id="_cp_" value="<%=usuario.getClavePerfil()%>" />
        <input type="hidden" name="_cp_" id="_ca_" value="<%=usuario.getClaveArea()%>" />
        <input type="hidden" name="_gq_" id="_gq_" value="" />
        <input type="hidden" name="_ts_" id="_ts_" value="" />
        <div id="divwait" title="Espere un momento, por favor"><br /><p style="text-align: center"><img src='img/throbber.gif' />&nbsp;Cargando preferencias del usuario</p></div>
    </body>
</html>