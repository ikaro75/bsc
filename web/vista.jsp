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
        <script src="jQuery/js/directorio.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>
        <script src="jQuery/js/balancedscorecard.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>
        
        <!-- soporte para charts  -->
        <script src="jQuery/jqPlot/jquery.jqplot.min.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script> 
        <script src="jQuery/jqPlot/plugins/jqplot.pieRenderer.min.js?id=<%=usuario.getSesion()%>" type="text/javascript" ></script>
        <script src="jQuery/jqPlot/plugins/jqplot.donutRenderer.min.js?id=<%=usuario.getSesion()%>" type="text/javascript"></script>


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
                            <div class="ui-jqgrid-titlebar ui-widget-header ui-corner-top ui-helper-clearfix" style="padding: .3em .2em .2em .3em;">Indicadores Clave de Desempe�o</div>
                            <div class="portlet-content" style="height:95%">
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
                                                                        <td class="ui-pg-button ui-corner-all" title="Recargar datos" id="refresh_grid_141_636_0_top">
                                                                            <div class="ui-pg-div"><span class="ui-icon ui-icon-refresh"></span></div>
                                                                        </td>
                                                                        <td class="ui-pg-button ui-corner-all" title="Nuevo registro">
                                                                            <div class="ui-pg-div"><span class="ui-icon ui-icon-plus"></span></div>
                                                                        </td>
                                                                        <td class="ui-pg-button ui-corner-all" title="Editar registro">
                                                                            <div class="ui-pg-div"><span class="ui-icon ui-icon-pencil"></span></div>
                                                                        </td>
                                                                        <td class="ui-pg-button ui-corner-all" title="Eliminar registro">
                                                                            <div class="ui-pg-div"><span class="ui-icon ui-icon-trash"></span>
                                                                            </div>
                                                                        </td>
                                                                        <td class="ui-pg-button ui-state-disabled" style="width:4px;">
                                                                            <span class="ui-separator"></span>
                                                                        </td>
                                                                        <td class="ui-pg-button ui-corner-all" title="Expandir todo">
                                                                            <div class="ui-pg-div"><span class="ui-icon ui-icon-circlesmall-plus"></span></div>
                                                                        </td>
                                                                        <td class="ui-pg-button ui-corner-all" title="Colapsar todo">
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
                                    <p style='text-align: center'><img src='img/throbber.gif' />&nbsp;Espere por favor, construcci�n de interfaz en progreso</p>
                                </div>
                            </div>
                        </div>                        
                        <div class="tabUser" style="height: 100%;">
                            <div id="tacometro"></div>
                            <div id="grid_datos" class="queued_grids" app="145" form="782" wsParameters="" titulo="" inDesktop="true" openKardex="false"></div>
                            <div id="valores_historico"></div>
                            <div id="comentarios"></div>
                        </div>
                    </div>

                    <ul id="tlyPageGuide" data-tourtitle="Conozca las funciones del Sistema " style="display: none;">
                        <!-- use these classes to indicate where each number bubble should be
                        positioned. data-tourtarget should contain the selector for the element to
                        which you want to attach this pageguide step. -->
                        <li class="tlypageguide_left" data-tourtarget="#liInicio">
                            Aqu� encontrar&aacute; los sectores y organismos a los que pertenecen los suscriptores en el &aacute;rbol de la izquierda y los suscriptores y contactos a la derecha;
                        </li>
                        <li class="tlypageguide_left" data-tourtarget="#liAplicaciones">
                            Aqu&iacute; encontrar&aacute; los cat&aacute;logos y subcat&aacute;logos del directorio.
                        </li>
                        <li class="tlypageguide_left" data-tourtarget="#divBusqueda">
                            Aqu&iacute; puede realizar b&uacute;squedas de manera general. La b&uacute;squeda no es sensible a may&uacute;sculas, min&uacute;sculas, vocales acentuadas ni la letra &ntilde;.
                        </li>
                        <li class="tlypageguide_top" data-tourtarget="#tvSuscriptores">
                            En &eacute;ste &aacute;rbol de carpetas se clasifican los sectores y organismos. Para agregar un sector o un organismo haga clic derecho sobre el sector en donde lo desea insertar y seleccione del menu contextual "Nuevo sector" o "Nuevo organismo". Si desea editar alg�n sector u organismo selecci&oacute;nelo, haga clic con el bot&oacute;n derecho y escoja "Editar" del men� contextual. 
                            Para reubicar un sector u organismo dentro de otro sector seleccione,y arrastre y su&eacute;ltelo en el sector deseado.
                        </li>
                        <li class="tlypageguide_top" data-tourtarget=".jqx-splitter-collapse-button-vertical">
                            Haga clic aqu� para ocultar el &aacute;rbol de sectores y organismos; vuelva a hacer clic para volverlo a mostrar 
                        </li>
                        <li class="tlypageguide_bottom" data-tourtarget="#grid_suscriptores">
                            En esta secci&oacute;n se pueden visualizar los datos referentes a los suscriptores y contactos de acuerdo al sector, subsector u organizaci&oacute;n seleccionada en el �rbol.
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
                                                <h1>Comienza a usar los cat�logos</h1>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <img src='img/como_usar_aplicaciones.png'  class='helpScreen'/>
                                            </td>
                                            <td class='instrucciones'>
                                                <p class='instrucciones'>
                                                    En este espacio puedes operar los cat�logos, para comenzar haz lo siguiente:</p>
                                                <table>
                                                    <tr>
                                                        <td><img src="img/paso1.png" /></td><td class='instrucciones'>Ve a la pesta�a "Cat�logos"</td>
                                                    </tr>
                                                    <tr>
                                                        <td><img src="img/paso2.png" /></td><td class='instrucciones'>Haz clic en el bot�n del cat�logo que deseas abrir; inmediatamente despu�s se abrir� una pesta�a con el nombre del cat�logo  seleccionado</td>
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
                                                <h1>Agrega un registro nuevo al cat�logo</h1>
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
                                                        <td>Haz clic encima del bot�n <span class='ui-icon ui-icon-plus' style='display:inline-block'></span>de la barra de herramientas del cat�logo. <br />
                                                            La p�gina desplegar� una ventana solicitando la informaci�n que se requiere para agregar el nuevo registro. Los campos marcados con (*) son obligatorios.</td>
                                                    </tr>
                                                    <tr>
                                                        <td><img src="img/paso2.png" /></td>
                                                        <td>Ingresa los datos conforme se solicitan</td>
                                                    </tr>
                                                    <tr>
                                                        <td><img src="img/paso3.png" /></td>
                                                        <td>Presiona el bot�n "Guardar"; esto cerrara la ventana e incorporar� el nuevo registro al cat�logo. </td>
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
                                                <h1>Edita un registro del cat�logo</h1>
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
                                                        <td>Selecciona del cat�logo el registro que deseas editar.</td>    
                                                    </tr>
                                                    <tr>
                                                        <td><img src="img/paso2.png" /></td>
                                                        <td>Haz clic encima del bot�n <span class='ui-icon ui-icon-pencil' style='display:inline-block'></span>de la barra de herramientas del cat�logo. <br />
                                                            La p�gina desplegar� una ventana con la informaci�n del registro seleccionado para que lo edites. </td>
                                                    </tr>
                                                    <tr>
                                                        <td><img src="img/paso3.png" /></td>
                                                        <td>Edita los campos necesarios,  aquellos marcados con (*) son obligatorios.</td>
                                                    </tr>    
                                                    <tr>
                                                        <td><img src="img/paso4.png" /></td>
                                                        <td>Presiona el bot�n "Guardar"; esto cerrara la ventana y actualizar� el registro.</td>
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
                                                <h1>Elimina un registro del cat�logo</h1>
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
                                                        <td>Selecciona del cat�logo el registro que deseas eliminar.</td>
                                                    </tr>    
                                                    <tr>
                                                        <td><img src="img/paso2.png" /></td>
                                                        <td>Haz clic encima del bot�n <span class='ui-icon ui-icon-trash' style='display:inline-block'></span>de la barra de herramientas del cat�logo. <br />
                                                            La p�gina solicitar� que confirmes la eliminaci�n.</td> 
                                                    </tr>
                                                    <tr>
                                                        <td><img src="img/paso3.png" /></td>
                                                        <td>Presiona OK en el dialogo de confirmaci�n para proceder con el borrado</td>
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
                                                <h1>Filtra los registros del cat�logo</h1>
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
                                                        <td>Haz clic encima del bot�n <span class='ui-icon ui-icon-search' style='display:inline-block'></span>de la barra de herramientas del cat�logo. <br />
                                                            La p�gina desplegar� una ventana para ingresar los criterios de filtrado</td> 
                                                    </tr>
                                                    <tr>
                                                        <td><img src="img/paso2.png" /></td>
                                                        <td>Ingresa al menos un criterio de filtrado; puedes seleccionar m�s de uno. Mientras m�s criterios utilices m�s reducida ser� el resultado de la b�squeda.</td>
                                                    </tr>        
                                                    <tr>
                                                        <td><img src="img/paso3.png" /></td>
                                                        <td>Si deseas guardar el filtro para su posterior uso, as&iacute;gnale un nombre en el campo <a href="javascript:void(0);" class="tooltipLink" id="img/guardar_filtro_como.png">Guardar filtro como</a>:"; recuperalo posteriormente en el men� <a href="javascript:void(0);" class="tooltipLink" id="img/mis_filtros.png">"Mis filtros"</a> que se encuentra a la izquierda del cat�logo. </td>
                                                    </tr>        
                                                    <tr>
                                                        <td><img src="img/paso4.png" /></td>
                                                        <td>Presiona el bot�n "Buscar"; esto cerrar� la ventana y mostrar� el resultado en el cat�logo. Para remover el filtro y restaurar los registros haz clic encima de la liga (Quitar filtro) que se encuentra junto al titulo del cat�logo." </td>
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
            <p>!Bienvenido al Directorio de Suscriptores y Contactos de la Revista Eficiencia Energ&eacute;tica! <br/> <br/>&iquest;Requiere de una gu&iacute;a para aprender a usarlo?</p>
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