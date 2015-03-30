/* 
 * Plugin de jQuery para cargar menÃº de sesiÃ³n a travÃ©s de un plugin
 * 
 */
( function($) {
    $.fn.desktop = function(opc){

        $.fn.desktop.settings = {
            xmlUrl : "control?$cmd=plain&$cf=1&$ta=select&$w=" + escape("clave_empleado=" +$("#_ce_").val()+ " AND parametro like 'escritorio.%'")  //"srvControl?$cmd=form&$cf=1&$ta=select&$w=" + escape("c.clave_empleado=" +$("#_ce_").val()+ " AND c.parametro like 'escritorio.%'")
        };

        // Ponemos la variable de opciones antes de la iteraciÃ³n (each) para ahorrar recursos
        $.fn.desktop.options = $.extend($.fn.desktop.settings, opc);

        // Devuelvo la lista de objetos jQuery
        return this.each( function(){
            obj = $(this);

            $( ".column" ).sortable({
			connectWith: ".column"
            });
            
            $( ".portlet" ).addClass( "ui-widget ui-widget-content ui-helper-clearfix ui-corner-all" )
			.find( ".portlet-header" )
				.addClass( "ui-widget-header ui-corner-all" )
				.prepend( "<span class='ui-icon ui-icon-minusthick'></span>")
				.end()
			.find( ".portlet-content" );

            $( ".portlet-header .ui-icon" ).click(function() {
			$( this ).toggleClass( "ui-icon-minusthick" ).toggleClass( "ui-icon-plusthick" );
			$( this ).parents( ".portlet:first" ).find( ".portlet-content" ).toggle();
            });

            $( ".column" ).disableSelection();
            
            $('#tabUser').tabs({
            tabTemplate: "<li><a href='#{href}'>#{label}</a><span class='ui-icon ui-icon-close'>Cerrar tab</span></li>"
            });
            
            $('#tabUser').tabs( "select", "#tabPendientes" ); 
            $("#tabs").tabs( "select", "#tabAplicaciones" );
                          
             //Activa el carrousel de ayuda de favoritos
             $("#divCarouselMisAplicaciones").agile_carousel({
                carousel_data: [{
                                "content": $("#ayudaComoUsarMisAplicaciones").html(),
                                "content_button": ""
                                }, {
                                "content": $("#ayudaComoAgregarUnRegistro").html(),
                                "content_button": ""
                                }, {
                                "content": $("#ayudaComoEditarUnRegistro").html(),
                                "content_button": ""
                                },{
                                "content": $("#ayudaComoEliminarUnRegistro").html(),
                                "content_button": ""
                                },{
                                "content": $("#ayudaComoFiltrarRegistros").html(),
                                "content_button": ""
                                }
                            ],
                carousel_outer_height: $("#divCarouselMisAplicaciones").height(),
                carousel_height: $("#divCarouselMisAplicaciones").height(),
                slide_height: $("#divCarouselMisAplicaciones").height()+2,
                carousel_outer_width: $("#divCarouselMisAplicaciones").width(),
                slide_width: $("#divCarouselMisAplicaciones").width(), 
                transition_time: 300,
                continuous_scrolling: false,
                number_slides_visible: 1,
                control_set_1: "previous_button,next_button",
                control_set_2: "numbered_buttons"
            });   
            
            //Le da color al splitter
            $(".jqx-splitter-collapse-button-vertical").css("background", "#FC9B05");
            //$("#tabs").tabs( "select", "#tabAyuda" );
            
            //Activa los links de la ayuda
            /*$(".lnkAyuda").click(function() { 
                nSlide=this.id.split("-")[1];
                $($("#divCarouselAyuda").find(".slide_number_"+nSlide)).trigger( $.Event('click') );
            });*/
            
            $("#tvIndicadores").treeMenu({
                            app:1,
                            entidad: 775,
                            pk:0
            });
            
            $("#txtBusqueda").focus(function(){
                if ($(this).val()=="Busque por palabra clave") {
                    $(this).val("");
                }
            }).keyup(function(event) {
                if (event.which ==13) {
                    $("#btnBusqueda").button().click();
                }    
            });
            
            $("#btnBusqueda").button().click(function () {
                if ($("#txtBusqueda").val()=="") {
                    alert("Escriba la palabra clave a buscar");
                }
                
                if ($("#tvSuscriptores").jstree("get_selected").length>0) {
                    $("#tvSuscriptores").jstree("deselect_node", $("#" + $("#tvSuscriptores").jstree("get_selected")[0].id));
                }    
                
                /* kw= "'%"+ $("#txtBusqueda").val() + "%' COLLATE Latin1_General_CI_AI";*/
                kw = "";
                aKw= $("#txtBusqueda").val().split(" ");
                for (i=0;i<aKw.length;i++) {
                   kw+=",'" + aKw[i] + "' COLLATE Latin1_General_CI_AI"
                }
                
                kw = kw.substring(1,kw.length);
                
               /* $("#grid_141_636_0").jqGrid('setGridParam', {
                                    url: "control?$cmd=grid&$cf=636&$ta=select&$dp=body&$w=" + 
                                            escape("nombres collate Latin1_General_CI_AI like " + kw + 
                                            " OR apellido_paterno collate Latin1_General_CI_AI like " + kw + 
                                            " OR apellido_materno collate Latin1_General_CI_AI like " + kw + 
                                            " OR puesto collate Latin1_General_CI_AI like " + kw + 
                                            " OR area collate Latin1_General_CI_AI like " + kw + " OR telefono like " + kw + 
                                            " OR email collate Latin1_General_CI_AI like " + kw + " OR direccion like " + kw + 
                                            " OR colonia collate Latin1_General_CI_AI like " + kw + " OR delegacion like " + kw +
                                            " OR cp collate Latin1_General_CI_AI like " + kw + 
                                            " OR clave_taxonomia IN (SELECT clave_taxonomia FROM fide_taxonomia WHERE taxonomia collate Latin1_General_CI_AI like " + kw + ")"
                                            )
                }).trigger("reloadGrid");*/

                $("#grid_141_636_0").jqGrid('setGridParam', {
                                    url: "control?$cmd=grid&$cf=636&$ta=select&$dp=body&$w=" + 
                                            escape("nombres collate Latin1_General_CI_AI in (" + kw + ")" +
                                            " OR apellido_paterno collate Latin1_General_CI_AI in (" + kw + ")" + 
                                            " OR apellido_materno collate Latin1_General_CI_AI in ( " + kw + ")" + 
                                            " OR puesto collate Latin1_General_CI_AI in (" + kw + ")" + 
                                            " OR area collate Latin1_General_CI_AI in (" + kw + ") " +
                                            " OR telefono collate Latin1_General_CI_AI in (" + kw + ") " +
                                            " OR email collate Latin1_General_CI_AI in (" + kw + ")" +
                                            " OR convert(varchar,direccion) collate Latin1_General_CI_AI in (" + kw + ")" +
                                            " OR colonia collate Latin1_General_CI_AI in (" + kw + ")" +
                                            " OR delegacion collate Latin1_General_CI_AI in (" + kw + ")" +
                                            " OR cp collate Latin1_General_CI_AI in (" + kw + ")" +
                                            " OR clave_taxonomia IN (SELECT clave_taxonomia FROM fide_taxonomia WHERE taxonomia collate Latin1_General_CI_AI IN ( " + kw + "))"
                                            )
                }).trigger("reloadGrid"); 
                
                oGridHeader = $("#grid_141_636_0").parent().parent().parent().find("span.ui-jqgrid-title");
                $(oGridHeader[0]).text("Suscriptores ").append('<a href="#" id="lnkRemoveFilter_grid_141_636">(Quitar filtro [ Palabra clave = ' + $("#txtBusqueda").val() + '])</a>');
                
                $("#lnkRemoveFilter_grid_141_636").click(function () {
                        if ($("#tvSuscriptores").jstree("get_selected").length>0) {
                            $("#tvSuscriptores").jstree("deselect_node", $("#" + $("#tvSuscriptores").jstree("get_selected")[0].id));
                        }
                        
                        $("#grid_141_636_0").jqGrid('setGridParam', {
                                    url: "control?$cmd=grid&$cf=636&$ta=select&$dp=body"
                                }).trigger("reloadGrid");
                                $("#grid_141_636_0").parent().parent().parent().find("span.ui-jqgrid-title").text("Suscriptores ");
                            });
            }); 
            
            //Activa los tooltips de los links con clase tooltipLink
            $(".tooltipLink").tooltip({
                    bodyHandler: function() {
                            return $("<img/>").attr("src", this.id);
                    },
                    showURL: false
            });
            
             $("#tabs").tabs( "select", "#tabInicio" );
            
            $.fn.desktop.ajax(obj);


        });

    };

    $.fn.desktop.ajax = function(obj){
         $.ajax(
            {
            url: $.fn.desktop.options.xmlUrl,
            dataType: ($.browser.msie) ? "text" : "xml",
            success:  function(data){
                 if (typeof data == "string") {
                 xmlConfig = new ActiveXObject("Microsoft.XMLDOM");
                 xmlConfig.async = false;
                 xmlConfig.validateOnParse="true";
                 xmlConfig.loadXML(data);
                 if (xmlConfig.parseError.errorCode>0) {
                        alert("Error de compilaciÃ³n xml:" + xmlConfig.parseError.errorCode +"\nParse reason:" + xmlConfig.parseError.reason + "\nLinea:" + xmlConfig.parseError.line);}
                }
                 else {
                    xmlConfig= data;}

                $.fn.desktop.handleSession(xmlConfig);
                
                //Activa las ligas del mapa de sitio
                $('.maplink').click(function() {
                    aTabsSecuence=this.id.split("-");
                    for (i=1;i<aTabsSecuence.length;i++) {
                        if (i==1)
                            $("#tabs").tabs( "select", "#"+aTabsSecuence[i] );
                        else
                            $("#"+aTabsSecuence[i-1]).tabs( "select", "#"+aTabsSecuence[i] );
                    }
                });
                
                $('.queued_grids:first').gridqueue({height:"500"});
                
            },
            error:function(xhr,err){
                alert("readyState: "+xhr.readyState+"\nstatus: "+xhr.status);
                alert("responseText: "+xhr.responseText);}
            });
    };

    $.fn.desktop.handleSession = function(xml){
        var sFondo="";
        $(xml).find("registro").each(function(){
            //Carga los datos del xml en la variable de configuraciÃ³n
            if ($(this).find("parametro").length>0) {
            sParametro=$(this).find("parametro")[0].firstChild.nodeValue;

            if (sParametro=='escritorio.imagen de fondo') {
               sFondo=$(this).find("valor")[0].firstChild.nodeValue;
               if (sFondo!='')
                   obj.css('background-image', 'url('+sFondo+')');
            }

            if(sParametro==='escritorio.grid') {
                nClave=$(this).find("clave_parametro").text().split("\n")[0]
                sValor=$(this).find("valor").text().split("\n")[0];
                nApp=sValor.split(",")[0].split(":")[1];
                nForm=sValor.split(",")[1].split(":")[1];
                wsParameters=sValor.split(",")[2].split(":")[1];
                titulo=sValor.split(",")[3].split(":")[1];
                leyendas=sValor.split(",")[4].split(":")[1].replace("/",",");
                openKardex=sValor.split(",")[5].split(":")[1];
                inDesktop=sValor.split(",")[6].split(":")[1];
                

                $('#tabMisFavoritos').tabs( "add", "#tabMisFavoritos_"+nClave, titulo);

                $("#tabMisFavoritos_"+nClave).append("<div class='queued_grids'" + 
                                     " id='divDesktopGrid_" + nApp + "_" + nForm + "' " +
                                     " app='" + nApp + "' " + 
                                     " form='" + nForm + "' " +
                                     " wsParameters='" + wsParameters + "' " +
                                     " titulo='" + titulo + "' " + 
                                     " leyendas='" +leyendas+ "' "  + 
                                     " openKardex='" + openKardex + "' " + 
                                     " inDesktop='" + inDesktop + "' " +
                                     " class='queued_grids' " +
                                     " editingApp='1' "+
                                     " insertInDesktopEnabled='0'></div>");
              
              //Agrega el favorito al mapa del sitio
              $("#tabMisFavoritos_in_map").append("<dt><a id='mapLink-tabInicio-tabUser-tabFavoritos-tabMisFavoritos-tabMisFavoritos_"+nClave+ "' class='maplink' href='#'>"+titulo+"</a></dt>");
            }

            if (sParametro=='grid.actualizaDespuesDeOperacion') {
                 sValor=$(this).find("valor").text().split("\n")[0];
                 $("#_gado_").val(sValor);
            }
          }
        });
                
    }
})(jQuery);