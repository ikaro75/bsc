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
var plot1;
var plot2;
var jsonConfig= {gridTimers: []};
var pageguide;
$(document).ready(function() {

    //Despliega dialogo modal para evitar acciones del usuario mientras se cargan primeros grids
    //puesto que causa conflictos
    $("#_status_").val("Inicializando");
    $("#divwait").dialog({
            height: 140,
            modal: true,
            autoOpen: true,
            closeOnEscape:false
    });
        
    /*$('#switcher').themeswitcher({
    			imgpath: "images/"
    		}); */
   
    
    pageguide= tl.pg.init();
    $(".tlypageguide_ignore").hide();
    
    $("#tabs").tabs({select: function(event, ui){
        pageguide.close();
    }});
    
    //$("span.tlypageguide_toggletitle").html("<a href='guia_rapida.pdf' target='_blank' style='top: 1px;margin-left: 5px; color:#fff'>Conozca la gu&iacute;a r&aacute;pida</a>");
    
    //Crea menú de aplicaciones de acuerdo al perfil
    $(".appmenu").appmenu();
    $('#jqxSplitter')
            .jqxSplitter({ width: '100%', height: '95%', panels: [{ size: '30%' }, { size: '70%' }] })
            .on('resize', function (event) { 
                var panels = event.args.panels;
                if ($("#grid_1_101_0").length>0) {
                    $("#grid_1_101_0").setGridWidth($("#grid_1_101_0").parent().parent().parent().parent().parent().width()); 
                } else {
                    if ($("#datos_generales_indicador").height()>$("#tacometro_portlet").height()) {
                        $("#tacometro_portlet").height($("#datos_generales_indicador").height());
                    } else if ($("#tacometro_portlet").height()>$("#datos_generales_indicador").height()) {
                        $("#datos_generales_indicador").height($("#tacometro_portlet").height());
                    }
                    //$("#datos_indicador").width($("#frontweb").width()/2-20);
                    //$("#tacometro_portlet").width($("#frontweb").width()/2-20);
                    if ($("#grid_datos").length>0) {
                        $($("#grid_datos").find("table")[3]).setGridWidth($("#tacometro_portlet").width());
                    }
                    
                    if ($("#grid_datos_detalle").length>0) {
                        $("#grid_datos_detalle").width($("#chart_desempeno_portlet").width()+20);
                        $($("#grid_datos_detalle").find("table")[3]).setGridWidth($("#chart_desempeno_portlet").width());
                    }
                    
                    if ($("#chart_datos_detalle_portlet").length>0) {
                        $("#chart_datos_detalle_portlet").width($("#tacometro_portlet").width());
                    }
                    
                    if ($("#tacometro").length>0) {
                        valorConFormato=$("#tacometro")[0].outerText.split("\n")[0];
                        indicador=$("#tacometro")[0].outerText.split("\n")[1];
                        valorActual=valorConFormato.replace("$","").replace("%","").replace(",","");
                        //Destruye contenido de tacometro;
                        alturaTacometro=$("#tacometro").height();
                        $("#tacometro").html("").height(alturaTacometro);
                        
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
                        $($($("#tacometro").children()[0]).find("text").children()[1]).html(valorConFormato);
                        
                        if ($("#datos_generales_indicador").height()>$("#tacometro_portlet").height()) {
                            $("#tacometro_portlet").height($("#datos_generales_indicador").height());
                        } else if ($("#tacometro_portlet").height()>$("#datos_generales_indicador").height()) {
                            $("#datos_generales_indicador").height($("#tacometro_portlet").height());
                        }
                        
                        if (plot1!=undefined) plot1.replot( { resetAxes: true } );
                        if (plot2!=undefined) plot2.replot( { resetAxes: true } );
                        
                    }
                }
                
            }); 
                                                
    $("#sessionMenu").sessionmenu();
    
    $(window).resize(function() {
        $("#txtBusqueda").width($("#divBusqueda").width()- 30 - $("#btnBusqueda").width() -20);
    });

                
}); //close $(