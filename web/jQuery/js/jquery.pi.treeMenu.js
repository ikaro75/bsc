/* 
 * \u00e1 -> á 
 \u00e9 -> é 
 \u00ed -> í 
 \u00f3 -> ó 
 \u00fa -> ú 
 
 \u00c1 -> Á 
 \u00c9 -> É 
 \u00cd -> Í 
 \u00d3 -> Ó 
 \u00da -> Ú 
 
 \u00f1 -> ñ 
 \u00d1 -> Ñ
 * and open the template in the editor.
 */
/*
 * Plugin de jQuery para cargar arbol a partir de un webservice
 *
 */

(function ($) {
    $.fn.treeMenu = function (opc) {

        $.fn.treeMenu.settings = {
            xmlUrl: "control?$cmd=plain",
            app: "",
            entidad: "",
            pk: "",
            datestamp: sDateTime(new Date()),
            error: ""
        };

        // Devuelvo la lista de objetos jQuery
        return this.each(function () {
            $.fn.treeMenu.options = $.extend($.fn.treeMenu.settings, opc);
            obj = $(this);
            obj.attr("app", $.fn.treeMenu.options.app);
            obj.attr("entidad", $.fn.treeMenu.options.entidad);
            obj.attr("pk", $.fn.treeMenu.options.pk);
            obj.attr("datestamp", $.fn.treeMenu.options.datestamp);
            $.fn.treeMenu.getTreeDefinition(this);

            //Aquí se le asignan eventos a los botones de herramientas del árbol
            $("#refresh_tree_button").click(function () {
                $.fn.treeMenu.getTreeDefinition($("#tvIndicadores"));
            });

            $("#add_node_tree_button").click(function () {
                $("#divwait")
                        .html("<br /><p style='text-align: center'><img src='img/throbber.gif' />&nbsp;Generando forma...</p>")
                        .attr('title', 'Espere un momento por favor')
                        .dialog({
                            height: 140,
                            modal: true,
                            autoOpen: true,
                            closeOnEscape: false
                        });

                w = "";
                if ($('#tvIndicadores').jstree('get_selected').length > 0) {
                    nPK = $('#tvIndicadores').jstree('get_selected').attr('id').split("_")[1].split("-")[0];
                    w = "clave_indicador=" + nPK;
                }

                $("body").form({
                    app: "145",
                    forma: 775,
                    modo: "insert",
                    columnas: 1,
                    pk: 0,
                    filtroForaneo: "2=clave_aplicacion=141&3=" + w,
                    height: "90%",
                    width: "80%",
                    originatingObject: "",
                    showRelationships: "false",
                    updateControl: "tvIndicadores",
                    secondFieldText: "" //Puesto que se trata de un registro nuevo, 
                });
            });

            $("#edit_node_tree_button").click(function () {
                $("#divwait")
                        .html("<br /><p style='text-align: center'><img src='img/throbber.gif' />&nbsp;Generando forma...</p>")
                        .attr('title', 'Espere un momento por favor')
                        .dialog({
                            height: 140,
                            modal: true,
                            autoOpen: true,
                            closeOnEscape: false
                        });

                if ($('#tvIndicadores').jstree('get_selected').length == 0) {
                    alert("Seleccione el nodo del \u00e1rbol que desea editar");
                    return;
                } else {
                    nPK = $('#tvIndicadores').jstree('get_selected').attr('id').split("_")[1].split("-")[0];
                    $("body").form({
                        app: "145",
                        forma: 775,
                        modo: "update",
                        columnas: 1,
                        pk: nPK,
                        filtroForaneo: "2=clave_aplicacion=141&3=",
                        height: "90%",
                        width: "80%",
                        originatingObject: "",
                        showRelationships: "false",
                        updateControl: "tvIndicadores",
                        secondFieldText: "" //Puesto que se trata de un registro nuevo, 
                    });
                }
            });

            $("#delete_node_tree_button").click(function () {
                if ($('#tvIndicadores').jstree('get_selected').length == 0) {
                    alert("Seleccione el nodo del \u00e1rbol que desea eliminar");
                    return;
                } else {

                    if (!confirm("\xBFEst\u00e1 seguro que desea eliminar el registro? No es posible deshacer esta acci\u00f3n."))
                        return false;
                    else {
                        $.ajax(
                                {
                                    url: "control?$cmd=register&$ta=delete&$cf=775&$pk=" + $('#tvIndicadores').jstree('get_selected').attr('id').split("_")[1].split("-")[0],
                                    dataType: "text",
                                    success: function (data) {
                                        //Borra el nodo del ?rbol
                                        $("#tvIndicadores").jstree("delete_node", "#" + $('#tvIndicadores').jstree('get_selected').attr('id'));
                                    },
                                    error: function (xhr, err) {
                                        if (xhr.responseText.indexOf("Iniciar sesi&oacute;n") > -1) {
                                            alert("Su sesión ha expirado, por seguridad es necesario volverse a registrar");
                                            window.location = 'login.jsp';
                                        }
                                        alert("Error al eliminar registro");
                                    }
                                });
                    }
                }
            });

            $("#expand_tree_button").click(function () {
                $("#tvIndicadores").jstree('open_all');
            });

            $("#collapse_tree_button").click(function () {
                $("#tvIndicadores").jstree("close_all");
            });
        });
    }

    $.fn.treeMenu.getTreeDefinition = function (o) {
        $("#divwait")
                .html("<br /><p style='text-align: center'><img src='img/throbber.gif' />&nbsp;Recuperando indicadores...</p>")
                .attr('title', 'Espere un momento por favor')
                .dialog({
                    height: 140,
                    modal: true,
                    autoOpen: true,
                    closeOnEscape: false
                });


        $("#_status_").val("Cargando indicadores");
        var nEntidad = $(o).attr("entidad");
        var nPk = $(o).attr("pk");
        $.ajax({
            url: $.fn.treeMenu.options.xmlUrl + "&$cf=" + nEntidad + "&$pk=" + nPk + "&$ta=children", //,"categorias.xml", //
            dataType: ($.browser.msie) ? "text" : "xml",
            contentType: "application/x-www-form-urlencoded",
            success: function (xmlTree) {
                if (typeof xmlTree == "string") {
                    xmlGT = new ActiveXObject("Microsoft.XMLDOM");
                    xmlGT.async = false;
                    xmlGT.validateOnParse = "true";
                    xmlGT.loadXML(xmlTree);
                    if (xmlGT.parseError.errorCode > 0)
                        alert("Error de compilación xml:" + xmlGT.parseError.errorCode + "\nParse reason:" + xmlGT.parseError.reason + "\nLinea:" + xmlGT.parseError.line);
                }
                else
                    xmlGT = xmlTree;

                var error = $(xmlTree).find("error");

                if (error.length > 0) {
                    if (error.find("tipo").text() == "SQLServerException" && $("#_cp_").val() == "1") {
                        $.fn.appgrid.options.error += "Hay un error en la consulta (" +
                                error.find("general").text() + ". " +
                                error.find("descripcion").text() + "), haga click <a href='#' id='lnkEditQuery_" +
                                $.fn.appgrid.options.app + "_" + $.fn.appgrid.options.entidad + "' class='editLink'>aqui</a> para editarla "
                        obj.html($.fn.appgrid.options.error);
                        return true;
                    }
                }

                var oTypes = {
                    "max_depth": -2,
                    "max_children": -2,
                    "types": {}
                };

                //Destruye los nodos existentes para recargarlos
                $("ul", obj).remove();
                oRegistros = $(xmlGT).find("registro")

                var sTypes = "";
                //Se define la estructura del árbol de acuerdo a la aplicación
                var sXML = "";

                oRegistros.each(function () {
                    sDateStamp = $(o).attr("datestamp");
                    sTypes += '"' + $.trim($(this).find('rel').text().replace('\n', '')) + '":{"icon":{"image":"' + $.trim($(this).find('icono').text().split('\n')[0]) + '"}},';
                    nClaveNodo = $.trim($(this).find('clave_nodo').text().replace('\n', '')) //+ "-" + sDateStamp;
                    sRel = $.trim($(this).find('rel').text().replace('\n', ''));
                    sTextoNodo = $.trim($(this).find('texto_nodo').text().replace('\n', '')).replace("&aacute;", "á").replace("&eacute;", "é").replace("&iacute;", "í").replace("&oacute;", "ó").replace("&uacute;", "ú").replace("&Aacute;", "Á").replace("&Eacute;", "É").replace("&Iacute;", "Í").replace("&Oacute;", "Ó").replace("&Uacute;", "Ú");
                    nClaveNodoPadre = $.trim($(this).find('clave_nodo_padre').text().replace('\n', '')) //+ "-" + sDateStamp;
                    //sState=$.trim($(this).find('state').text().replace('\n',''));
                    sState = nClaveNodoPadre.split("-")[0] != "" ? "closed" : "open";
                    sEvento = $.trim($(this).find('onclick').text().replace('\n', ''));
                    nRefrescaArbol = $.trim($(this).find('refresca_arbol').text().replace('\n', ''));
                    sXML += "<item id='" + nClaveNodo + "' parent_id='" + nClaveNodoPadre + "' rel='" + sRel + "' state='" + sState + "' evento='" + sEvento + "' refresca_arbol='" + nRefrescaArbol + "'><content><name><![CDATA[" + sTextoNodo + "]]></name></content></item>";
                });

                var responsables = "";
                sXML = "<root>" + sXML + "</root>";
                aPlugins = "themes,contextmenu,xml_data,types,ui,dnd".split(",");
                sTypes = "{" + sTypes.substring(0, sTypes.length - 1) + "}";
                oTypes.types = $.parseJSON(sTypes);

                $(o).bind("loaded.jstree", function () {
                    //Se debe disparar la selección del primer nodo
                   $("#" + this.id).jstree("select_node", "#pki_1");
                   //$(($(this).find("li")[0]).find("a")[0]).click();
                }).bind("open_node.jstree", function (event, data) { 
                     //data.rslt.np[0].id.split("_")[1].split("-")[0]
                    if((data.inst._get_parent(data.rslt.obj)).length) { 
                       data.inst.open_node(data.inst._get_parent(data.rslt.obj), false,true); 
                    } 
                }).bind("select_node.jstree", function (event, data) {
                    pageguide.close();
                    //`data.rslt.obj` is the jquery extended node that was clicked      
                    var sTitulo ="";
                    data.rslt.obj.parents("li").each(function () {
                        //parents.push({ id: $(this).attr("id"), description: $(this).children("a").text() });
                        sTitulo=$(this).children("a").text() + '/' + sTitulo;
                    });

                    var oTheNode = data.rslt.obj;
                    var sNodeId = data.rslt.obj.attr("id");
                    var descripcionIndicador = "";
                    var sTitulo= (sTitulo!="")? sTitulo + $.trim(data.rslt.obj.children("a").text()):$.trim(data.rslt.obj.children("a").text());
                    var sFiltro = $(oTheNode).attr("evento");
                    var nApp = sNodeId.split("-")[1];
                    var nForma = sNodeId.split("-")[2];
                    var nRefrescaArbol = $(oTheNode).attr("refresca_arbol");
                    var sW = "";

                    var claveIndicador = $('#tvIndicadores').jstree('get_selected').attr('id').split("_")[1].split("-")[0];
                    $("#_cache_").val(claveIndicador);
                    $.ajax(
                            {url: "control?$cmd=plain&$ta=select&$cf=775&$pk=" + claveIndicador + "&$w=clave_indicador=" + claveIndicador,
                                dataType: ($.browser.msie) ? "text" : "xml",
                                type: "POST",
                                success: function (data) {
                                    if (typeof data == "string") {
                                        xmlIndicador = new ActiveXObject("Microsoft.XMLDOM");
                                        xmlIndicador.async = false;
                                        xmlIndicador.validateOnParse = "true";
                                        xmlIndicador.loadXML(data);

                                        if (xmlIndicador.parseError.errorCode > 0) {
                                            alert("Error de compilación xml:" + xmlIndicador.parseError.errorCode + "\nParse reason:" + xmlIndicador.parseError.reason + "\nLinea:" + xmlIndicador.parseError.line);
                                        }
                                    }
                                    else {
                                        xmlIndicador = data;
                                    }

                                    var indicador = $(xmlIndicador).find("indicador")[0].childNodes[0].data;
                                    descripcionIndicador = $(xmlIndicador).find("descripcion")[0].childNodes[0].data
                                    var valorActual = $(xmlIndicador).find("valor_actual")[0].childNodes[0].data
                                    var claveFormaDetalle = $(xmlIndicador).find("clave_forma_detalle")[0].childNodes[0].data
                                    var formato = $(xmlIndicador).find("formato")[0].childNodes[0].data;
                                    var claveTipoIndicador = $(xmlIndicador).find("clave_tipo_indicador")[0].childNodes[0].data;
                                    var claveNodoPadre = $(xmlIndicador).find("clave_indicador_padre")[0].childNodes[0].data;

                                    //Se va a ejecutar una acción dependiendo del tipo de indicador 
                                    if (claveNodoPadre == "") {
                                       
                                        $("#frontweb")
                                                .html('<div id="divgrid_1_101_0" app="1" form="101" wsParameters="" titulo="Mis pendientes" leyendas="Nueva actividad, Editar actividad" inDesktop="true" openKardex="false" ></div>');
                                        $("#divgrid_1_101_0").appgrid({app: "1",
                                            entidad: "101",
                                            wsParameters: "",
                                            titulo: "Alertas",
                                            inDesktop: "true",
                                            height: "480px",
                                            removeGridTitle: true,
                                            showFilterLink: false,
                                            inQueue: true,
                                            insertInDesktopEnabled: 0,
                                            editingApp: "1",
                                            width: "100%",
                                            tipoConsulta: "select"
                                        });
                                        //Presenta grid de pendientes
                                    } else if (claveTipoIndicador == "2") {

                                        $("#frontweb").html(
                                                '<div class="portlet" style="width: 47%; float: left; margin-left: 10px;" id="datos_generales_indicador">' +
                                                '<div class="portlet-header">Datos generales del indicador<div id="datos_generales_indicador_d" /></div>' +
                                                '<div class="portlet-content" id="datos_indicador" style="margin: 5px;">' +
                                                '</div></div>' +
                                                '<div class="portlet" style="width: 47%; float: left; margin-left: 10px;" id="tacometro_portlet">' +
                                                '<div class="portlet-header">Desempe&ntilde;o del indicador<div id="tacometro_portlet_d" /></div>' +
                                                '<div class="portlet-content" id="desempeño_indicador" style="margin: 5px;">' +
                                                '<div id="tacometro" style="background-color: #FFF;" ></div>' +
                                                '</div></div><input type="hidden" id="filtros_indicador" value=""/> ');
                                        //Extrae nombres de los responsables
                                        $.ajax({url: "control?$cmd=plain&$ta=select&$cf=776&$w=clave_indicador=" + claveIndicador,
                                            dataType: ($.browser.msie) ? "text" : "xml",
                                            type: "POST",
                                            success: function (data) {
                                                if (typeof data == "string") {
                                                    xmlResponsables = new ActiveXObject("Microsoft.XMLDOM");
                                                    xmlResponsables.async = false;
                                                    xmlResponsables.validateOnParse = "true";
                                                    xmlResponsables.loadXML(data);

                                                    if (xmlResponsables.parseError.errorCode > 0) {
                                                        alert("Error de compilación xml:" + xmlResponsables.parseError.errorCode + "\nParse reason:" + xmlResponsables.parseError.reason + "\nLinea:" + xmlResponsables.parseError.line);
                                                    }
                                                }
                                                else {
                                                    xmlResponsables = data;
                                                }

                                                responsables = "";
                                                $(xmlResponsables).find("personal").each(function () {
                                                    responsables += $(this).text() + "<br />";
                                                });

                                                //Presenta información general del indicador
                                                $("#datos_indicador").html("<h2>" + sTitulo + "</h2>"
                                                        + "<p>" + descripcionIndicador + "</p>"
                                                        + "<p><strong>Responsables</strong><p>" +
                                                        responsables
                                                        );
                                            },
                                            error: function (xhr, err) {
                                                if (xhr.responseText.indexOf("Iniciar sesi&oacute;n") > -1) {
                                                    alert("Su sesión ha expirado, por seguridad es necesario volverse a registrar");
                                                    window.location = 'login.jsp';
                                                }
                                                alert("Error al recuperar responsables del indicador");
                                            }
                                        });


                                        $("#tacometro").html("");

                                        new JustGage({
                                            id: "tacometro",
                                            value: valorActual,
                                            min: 0,
                                            max: 100,
                                            title: " ",
                                            label: indicador,
                                            levelColors: ["#FF0734", "#FF973D", "#00FF21"],
                                            relativeGaugeSize: true
                                        });

                                        valorConFormato = "";
                                        if (formato.indexOf("$") > -1) {
                                            valorConFormato = formatCurrency(valorActual);
                                        } else if (formato.indexOf("%") > -1) {
                                            valorConFormato = Math.round(valorActual * 100) / 100 + " %"
                                        } else {
                                            valorConFormato = formatCurrency(valorActual);
                                            valorConFormato = valorConFormato.replace("$","");
                                        }

                                        $($($("#tacometro").children()[0]).find("text").children()[1]).html(valorConFormato);
                                        
                                        //Se le da formato a los portlet
                                        $("#datos_generales_indicador,#tacometro_portlet").sortable({
                                                connectWith: ".column"
                                            });
                                        
                                        $("#datos_generales_indicador,#tacometro_portlet").addClass("ui-widget ui-widget-content ui-helper-clearfix ui-corner-all")
                                                    .find(".portlet-header")
                                                    .addClass("ui-widget-header ui-corner-all")
                                                    .prepend("<span class='ui-icon ui-icon-minusthick'></span>")
                                                    .end()
                                                    .find(".portlet-content");                                     
                                        
                                        if (claveFormaDetalle != "") {
                                            $("#chart_desempeno_portlet").remove();
                                            $("#grid_datos").remove();
                                            $("#datos_indicador")
                                                    .parent().parent() 
                                                    .append('<div class="portlet" id="chart_desempeno_portlet" style="width: 47%; float: left; margin-left: 10px;">' +
                                                            '<div class="portlet-header">Desempe&ntilde;o hist&oacute;rico del indicador<div id="chart_desempeno_portlet_d" /></div>' +
                                                            '<div class="portlet-content" id="chart_indicador" style="margin: 5px;">' +
                                                            '<div id="chart_historico"  style="background-color: #FFF; height:250px;" ></div>' +
                                                            '</div>' +
                                                            '</div>' +
                                                            '<div id="grid_datos" style="float:left; margin-left: 10px; width: 450px; height: 180px; "  app="145" form="782" wsParameters="" titulo="" inDesktop="true" openKardex="false"></div>');

                                            $("#chart_desempeno_portlet").sortable({
                                                connectWith: ".column"
                                            });

                                            $("#chart_desempeno_portlet").addClass("ui-widget ui-widget-content ui-helper-clearfix ui-corner-all")
                                                    .find(".portlet-header")
                                                    .addClass("ui-widget-header ui-corner-all")
                                                    .prepend("<span class='ui-icon ui-icon-minusthick'></span>")
                                                    .end()
                                                    .find(".portlet-content");

                                            $(".portlet-header .ui-icon").click(function () {
                                                $(this).toggleClass("ui-icon-minusthick").toggleClass("ui-icon-plusthick");
                                                $(this).parents(".portlet:first").find(".portlet-content").toggle();
                                            });

                                            $(".column").disableSelection();
                                            $("#grid_datos").appgrid({app: "147",
                                                entidad: claveFormaDetalle,
                                                wsParameters: "",
                                                titulo: 'Valores hist\u00f3ricos del indicador <div id="grid_datos_d" />',
                                                inDesktop: "true",
                                                height: "180px",
                                                removeGridTitle: true,
                                                showFilterLink: false,
                                                inQueue: true,
                                                insertInDesktopEnabled: 0,
                                                editingApp: "1",
                                                width: "100%",
                                                tipoConsulta: "timeline",
                                                desactivaBusqueda: true,
                                                desactivaOndblClickRow: true,
                                                onSelectRow: function (rowId, status, e) {
                                                    $("#filtros_indicador").val("fecha='"+$(this).getCell(rowId, 0)+"';");
                                                    presenta_detalle_balanced_scorecard($(this).getCell(rowId, 0));
                                                    $("#grid_datos_detalle").find(".ui-jqgrid-title").text("Detalles del indicador");
                                                }
                                            });

                                            $("#tacometro").append("<p style='text-align:center'>Valor actual: " + valorConFormato + "</p>");
                
                                            //Redimensiona portlets
                                            if ($("#datos_generales_indicador").height()>$("#tacometro_portlet").height()) {
                                                $("#tacometro_portlet").height($("#datos_generales_indicador").height());
                                            } else if ($("#tacometro_portlet").height()>$("#datos_generales_indicador").height()) {
                                                $("#datos_generales_indicador").height($("#tacometro_portlet").height());
                                            }
                                        
                                            $("#chart_historico").html();
                                            timeLineValoresHistoricosIndicador(claveFormaDetalle, "", "", "chart_historico");
                                            $("#grid_datos_detalle").remove();
                                            $("#chart_datos_detalle_portlet").remove();
                                        }
                                        
                                        
                                    }
                                }
                                , error: function (xhr, err) {
                                    if (xhr.responseText.indexOf("Iniciar sesi&oacute;n") > -1) {
                                        alert("Su sesión ha expirado, por seguridad es necesario volverse a registrar");
                                        window.location = 'login.jsp';
                                    }
                                    alert("Error al recuperar indicador");
                                }
                            });

                    $("#divwait").dialog("close");
                    $("#_status_").val("");
                }).bind("move_node.jstree", function (e, data) {
                    nodoPorMover = data.rslt.o[0].id.split("_")[1].split("-")[0];
                    nuevoPadre = data.rslt.np[0].id.split("_")[1].split("-")[0];

                    /*if (data.rslt.np[0].id.indexOf("entidad") > -1) {
                     alert("Operacion no valida");
                     o.refresh();
                     return false;
                     }*/

                    postConfig = "&$cf=775&$ta=update&$pk=" + nodoPorMover + "&$ca=0" +
                            "&clave_indicador_padre=" + nuevoPadre + "&orden=" + data.rslt.cp;
                    $.post("control?$cmd=register" + postConfig, "");
                }).jstree({
                    "core": {
                        "check_callback": function (e, data) {
                            console.log(data)
                        }
                    }, "plugins": aPlugins,
                    "xml_data": {
                        "data": sXML
                    },
                    "themes": {
                        "theme": "default",
                        "dots": true,
                        "icons": true
                    },
                    "types": oTypes,
                    "contextmenu": {
                        "items": function ($node) {
                            return {
                                "Nuevo_indicador": {
                                    "label": "Nuevo indicador",
                                    "action": function (obj) {
                                        //Copia al cache la app que se est? usando al editar

                                        nForma = 775;
                                        //if (obj[0].id.indexOf("sector") == 0) {
                                        nPK = obj[0].id.split("_")[1].split("-")[0];
                                        w = "clave_indicador=" + nPK;
                                        //}

                                        //$("#_cache_").val("sector");

                                        $("#divwait")
                                                .html("<br /><p style='text-align: center'><img src='img/throbber.gif' />&nbsp;Generando forma...</p>")
                                                .attr('title', 'Espere un momento por favor')
                                                .dialog({
                                                    height: 140,
                                                    modal: true,
                                                    autoOpen: true,
                                                    closeOnEscape: false
                                                });

                                        $("body").form({
                                            app: "145",
                                            forma: nForma,
                                            modo: "insert",
                                            columnas: 1,
                                            pk: 0,
                                            filtroForaneo: "2=clave_aplicacion=141&3=" + w,
                                            height: "90%",
                                            width: "80%",
                                            originatingObject: "",
                                            showRelationships: "false",
                                            updateControl: "tvIndicadores",
                                            secondFieldText: "" //Puesto que se trata de un registro nuevo, 
                                        });
                                    }
                                },
                                "Editar": {
                                    "label": "Editar",
                                    "action": function (obj) {
                                        $("#divwait")
                                                .html("<br /><p style='text-align: center'><img src='img/throbber.gif' />&nbsp;Generando forma...</p>")
                                                .attr('title', 'Espere un momento por favor')
                                                .dialog({
                                                    height: 140,
                                                    modal: true,
                                                    autoOpen: true,
                                                    closeOnEscape: false
                                                });

                                        //Copia al cache la app que se est? usando al editar
                                        $("#_cache_").val("145");

                                        nPK = 0;
                                        w = "";
                                        nForma = 775;
                                        nPK = obj[0].id.split("_")[1].split("-")[0];
                                        w = "clave_taxonomia=" + nPK;


                                        $("body").form({
                                            app: "142",
                                            forma: nForma,
                                            modo: "update",
                                            columnas: 1,
                                            pk: nPK,
                                            filtroForaneo: "2=clave_aplicacion=141&3=",
                                            height: "90%",
                                            width: "80%",
                                            originatingObject: "",
                                            showRelationships: "false",
                                            updateControl: "tvIndicadores",
                                            secondFieldText: "" //Puesto que se trata de un registro nuevo, 
                                        });
                                    }
                                }
                            };
                        }
                    }
                });
                $("#divwait").dialog("close");
            },
            error: function (xhr, err) {
                $("#divwait").dialog("close");
                alert("Error al recuperar definición de arbol\nreadyState: " + xhr.readyState + "\nstatus: " + xhr.status);
                alert("responseText: " + xhr.responseText);
            }
        });
    };
})(jQuery);
