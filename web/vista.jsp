<%@page import="java.util.LinkedHashMap"%>
<%@page import="mx.org.fide.controlador.Sesion"%>
<%@page import="mx.org.fide.modelo.*" %><%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setDateHeader("Expires", 0); // Proxies.

    Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
    Sesion sesion = (Sesion) request.getSession().getServletContext().getAttribute("sesion");

    if (usuario == null) {
        response.sendRedirect("login.jsp");
    } else {

        if (sesion == null) {
            sesion = new Sesion();
            request.getSession().getServletContext().setAttribute("sesion", sesion);
        }
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
        <title id="title">Sistema de Cuadro de Mando Integral</title>

        <!-- librerias para cargar dialogo  -->
        <script type="text/javascript" src="jQuery/js/jquery-1.7.2.min.js?id=<%=usuario.getSesion()%>"></script>
        <script type="text/javascript" src="jQuery/js/jquery-ui-1.8.21.custom.min.js?id=<%=usuario.getSesion()%>"></script>

        <!-- app portlets -->
        <script type="text/javascript" src="jQuery/js/jquery.appportlet.js?id=<%=usuario.getSesion()%>"></script>
        <script type="text/javascript" src="jQuery/js/jquery.pi.portletlog.js?id=<%=usuario.getSesion()%>" ></script>
        <script type="text/javascript" src="jQuery/js/jquery.pi.portletfilter.js?id=<%=usuario.getSesion()%>" ></script>
        <script type="text/javascript" src="jQuery/js/jquery.pi.portletreport.js?id=<%=usuario.getSesion()%>" ></script>

        <!-- Cookie -->
        <script type="text/javascript"  src="jQuery/js/jquery.cookie.js?id=<%=usuario.getSesion()%>" ></script>

        <!-- jqGrid -->
        <script type="text/javascript" src="jQuery/js/grid.locale-es.js?id=<%=usuario.getSesion()%>" ></script>
        <script type="text/javascript" src="jQuery/js/jquery.jqGrid.min.js?id=<%=usuario.getSesion()%>"></script>
        <script type="text/javascript" src="jQuery/js/grid.subgrid.js?id=<%=usuario.getSesion()%>"></script>
        <script type="text/javascript" src="jQuery/js/jquery.jstree.js?id=<%=usuario.getSesion()%>"></script>
        <script type="text/javascript" src="jQuery/js/grid.treegrid.js?id=<%=usuario.getSesion()%>" ></script>

        <!--Datetime picker -->
        <script src="jQuery/js/jquery-ui-timepicker-addon.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>

        <!-- Calculator -->
        <script type="text/javascript" src="jQuery/js/jquery.calculator.min.js?id=<%=usuario.getSesion()%>" ></script>
        <script type="text/javascript" src="jQuery/js/jquery.calculator-es.js?id=<%=usuario.getSesion()%>" ></script>

        <!-- Menu -->
        <script src="jQuery/js/jquery.ui.menu.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>

        <!-- Autocomplete -->
        <script type="text/javascript" src="jQuery/js/combobox.js?id=<%=usuario.getSesion()%>"></script>
        <script type="text/javascript" src="jQuery/js/jquery.ui.core.js?id=<%=usuario.getSesion()%>"></script>
        <script type="text/javascript" src="jQuery/js/jquery.ui.widget.js?id=<%=usuario.getSesion()%>"></script>
        <script type="text/javascript" src="jQuery/js/jquery.ui.button.js?id=<%=usuario.getSesion()%>"></script>
        <script type="text/javascript" src="jQuery/js/jquery.ui.position.js?id=<%=usuario.getSesion()%>"></script>
        <script type="text/javascript" src="jQuery/js/jquery.ui.autocomplete.js?id=<%=usuario.getSesion()%>"></script>

        <!-- Carrousel -->
        <script type="text/javascript" src="jQuery/js/agile_carousel.alpha.js?id=<%=usuario.getSesion()%>"></script>

        <!-- Tooltip -->
        <script src="jQuery/js/jquery.tooltip.min.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>

        <!-- form plugin para considerar uploads  -->
        <script type="text/javascript" src="jQuery/js/jquery.form.js?id=<%=usuario.getSesion()%>"></script>

        <script src="jQuery/js/backend.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>

        <script type="text/javascript" src="jQuery/js/alertmanager.js?id=<%=usuario.getSesion()%>"></script>
        <script type="text/javascript" src="jQuery/js/cambia_password.js?id=<%=usuario.getSesion()%>"></script>
        <script type="text/javascript" src="jQuery/js/jquery.pi.survey_icr.js?id=<%=usuario.getSesion()%>"></script>
        <script type="text/javascript" src="jQuery/js/jquery.pi.reportParameterForm.js?id=<%=usuario.getSesion()%>" ></script>

        <!-- jqwidgets -->
        <script type="text/javascript" src="jQuery/jqwidgets/jqxcore.js?id=<%=usuario.getSesion()%>"></script>
        <script type="text/javascript" src="jQuery/jqwidgets/jqxsplitter.js?id=<%=usuario.getSesion()%>"></script>

        <!-- page guider -->
        <script type="text/javascript" src="jQuery/js/pageguide.min.js?id=<%=usuario.getSesion()%>"></script>

        <link type="image/x-icon" href="img/favicon.ico" rel="shortcut icon"  />
        <link rel="stylesheet" type="text/css" media="screen" href="css/agile_carousel.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/sunny/jquery.ui.all.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="jQuery/js/jqGrid/css/ui.jqgrid.css"/>
        <link rel="stylesheet" type="text/css" media="screen" href="css/jquery.tooltip.css"/>
        <link rel="stylesheet" type="text/css" media="screen" href="css/style.css"/>
        <link rel="stylesheet" type="text/css" media="screen" href="css/vista.css"/>
        <link rel="stylesheet" type="text/css" media="screen" href="css/calculator/jquery.calculator.css"/>
        <link rel="stylesheet" type="text/css" media="screen" href="jQuery/js/jwysiwyg-master/jquery.wysiwyg.css" />

        <link rel="stylesheet" type="text/css" media="screen" href="css/jqxstyles/jqx.base.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/pageguide.min.css" />  
        <link rel="stylesheet" type="text/css" media="screen" href="jQuery/jqPlot/jquery.jqplot.min.css"/>
        
        
        <script src="jQuery/js/funciones.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.desktop.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.gridqueue.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.field_toolbar.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.session.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.form.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.formqueue.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.accordion.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.tab.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.grid.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.treeMenu.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.appmenu.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.comments.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>
        <script src="jQuery/js/jquery.timeago.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>
        <script src="jQuery/js/jquery.timeago.es.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>
        <script src="jQuery/js/padron.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>
        <script src="jQuery/js/viaticos.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>
        <script src="jQuery/js/balancedscorecard.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>
        
        <!-- soporte para charts  -->
        <script type="text/javascript" src="jQuery/jqPlot/jquery.jqplot.min.js?id=<%=usuario.getSesion()%>" ></script> 
        <script type="text/javascript" src="jQuery/jqPlot/plugins/jqplot.canvasTextRenderer.min.js?id=<%=usuario.getSesion()%>"></script>
        <script type="text/javascript" src="jQuery/jqPlot/plugins/jqplot.canvasAxisLabelRenderer.min.js?id=<%=usuario.getSesion()%>"></script>
        <script type="text/javascript" src="jQuery/jqPlot/plugins/jqplot.dateAxisRenderer.min.js?id=<%=usuario.getSesion()%>"></script>
        <script type="text/javascript" src="jQuery/jqPlot/plugins/jqplot.pieRenderer.min.js?id=<%=usuario.getSesion()%>"></script>
        <script type="text/javascript" src="jQuery/jqPlot/plugins/jqplot.donutRenderer.min.js?id=<%=usuario.getSesion()%>"></script>
        <script type="text/javascript" src="jQuery/jqPlot/plugins/jqplot.bubbleRenderer.min.js?id=<%=usuario.getSesion()%>"></script>
        <script type="text/javascript" src="jQuery/jqPlot/plugins/jqplot.barRenderer.min.js?id=<%=usuario.getSesion()%>"></script>
        <script type="text/javascript" src="jQuery/jqPlot/plugins/jqplot.categoryAxisRenderer.min.js?id=<%=usuario.getSesion()%>"></script>
        <script type="text/javascript" src="jQuery/jqPlot/plugins/jqplot.pointLabels.min.js?id=<%=usuario.getSesion()%>"></script>
        
        <script type="text/javascript" src="jQuery/jqPlot/plugins/jqplot.highlighter.min.js"  ></script>
        <script type="text/javascript" src="jQuery/jqPlot/plugins/jqplot.cursor.min.js"></script>
        <script type="text/javascript" src="jQuery/js/charts.js?id=<%=usuario.getSesion()%>"></script>
        
        <script src="jQuery/js/raphael.2.1.0.min.js"></script>
        <script src="jQuery/js/justgage.1.0.1.min.js"></script>
        <script src="jQuery/js/hashset.js"></script>
        <script src="jQuery/js/hashtable.js"></script>        
        <script src="jQuery/js/jquery.numberformatter-1.2.4.min.js"></script>
        
        <script type="text/javascript" src="jQuery/js/jwysiwyg-master/jquery.wysiwyg.js"></script>
        <script type="text/javascript" src="jQuery/js/sets/html/set.js"></script>
        <script src="jQuery/js/vista.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>
        
        

    </head>
    <body id="top">

        <div id="banner">
            <div style="float: left;margin-top: 16px;">
                <img src="<%=((LinkedHashMap) sesion.getConfiguracion().getParametros().get(sesion.getConfiguracion().getConfiguracionActual())).get("enterprise_banner_logo").toString()%>"/></div>
            <div id="sessionMenu" style="float: right; position: relative; "></div>
        </div>

        <div id="tabcontainer">
            <div id="tabs">
                <ul>
                    <li id="liInicio"><a href="#tabInicio">Inicio</a></li>
                    <li id="liAplicaciones"><a href="#tabAplicaciones">Cat&aacute;logos</a></li>
                </ul>
                <div id="tabInicio">
                    <div id='jqxSplitter'>
                        <div class="portlet">
                            <div class="ui-jqgrid-titlebar ui-widget-header ui-corner-top ui-helper-clearfix" style="padding: .3em .2em .2em .3em;">Indicadores Clave de Desempeño</div>
                            <div class="portlet-content" style="height:93%">
                                <div id="tvIndicadores_view" class="ui-jqgrid-view">
                                    <div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" id="gbox_tvIndicadores" dir="ltr" style="position: relative;left: 0px;top: 0px;padding: .0em;">
                                    <div id="tvIndicadores_toppager" class="ui-state-default ui-jqgrid-toppager" dir="ltr">
                                        <div id="pg_tvIndicadores_toppager" class="ui-pager-control" role="group">
                                            <table cellspacing="0" cellpadding="0" border="0" class="ui-pg-table" style="width:100%;table-layout:fixed;height:100%;" role="row">
                                                <tbody>
                                                    <tr>
                                                        <td id="tvIndicadores_toppager_left" align="left">
                                                            <table cellspacing="0" cellpadding="0" border="0" class="ui-pg-table navtable" style="float:left;table-layout:auto;">
                                                                <tbody>
                                                                    <tr>
                                                                        <td class="ui-pg-button ui-corner-all" title="Recargar datos" id="refresh_tree_button">
                                                                            <div class="ui-pg-div"><span class="ui-icon ui-icon-refresh"></span></div>
                                                                        </td>
                                                                        <td class="ui-pg-button ui-corner-all" title="Nuevo registro" id="add_node_tree_button">
                                                                            <div class="ui-pg-div"><span class="ui-icon ui-icon-plus"></span></div>
                                                                        </td>
                                                                        <td class="ui-pg-button ui-corner-all" title="Editar registro" id="edit_node_tree_button">
                                                                            <div class="ui-pg-div"><span class="ui-icon ui-icon-pencil"></span></div>
                                                                        </td>
                                                                        <td class="ui-pg-button ui-corner-all" title="Eliminar registro" id="delete_node_tree_button">
                                                                            <div class="ui-pg-div"><span class="ui-icon ui-icon-trash"></span>
                                                                            </div>
                                                                        </td>
                                                                        <td class="ui-pg-button ui-state-disabled" style="width:4px;">
                                                                            <span class="ui-separator"></span>
                                                                        </td>
                                                                        <td class="ui-pg-button ui-corner-all" title="Expandir todo" id="expand_tree_button">
                                                                            <div class="ui-pg-div"><span class="ui-icon ui-icon-circlesmall-plus"></span></div>
                                                                        </td>
                                                                        <td class="ui-pg-button ui-corner-all" title="Colapsar todo" id="collapse_tree_button">
                                                                            <div class="ui-pg-div"><span class="ui-icon ui-icon-circlesmall-minus"></span>
                                                                            </div>
                                                                        </td>
                                                                        <td class="ui-pg-button ui-state-disabled" style="width:4px;"><span class="ui-separator"></span>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                  </div>          
                                </div>
                                <div id="tvIndicadores" style="overflow: scroll; height:98%">
                                    <br />
                                    <p style='text-align: center'><img src='img/throbber.gif' />&nbsp;Espere por favor, construcción de interfaz en progreso</p>
                                </div>
                            </div>
                        </div>                        
                        <div id="frontweb" class="tabUser" style="height: 100%; overflow: auto;">                             
                        </div>
                        <!-- <script type='text/javascript' src='http://public.tableau.com/javascripts/api/viz_v1.js'></script><div class='tableauPlaceholder' style='width: 982px; height: 745px;'><noscript><a href='#'><img alt=' ' src='http:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Ma&#47;MapaxMunicipio-2015-06-12&#47;Montofinanciado&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz' width='982' height='745' style='display:none;'><param name='host_url' value='http%3A%2F%2Fpublic.tableau.com%2F' /> <param name='site_root' value='' /><param name='name' value='MapaxMunicipio-2015-06-12&#47;Montofinanciado' /><param name='tabs' value='yes' /><param name='toolbar' value='yes' /><param name='static_image' value='http:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Ma&#47;MapaxMunicipio-2015-06-12&#47;Montofinanciado&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='showVizHome' value='no' /><param name='showTabs' value='y' /><param name='bootstrapWhenNotified' value='true' /></object></div> -->
                    </div>

                    <ul id="tlyPageGuide" data-tourtitle="Conozca las funciones del Sistema " style="display: none;">
                        <!-- use these classes to indicate where each number bubble should be
                        positioned. data-tourtarget should contain the selector for the element to
                        which you want to attach this pageguide step. -->
                        <li class="tlypageguide_left" data-tourtarget="#liInicio">
                            En el &aacute;rbol de la izquierda encontrar&aacute; los indicadores de desempe&ntilde;o principales desde las 4 perspectivas que considera la metodología del balance scoredcard; dependiendo del nodo del &aacute;rbol que se seleccione, en el panel derecho podrá observar las alertas de que un indicador alcanz&oacute; alg&uacute;n valor objetivo o los datos relacionados al indicador que se seleccion&oacute;.
                        </li>
                        <li class="tlypageguide_left" data-tourtarget="#liAplicaciones">
                            Aqu&iacute; encontrar&aacute; los catálogos que integran la configuración del sistema.
                        </li>
                        <li class="tlypageguide_top" data-tourtarget="#tvIndicadores">
                            <p>En este árbol se encuentran los indicadores agrupados de acuerdo a las perspectivas de la empresa y dentro de carpetas que ayudan a clasificarlos. Si el indicador alcanza 
                            el valor objetivo se mostrar&aacute; un punto verde de lado izquierdo del indicador; en caso de que el valor llegue a los l&iacute;mites inferiores los puntos mostrados ser&aacute;n amarillos o rojos; si no han sido establecidos valores objetivos el punto ser&aacute; gris. <p/>
                                                        
                            <p>Para agregar una carpeta o un indicador haga clic derecho sobre el nodo del &aacute;rbol en donde lo desea insertar y seleccione del menu contextual "Nuevo indicador". Si desea editar algún indicador selecci&oacute;nelo, haga clic con el bot&oacute;n derecho y escoja "Editar" del menú contextual. 
                            Para reubicar un indicador dentro de otro carpeta, seleccione, arrastre y su&eacute;ltelo en el nodo deseado.</p>
                            
                            <p>Si selecciona el nodo "FIDE" podrá visualizar en el panel de la derecha las alertas de los indicadores que alcanzaron alg&uacute;n valor objetivo establecido. 
                            Si se selecciona un nodo que represente un indicador, en el panel derecho se mostrar&aacute;n m&aacute;s detalles del mismo.</p>
                        </li>
                        <li class="tlypageguide_top" data-tourtarget=".jqx-splitter-collapse-button-vertical">
                            Haga clic aquí para ocultar el &aacute;rbol de indicadores; vuelva a hacer clic para volverlo a mostrar 
                        </li>
                        <li class="tlypageguide_bottom" data-tourtarget="#grid_1_101_0_toppager">
                            Cada vez que algún indicador alcance algun valor objetivo establecido, el sistema generará una alerta que podrá encontrar en este cat&aacute;logo.
                        </li>
                        <li class="tlypageguide_bottom" data-tourtarget="#datos_generales_indicador_d">
                            Aqu&iacute; se muestran la categor&iacute;a, el nombre del indicador, una breve explicaci&oacute;n de en qu&eacute; consiste y los responsables a su cargo.
                        </li>
                        <li class="tlypageguide_bottom" data-tourtarget="#tacometro_portlet_d">
                            Esta gráfica muestra el avance del indicador con respecto a sus valores objetivos establecidos.
                        </li>
                        <li class="tlypageguide_bottom" data-tourtarget="#chart_desempeno_portlet_d">
                            Esta gr&aacute;fica muestra el comportamiento hist&oacute;rico del indicador en una l&iacute;nea de tiempo y los datos que conforman la gr&aacute;fica se muestran en la tabla de la derecha.
                        </li>
                        <li class="tlypageguide_bottom" data-tourtarget="#grid_datos_d">
                            En esta tabla se muestran los datos que conforman la gr&aacute;fica de desempempe&ntilde;o hist&oacute;rico y cada registro representa un punto en la l&iacute;nea. Para ver m&aacute;s detalles haga clic encima de alguna fecha espec&iacute;fica.
                        </li>
                        <li class="tlypageguide_bottom" data-tourtarget="#grid_datos_detalle_d">
                            En esta tabla se muestran los detalles del periodo que se seleccionó en la de valores hist&oacute;ricos. Cada registro representa una barra en la gr&aacute;fica de la derecha. 
                        </li>
                        <li class="tlypageguide_bottom" data-tourtarget="#chart_datos_detalle_portlet_d">
                            Esta es la representaci&oacute;n gr&aacute;fica de la tabla de lado izquierdo y muestra c&oacute;mo se integra el dato del indicador en el periodo seleccionado.  
                        </li>        
                    </ul>
                </div>
                <div id="tabAplicaciones">
                    <div id="appMenu_1_0" aplicacion="0" class="appmenu"></div><br/>
                    <div id="tab_1_0">
                        <ul>
                            <li><a href='#tabMisAplicaciones'>C&oacute;mo usar los cat&aacute;logos</a></li>
                        </ul>
                        <div id='tabMisAplicaciones'>
                            <div id='divCarouselMisAplicaciones'>
                                <div id='ayudaComoUsarMisAplicaciones'>
                                    <table >
                                        <tr>
                                            <td colspan='2'>
                                                <h1>Comienza a usar los catálogos</h1>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <img src='img/como_usar_aplicaciones.png'  class='helpScreen'/>
                                            </td>
                                            <td class='instrucciones'>
                                                <p class='instrucciones'>
                                                    En este espacio puedes operar los catálogos, para comenzar haz lo siguiente:</p>
                                                <table>
                                                    <tr>
                                                        <td><img src="img/paso1.png" /></td><td class='instrucciones'>Ve a la pestaña "Catálogos"</td>
                                                    </tr>
                                                    <tr>
                                                        <td><img src="img/paso2.png" /></td><td class='instrucciones'>Haz clic en el botón del catálogo que deseas abrir; inmediatamente después se abrirá una pestaña con el nombre del catálogo  seleccionado</td>
                                                    </tr>
                                                </table>        
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id='ayudaComoAgregarUnRegistro'>
                                    <table >
                                        <tr>
                                            <td colspan='2'>
                                                <h1>Agrega un registro nuevo al catálogo</h1>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <img src='img/como_agregar_registros.png'  class='helpScreen' />
                                            </td>
                                            <td class='instrucciones'>
                                                <p class='instrucciones'>
                                                    Para agregar un registro sigue los siguientes pasos:</p>
                                                <table>
                                                    <tr>
                                                        <td><img src="img/paso1.png" /></td>
                                                        <td>Haz clic encima del botón <span class='ui-icon ui-icon-plus' style='display:inline-block'></span>de la barra de herramientas del catálogo. <br />
                                                            La página desplegará una ventana solicitando la información que se requiere para agregar el nuevo registro. Los campos marcados con (*) son obligatorios.</td>
                                                    </tr>
                                                    <tr>
                                                        <td><img src="img/paso2.png" /></td>
                                                        <td>Ingresa los datos conforme se solicitan</td>
                                                    </tr>
                                                    <tr>
                                                        <td><img src="img/paso3.png" /></td>
                                                        <td>Presiona el botón "Guardar"; esto cerrara la ventana e incorporará el nuevo registro al catálogo. </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id='ayudaComoEditarUnRegistro'>
                                    <table >
                                        <tr>
                                            <td colspan='2'>
                                                <h1>Edita un registro del catálogo</h1>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <img src='img/como_editar_registros.png' class='helpScreen' />
                                            </td>
                                            <td class='instrucciones'>
                                                <p class='instrucciones'>
                                                    Para editar un registro sigue los siguientes pasos:</p>
                                                <table>
                                                    <tr>
                                                        <td><img src="img/paso1.png" /></td>
                                                        <td>Selecciona del catálogo el registro que deseas editar.</td>    
                                                    </tr>
                                                    <tr>
                                                        <td><img src="img/paso2.png" /></td>
                                                        <td>Haz clic encima del botón <span class='ui-icon ui-icon-pencil' style='display:inline-block'></span>de la barra de herramientas del catálogo. <br />
                                                            La página desplegará una ventana con la información del registro seleccionado para que lo edites. </td>
                                                    </tr>
                                                    <tr>
                                                        <td><img src="img/paso3.png" /></td>
                                                        <td>Edita los campos necesarios,  aquellos marcados con (*) son obligatorios.</td>
                                                    </tr>    
                                                    <tr>
                                                        <td><img src="img/paso4.png" /></td>
                                                        <td>Presiona el botón "Guardar"; esto cerrara la ventana y actualizará el registro.</td>
                                                    </tr>                                                
                                                </table>                                        
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id='ayudaComoEliminarUnRegistro'>
                                    <table >
                                        <tr>
                                            <td colspan='2'>
                                                <h1>Elimina un registro del catálogo</h1>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <img src='img/como_eliminar_registros.png' class='helpScreen' />
                                            </td>
                                            <td class='instrucciones'>
                                                <p class='instrucciones'>
                                                    Para eliminar un registro sigue los siguientes pasos:</p>
                                                <table>
                                                    <tr>
                                                        <td><img src="img/paso1.png" /></td>
                                                        <td>Selecciona del catálogo el registro que deseas eliminar.</td>
                                                    </tr>    
                                                    <tr>
                                                        <td><img src="img/paso2.png" /></td>
                                                        <td>Haz clic encima del botón <span class='ui-icon ui-icon-trash' style='display:inline-block'></span>de la barra de herramientas del catálogo. <br />
                                                            La página solicitará que confirmes la eliminación.</td> 
                                                    </tr>
                                                    <tr>
                                                        <td><img src="img/paso3.png" /></td>
                                                        <td>Presiona OK en el dialogo de confirmación para proceder con el borrado</td>
                                                    </tr>
                                                </table>                                        
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div id='ayudaComoFiltrarRegistros'>
                                    <table >
                                        <tr>
                                            <td colspan='2'>
                                                <h1>Filtra los registros del catálogo</h1>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <img src='img/como_filtrar_registros.png' class='helpScreen' />
                                            </td>
                                            <td class='instrucciones'>
                                                <p class='instrucciones'>
                                                    Filtra para encontrar el conjunto de registros que cumplen con tus criterios de filtrado. Para filtrar registros sigue los siguientes pasos:</p>
                                                <table> 
                                                    <tr>
                                                        <td><img src="img/paso1.png" /></td>
                                                        <td>Haz clic encima del botón <span class='ui-icon ui-icon-search' style='display:inline-block'></span>de la barra de herramientas del catálogo. <br />
                                                            La página desplegará una ventana para ingresar los criterios de filtrado</td> 
                                                    </tr>
                                                    <tr>
                                                        <td><img src="img/paso2.png" /></td>
                                                        <td>Ingresa al menos un criterio de filtrado; puedes seleccionar más de uno. Mientras más criterios utilices más reducida será el resultado de la búsqueda.</td>
                                                    </tr>        
                                                    <tr>
                                                        <td><img src="img/paso3.png" /></td>
                                                        <td>Si deseas guardar el filtro para su posterior uso, as&iacute;gnale un nombre en el campo <a href="javascript:void(0);" class="tooltipLink" id="img/guardar_filtro_como.png">Guardar filtro como</a>:"; recuperalo posteriormente en el menú <a href="javascript:void(0);" class="tooltipLink" id="img/mis_filtros.png">"Mis filtros"</a> que se encuentra a la izquierda del catálogo. </td>
                                                    </tr>        
                                                    <tr>
                                                        <td><img src="img/paso4.png" /></td>
                                                        <td>Presiona el botón "Buscar"; esto cerrará la ventana y mostrará el resultado en el catálogo. Para remover el filtro y restaurar los registros haz clic encima de la liga (Quitar filtro) que se encuentra junto al titulo del catálogo." </td>
                                                    </tr>        
                                                </table>                                        
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>       
                    </div>
                </div>   
            </div>
        </div>

        <div class="tlyPageGuideWelcome" style="text-align: center;">
            <p>!Bienvenido al Cuadro de Mando Integral! <br/> <br/>&iquest;Requiere de una gu&iacute;a para aprender a usarlo?</p>
            <button class="tlypageguide_start">Si</button>
            <button class="tlypageguide_dismiss">No</button>
            <button class="tlypageguide_ignore">No volver a desplegar esta pantalla</button>
        </div>

        <input type="hidden" name="_ce_" id="_ce_" value="<%=usuario.getClave()%>" />
        <input type="hidden" name="_cp_" id="_cp_" value="<%=usuario.getClavePerfil()%>" />
        <input type="hidden" name="_ca_" id="_ca_" value="" />
        <input type="hidden" name="_enterprise_" id="_enterprise_" value="1" />
        <input type="hidden" name="_gq_" id="_gq_" value="" />
        <input type="hidden" name="_gado_" id="_gado_" value="true" />
        <input type="hidden" name="_cache_" id="_cache_"/>
        <input type="hidden" name="_status_" id="_status_"/>
        <input type="hidden" name="_sm_" id="_sm_" value="0"/>
        <input type="hidden" name="_sc_" id="_sc_" value="0"/>
        <div id="divwait" title="Espere un momento, por favor"><br /><p style="text-align: center"><img src='img/throbber.gif' /><br /><br />&nbsp;Cargando preferencias del usuario</p></div>

    </body>
</html>
<% }%>