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
            $("#refresh_tree_button").click(function() {
               $.fn.treeMenu.getTreeDefinition ($("#tvIndicadores")); 
            });
            
            $("#add_node_tree_button").click(function() {
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
                    if ($('#tvIndicadores').jstree('get_selected').length>0) {
                        nPK =$('#tvIndicadores').jstree('get_selected').attr('id').split("_")[1].split("-")[0];
                        w = "clave_indicador=" + nPK;
                    }    
                    
                    $("body").form({
                        app: "145",
                        forma: 775,
                        modo: "insert",
                        columnas: 1,
                        pk: 0,
                        filtroForaneo: "2=clave_aplicacion=141&3="+w,
                        height: "90%",
                        width: "80%",
                        originatingObject: "",
                        showRelationships: "false",
                        updateControl: "tvIndicadores",
                        secondFieldText: "" //Puesto que se trata de un registro nuevo, 
                    });                
            });
            
            $("#edit_node_tree_button").click(function() {
                $("#divwait")
                    .html("<br /><p style='text-align: center'><img src='img/throbber.gif' />&nbsp;Generando forma...</p>")
                    .attr('title', 'Espere un momento por favor')
                    .dialog({
                        height: 140,
                        modal: true,
                        autoOpen: true,
                        closeOnEscape: false
                });
                    
                if ($('#tvIndicadores').jstree('get_selected').length==0) {
                    alert("Seleccione el nodo del \u00e1rbol que desea editar");
                    return;
                } else {
                    nPK =$('#tvIndicadores').jstree('get_selected').attr('id').split("_")[1].split("-")[0];
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
            
            $("#delete_node_tree_button").click(function() {
                if ($('#tvIndicadores').jstree('get_selected').length==0) {
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
            
            $("#expand_tree_button").click(function() {
                 $("#tvIndicadores").jstree('open_all');
            });
            
            $("#collapse_tree_button").click(function() {
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
                            nClaveNodo = $.trim($(this).find('clave_nodo').text().replace('\n', '')) + "-" + sDateStamp;
                            sRel = $.trim($(this).find('rel').text().replace('\n', ''));
                            sTextoNodo = $.trim($(this).find('texto_nodo').text().replace('\n', '')).replace("&aacute;", "á").replace("&eacute;", "é").replace("&iacute;", "í").replace("&oacute;", "ó").replace("&uacute;", "ú").replace("&Aacute;", "Á").replace("&Eacute;", "É").replace("&Iacute;", "Í").replace("&Oacute;", "Ó").replace("&Uacute;", "Ú");
                            nClaveNodoPadre = $.trim($(this).find('clave_nodo_padre').text().replace('\n', '')) + "-" + sDateStamp;
                            //sState=$.trim($(this).find('state').text().replace('\n',''));
                            sState = nClaveNodoPadre.split("-")[0] != "" ? "closed" : "open";
                            sEvento = $.trim($(this).find('onclick').text().replace('\n', ''));
                            nRefrescaArbol = $.trim($(this).find('refresca_arbol').text().replace('\n', ''));
                            sXML += "<item id='" + nClaveNodo + "' parent_id='" + nClaveNodoPadre + "' rel='" + sRel + "' state='" + sState + "' evento='" + sEvento + "' refresca_arbol='" + nRefrescaArbol + "'><content><name><![CDATA[" + sTextoNodo + "]]></name></content></item>";
                        });
                        
                        var responsables="";
                        sXML = "<root>" + sXML + "</root>";
                        aPlugins = "themes,contextmenu,xml_data,types,ui,dnd".split(",");
                        sTypes = "{" + sTypes.substring(0, sTypes.length - 1) + "}";
                        oTypes.types = $.parseJSON(sTypes);

                        $(o).bind("loaded.jstree", function () {
                            $("#divwait").dialog("close");
                        }).bind("select_node.jstree", function (event, data) {  
                            //`data.rslt.obj` is the jquery extended node that was clicked          
                            var oTheNode = data.rslt.obj;
                            var sNodeId = data.rslt.obj.attr("id");
                            var sTitulo = $.trim(data.rslt.obj.children("a").text());
                            var sFiltro = $(oTheNode).attr("evento");
                            var nApp = sNodeId.split("-")[1];
                            var nForma = sNodeId.split("-")[2];
                            var nRefrescaArbol = $(oTheNode).attr("refresca_arbol");
                            var sW = "";
                            
                            var claveIndicador=$('#tvIndicadores').jstree('get_selected').attr('id').split("_")[1].split("-")[0];
                            
                            $.ajax(
                                { url: "control?$cmd=plain&$ta=select&$cf=775&$pk=" + claveIndicador + "&$w=clave_indicador=" +  claveIndicador,
                                  dataType: ($.browser.msie) ? "text" : "xml",
                                  type: "POST",
                                  success: function(data) {
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
                                      var descripcionIndicador= $(xmlIndicador).find("descripcion")[0].childNodes[0].data       
                                      var valorActual= $(xmlIndicador).find("valor_actual")[0].childNodes[0].data  
                                      
                                      //Extrae nombres de los responsables
                                      $.ajax({ url: "control?$cmd=plain&$ta=select&$cf=776&$w=clave_indicador=" + claveIndicador,
                                          dataType: ($.browser.msie) ? "text" : "xml",
                                          type: "POST",
                                          success: function(data) {
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
                                                $("#datos_indicador").html("<h2>" + indicador +"</h2>"
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
                                            label:  indicador,
                                            levelColors:["#FF0734","#FF973D","#00FF21"]
                                        });
                                        
                                        $("#grid_datos").appgrid({app: "145",
                                                entidad: "782",
                                                wsParameters: "clave_indicador=" + claveIndicador,
                                                titulo: "Valores históricos del indicador",
                                                inDesktop:"true",
                                                height:"180px",
                                                removeGridTitle:true,
                                                showFilterLink:false,
                                                inQueue:true,
                                                insertInDesktopEnabled:0,
                                                editingApp:"1",
                                                width:"100%"
                                        });
                                        
                                        $("#tacometro").append("<p style='text-align:center'>Valor actual: " + valorActual+ "</p>");
                                        $("#chart_historico").html();
                                        chartValoresHistoricosIndicador(claveIndicador, "", "chart_historico");
                                    },
                                   error: function (xhr, err) {
                                        if (xhr.responseText.indexOf("Iniciar sesi&oacute;n") > -1) {
                                            alert("Su sesión ha expirado, por seguridad es necesario volverse a registrar");
                                            window.location = 'login.jsp';
                                        }
                                        alert("Error al recuperar indicador");
                                    }
                                });
                            
                            
                            //Recorre los nodos padres
                            /*nodoPadre = data.inst._get_parent(data.rslt.obj);
                            while (nodoPadre!=-1) {
                                sTitulo = $.trim(nodoPadre.children("a").text()) + "\\" + sTitulo;
                                nodoPadre = data.inst._get_parent(nodoPadre);
                            } */               

                            //Llama grids
                            oGridHeader = $("#grid_141_636_0").parent().parent().parent().find("span.ui-jqgrid-title");
                            sTitulo = (sNodeId.indexOf('sector') == 0 ? 'Sector=' : 'Organismo=') + sTitulo;
                            $(oGridHeader[0]).text("Suscriptores ").append('<a href="#" id="lnkRemoveFilter_grid_141_636">(Quitar filtro [' + sTitulo + '])</a>');

                            $("#lnkRemoveFilter_grid_141_636").click(function () {
                                $("#tvIndicadores").jstree("deselect_node", $("#" + $("#tvIndicadores").jstree("get_selected")[0].id));
                                $("#grid_141_636_0").jqGrid('setGridParam', {
                                    url: "control?$cmd=grid&$cf=636&$ta=select&$dp=body"
                                }).trigger("reloadGrid");
                                $("#grid_141_636_0").parent().parent().parent().find("span.ui-jqgrid-title").text("Inidcadores ");
                            });

                            /*panels = $('#jqxSplitter').jqxSplitter('panels');
                            panels[0].collapsible = true;
                            panels[1].collapsible = false;
                            $('#jqxSplitter').jqxSplitter('collapse');*/

                            $("#grid_141_636_0").setGridParam(
                                    {url: "control?$cmd=grid&$cf=636&$ta=select&$dp=body&$w=" + sFiltro})
                                    .trigger("reloadGrid");//Reload grid trigger*/

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
                                        "&clave_indicador_padre=" + nuevoPadre + "&orden="+data.rslt.cp;
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
                                                w = "clave_indicador_padre=" + nPK;
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
                                                    updateControl: obj[0].id,
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
                                                    updateControl: obj[0].id,
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
