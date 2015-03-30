<%@ page import="mx.org.fide.modelo.*" %><%
    Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
    if (usuario == null) {
        request.getRequestDispatcher("/login.jsp"); 
    }
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>AdministraX</title>

        <!-- librerias para cargar dialogo  -->
        <script type="text/javascript" src="jQuery/js/jquery-1.7.2.min.js"></script>
        <script type="text/javascript" src="jQuery/js/jquery-ui-1.8.21.custom.min.js"></script>

        <!-- app portlets -->
        <script type="text/javascript" src="jQuery/js/jquery.appportlet.js" ></script>
        <script type="text/javascript" src="jQuery/js/jquery.pi.portletlog.js" ></script>
        <script type="text/javascript" src="jQuery/js/jquery.pi.portletfilter.js" ></script>
        <script type="text/javascript" src="jQuery/js/jquery.pi.portletreport.js" ></script>

        <!-- Cookie -->
        <script type="text/javascript"  src="jQuery/js/jquery.cookie.js" ></script>

        <!-- jqGrid -->
        <script type="text/javascript" src="jQuery/js/grid.locale-es.js" ></script>
        <script type="text/javascript" src="jQuery/js/jquery.jqGrid.min.js"></script>
        <script type="text/javascript" src="jQuery/js/grid.subgrid.js"></script>
        <script type="text/javascript" src="jQuery/js/jquery.jstree.js"></script>


        <!--Datetime picker -->
        <script src="jQuery/js/jquery-ui-timepicker-addon.js" type="text/javascript"></script>

        <!-- Calculator -->
        <script type="text/javascript" src="jQuery/js/jquery.calculator.min.js" ></script>
        <script type="text/javascript" src="jQuery/js/jquery.calculator-es.js" ></script>

        <!-- Menu -->
        <script src="jQuery/js/jquery.ui.menu.js" type="text/javascript"></script>

        <!-- Carrousel -->
        <script type="text/javascript" src="jQuery/js/agile_carousel.alpha.js"></script>

        <!-- Tooltip -->
        <script src="jQuery/js/jquery.tooltip.min.js" type="text/javascript"></script>

        <!-- form plugin para considerar uploads  -->
        <script type="text/javascript" src="jQuery/js/jquery.form.js"></script>
        
        <script type="text/javascript" src="jQuery/js/finanzax.js"></script>

        <link rel="stylesheet" type="text/css" media="screen" href="css/agile_carousel.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="css/redmond/jquery.ui.all.css" />
        <link rel="stylesheet" type="text/css" media="screen" href="jQuery/js/jqGrid/css/ui.jqgrid.css"/>
        <link rel="stylesheet" type="text/css" media="screen" href="css/jquery.tooltip.css"/>
        <link rel="stylesheet" type="text/css" media="screen" href="css/style.css"/>
        <link rel="stylesheet" type="text/css" media="screen" href="css/vista.css"/>
        <link rel="stylesheet" type="text/css" media="screen" href="css/calculator/jquery.calculator.css"/>
        <link rel="stylesheet" type="text/css" media="screen" href="jQuery/js/jwysiwyg-master/jquery.wysiwyg.css" />


        <script src="jQuery/js/funciones.js" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.desktop.js" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.gridqueue.js" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.field_toolbar.js" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.session.js" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.form.js" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.formqueue.js" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.accordion.js" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.tab.js" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.grid.js" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.treeMenu.js" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.appmenu.js" type="text/javascript"></script>
        <script src="jQuery/js/jquery.pi.comments.js" type="text/javascript"></script>
        <script src="jQuery/js/jquery.timeago.js" type="text/javascript"></script>
        <script src="jQuery/js/jquery.timeago.es.js" type="text/javascript"></script>
        
        <script type="text/javascript" src="jQuery/js/jwysiwyg-master/jquery.wysiwyg.js"></script>
        <script type="text/javascript" src="jQuery/js/sets/html/set.js"></script>
        
        <script src="jQuery/js/vista.js" type="text/javascript"></script>
    </head>
    <body id="top">
        <!-- <script type="text/javascript"
                src="http://jqueryui.com/themeroller/themeswitchertool/">
        </script> -->
        <div id="banner">
            <div style="float: left; position: relative; ">
                <br />
                <img src="img/administrax_logo.png" class="logo_plataforma"/></div>
            <div id="sessionMenu" style="float: right; position: relative; "></div>
        </div>
        <!-- 
        <div class="menus_plataforma">
            <div id="app_menu" style="float:left">
                <div>
                    <a href='#' id='menu_inicio' >Inicio</a>
                    <a href='#' id='menu_aplicaciones' >Aplicaciones</a>
                    <a href='#' id='menu_splitter' >&nbsp;</a>
                    <a href='#' id='menu_mapa' >Mapa del sitio</a>
                    <a href='#' id='menu_ayuda' >Ayuda</a>
                    <a href='#' id='menu_contacto' >Contacto</a>
                </div>
                <ul id="apps">
                </ul>    
            </div>
        </div>
        -->
        <div id="tabcontainer">
            <div id="tabs">
                <div style="padding-right: 5px; float: right; padding-top: 3px; position: relative; top: -30px; width:300px">
                    <div id="switcher"  style="float:right"></div>
                </div>
                <div class="column ui-sortable">
                    <div class="portlet">
                        <div class="portlet-header">Aplicaciones</div>
                        <div class="portlet-content">
                            <p>Bienvenid@ a AdministraX, esperamos que esta herramienta sea de su utilidad</p>
                        </div>
                    </div>
                </div>
<div id="tabAplicaciones">
                <div id="appMenu_0" aplicacion="0"></div><br/>
                <div id="tab_0" style="height: 150%;">
                    <ul>
                        <li><a href='#tabMisAplicaciones'>Cómo usar mis aplicaciones</a></li>
                    </ul>
                    <div id='tabMisAplicaciones'>
                        <div id='divCarouselMisAplicaciones'>
                            <div id='ayudaComoUsarMisAplicaciones'>
                                <table >
                                    <tr>
                                        <td colspan='2'>
                                            <h3>Comienza a usar tus aplicaciones</h3>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <img src='img/como_usar_aplicaciones.png'  class='helpScreen'/>
                                        </td>
                                        <td class='instrucciones'>
                                            <p class='instrucciones'>
                                                En este espacio puedes abrir tus aplicaciones, para comenzar haz lo siguiente:</p>
                                            <ol>
                                                <li class='instrucciones'>Ve a la pestaña "Aplicaciones"</li>
                                                <li class='instrucciones'>Haz clic en el botón de la aplicación que deseas abrir; inmediatamente después se abrirá una pestaña con el nombre de la aplicación seleccionada con el catálogo principal</li>
                                            </ol>        
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id='ayudaComoAgregarUnRegistro'>
                                <table >
                                    <tr>
                                        <td colspan='2'>
                                            <h3>Agrega un registro nuevo al catálogo</h3>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <img src='img/como_agregar_registros.png'  class='helpScreen' />
                                        </td>
                                        <td class='instrucciones'>
                                            <p class='instrucciones'>
                                                Para agregar un registro sigue los siguientes pasos:</p>
                                            <ol>
                                                <li>Haz clic encima del botón <span class='ui-icon ui-icon-plus' style='display:inline-block'></span>de la barra de herramientas del catálogo. <br />
                                                    La página desplegará una ventana solicitando la información que se requiere para agregar el nuevo registro. Los campos marcados con (*) son obligatorios.
                                                </li>
                                                <li>Ingresa los datos conforme se solicitan</li>
                                                <li>Presiona el botón "Guardar"; esto cerrara la ventana e incorporará el nuevo registro al catálogo. </li>
                                            </ol>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id='ayudaComoEditarUnRegistro'>
                                <table >
                                    <tr>
                                        <td colspan='2'>
                                            <h3>Edita un registro del catálogo</h3>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <img src='img/como_editar_registros.png' class='helpScreen' />
                                        </td>
                                        <td class='instrucciones'>
                                            <p class='instrucciones'>
                                                Para editar un registro sigue los siguientes pasos:</p>
                                            <ol>
                                                <li>Selecciona del catálogo el registro que deseas editar.</li>    
                                                <li>Haz clic encima del botón <span class='ui-icon ui-icon-pencil' style='display:inline-block'></span>de la barra de herramientas del catálogo. <br />
                                                    La página desplegará una ventana con la información del registro seleccionado para que lo edites. 
                                                </li>
                                                <li>Edita los campos necesarios,  aquellos marcados con (*) son obligatorios.</li>
                                                <li>Presiona el botón "Guardar"; esto cerrara la ventana y actualizará el registro</li>
                                            </ol>                                        
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id='ayudaComoEliminarUnRegistro'>
                                <table >
                                    <tr>
                                        <td colspan='2'>
                                            <h3>Elimina un registro del catálogo</h3>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <img src='img/como_eliminar_registros.png' class='helpScreen' />
                                        </td>
                                        <td class='instrucciones'>
                                            <p class='instrucciones'>
                                                Para eliminar un registro sigue los siguientes pasos:</p>
                                            <ol>
                                                <li>Selecciona del catálogo el registro que deseas eliminar.</li>    
                                                <li>Haz clic encima del botón <span class='ui-icon ui-icon-trash' style='display:inline-block'></span>de la barra de herramientas del catálogo. <br />
                                                    La página solicitará que confirmes la eliminación. 
                                                </li>
                                                <li>Presiona OK en el dialogo de confirmación para proceder con el borrado</li>
                                            </ol>                                        
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id='ayudaComoFiltrarRegistros'>
                                <table >
                                    <tr>
                                        <td colspan='2'>
                                            <h3>Filtra los registros del catálogo</h3>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <img src='img/como_filtrar_registros.png' class='helpScreen' />
                                        </td>
                                        <td class='instrucciones'>
                                            <p class='instrucciones'>
                                                Filtra para encontrar el conjunto de registros que cumplen con tus criterios de filtrado. Para filtrar registros sigue los siguientes pasos:</p>
                                            <ol> 
                                                <li>Haz clic encima del botón <span class='ui-icon ui-icon-search' style='display:inline-block'></span>de la barra de herramientas del catálogo. <br />
                                                    La página desplegará una ventana para ingresar los criterios de filtrado 
                                                </li>
                                                <li>Ingresa al menos un criterio de filtrado; puedes seleccionar más de uno. Mientras más criterios utilices más reducida será el resultado de la búsqueda.</li>
                                                <li>Si deseas guardar el filtro para su posterior uso, asignale un nombre en el campo <a href="javascript:void(0);" class="tooltipLink" id="img/guardar_filtro_como.png">Guardar filtro como</a>:"; recuperalo posteriormente en el menú <a href="javascript:void(0);" class="tooltipLink" id="img/mis_filtros.png">"Mis filtros"</a> que se encuentra a la izquierda del catálogo. </li>
                                                <li>Presiona el botón "Buscar"; esto cerrará la ventana y mostrará el resultado en el catálogo. Para remover el filtro y restaurar los registros haz clic encima de la liga (Quitar filtro) que se encuentra junto al titulo del catálogo." </li>
                                            </ol>                                        
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id='ayudaComoAgregarCatalogoAFavoritos'>
                                <table >
                                    <tr>
                                        <td colspan='2'>
                                            <h3>Agrega a tus favoritos los catálogos que utilizas más frecuentemente</h3>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <img src='img/favoritos.png'  class='helpScreen'/>
                                        </td>
                                        <td class='instrucciones'>
                                            <p class='instrucciones'>
                                                Puedes agregar a la pestaña de inicio los catálogos que utilizas más frecuentemente en "Mis favoritos", para agregar un favorito haz lo siguiente:</p>
                                            <ol>
                                                <li class='instrucciones'>Ve a la pestaña "Aplicaciones"</li>
                                                <li class='instrucciones'>Haz clic en el botón de la aplicación que deseas abrir</li>
                                                <li class='instrucciones'>Haz clic en el botón <span class='ui-icon ui-icon-star' style='display:inline-block'></span> de la barra de herramientas del catálogo que deseas hacer tu favorito</li>
                                            </ol>        
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>       
                </div>
            </div>                
            </div>
            <div id="tabAyuda">
                <div id="divCarouselAyuda">
                    <div id="ayudaIndice">
                        <table>
                            <tr>
                                <td>
                                    <h2 class="instrucciones">Indice de temas de ayuda</h2>
                                </td>
                            </tr>
                            <tr>
                                <td class="instrucciones">
                                    <div style="text-align: center;">
                                        <table style="margin: 0 auto;text-align: left;">
                                            <tr>
                                                <td style="vertical-align:top;  text-align: left; width:450px">
                                                    <p class="instrucciones">
                                                        <ol> 
                                                            <li><a href="#" class="lnkAyuda" id="ayuda-2">Vistazo general al sistema</a></li>
                                                            <li><a href="#" class="lnkAyuda" id="ayuda-3">Inicio</a></li>
                                                            <li><a href="#" class="lnkAyuda" id="ayuda-4">Aplicaciones</a></li>
                                                            <li><a href="#" class="lnkAyuda" id="ayuda-14">Mapa del sitio</a></li>
                                                        </ol>            
                                                    </p> 
                                                </td>
                                                <td>
                                                    <img src='img/portada_ayuda.png' style='border: 1px'  class='helpScreen'></img>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </td>                                    
                            </tr>
                        </table>
                    </div>
                    <div id="ayudaVistazo">
                        <table>
                            <tr>
                                <td>
                                    <h2 class="instrucciones">Vistazo general al sistema</h2>
                                </td>
                            </tr>
                            <tr>
                                <td class="instrucciones">
                                    <p class="instrucciones">
                                        La plataforma cuenta con 5 partes principales: <br />
                                        <ul>
                                            <li>Inicio: en donde se encuentran las pestañas "Pendientes" y "Favoritos".
                                                <ul>
                                                    <li>En "Pendientes" puedes ver y atender tus actividades</li>
                                                    <li>En "Favoritos" puedes tener los catálogos que uses con mayor frecuencia a la mano</li>
                                                </ul>
                                            </li>
                                            <li>Aplicaciones: aquí encontrarás los módulos que conforman la plataforma. Cada aplicación cuenta con un catálogo principal y del cual se desprenden otros catálogos relacionados en forma de kardex.</li>
                                            <li>Mapa del sitio: es el listado con las ligas hacia todos las partes de la plataforma.</li>
                                            <li>Ayuda: contiene el índice del manual en línea.</li>
                                            <li>Contacto: aquí se presenta la información para contactar al administrador de la plataforma.</li>
                                        </ul>
                                    </p>
                                    <p class="instrucciones">
                                        Por otra parte, los catálogos se presentan en una cuadrícula y dependiendo de los permisos de tu perfil se mostrarán botones para insertar <span class='ui-icon ui-icon-plus' style='display:inline-block'></span> , editar <span class='ui-icon ui-icon-pencil' style='display:inline-block'></span>, eliminar<span class='ui-icon ui-icon-trash' style='display:inline-block'></span>, hacer búsquedas de registros<span class='ui-icon ui-icon-search' style='display:inline-block'></span>, asi como abrir el kardex<span class='ui-icon ui-icon-newwin' style='display:inline-block'></span> con los catálogos relacionados al registro seleccionado.
                                    </p>
                                </td>                                    
                            </tr>
                        </table>
                    </div>
                    <div id="ayudaInicio">
                        <table>
                            <tr>
                                <td>
                                    <h2 class="instrucciones">Inicio</h2>
                                </td>
                            </tr>
                            <tr>
                                <td class="instrucciones">
                                    <p class="instrucciones">
                                        Dentro de la pestaña "Inicio"  hay otras dos pestañas: "Pendientes" y "Favoritos". <br />
                                        En "Pendientes" puedes ver las actividades por realizar así como la liga para ingresar los datos propios del pendiente; cada perfil tiene sus propios pendientes, y son configurados por el administrador del sistema. <br /><br/>
                                        En "Favoritos" podrás acceder a catálogos que marcaste como favoritos, evitando navegar en las aplicaciones.
                                    </p>
                                    <p class="instrucciones">
                                        <strong>Temas relacionados</strong>
                                        <ul>
                                            <li><a href="#" class="lnkAyuda" id="ayuda-4">Agrega a tus favoritos los catálogos que más utilizas </a></li>
                                            <li><a href="#" class="lnkAyuda" id="ayuda-5">Elimina los favoritos que ya no utilizas</a></li>
                                        </ul>
                                    </p> 
                                </td>                                    
                            </tr>
                        </table>
                    </div>
                </div>
            </div>             
        </div>
        <input type="hidden" name="_ce_" id="_ce_" value="<%=usuario.getClave()%>" />
        <input type="hidden" name="_cp_" id="_cp_" value="<%=usuario.getClavePerfil()%>" />
        <input type="hidden" name="_cp_" id="_ca_" value="<%=usuario.getClaveArea()%>" />
        <input type="hidden" name="_gq_" id="_gq_" value="" />
        <input type="hidden" name="_gado_" id="_gado_" value="true" />
        <div id="divwait" title="Espere un momento, por favor"><br /><p style="text-align: center"><img src='img/throbber.gif' /><br /><br />&nbsp;Cargando preferencias del usuario</p></div>
    </body>
</html>