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
var jsonConfig= {gridTimers: []};
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
   
    
    var pageguide= tl.pg.init();
    $(".tlypageguide_ignore").hide();
    
    $("#tabs").tabs({select: function(event, ui){
        pageguide.close();
    }});
    
    //$("span.tlypageguide_toggletitle").html("<a href='guia_rapida.pdf' target='_blank' style='top: 1px;margin-left: 5px; color:#fff'>Conozca la gu&iacute;a r&aacute;pida</a>");
    
    //Crea menú de aplicaciones de acuerdo al perfil
    $(".appmenu").appmenu();
    $('#jqxSplitter')
            .jqxSplitter({ width: '100%', height: '95%', panels: [{ size: '30%' }, { size: '70%' }] })
            .on('resize', function (event) { var panels = event.args.panels;
                                            $("#grid_141_636_0").setGridWidth($("#grid_141_636_0").parent().parent().parent().parent().parent().width()); 
            }); 
                                                
    $("#sessionMenu").sessionmenu();
    
    $(window).resize(function() {
        $("#txtBusqueda").width($("#divBusqueda").width()- 30 - $("#btnBusqueda").width() -20);
    });

                
}); //close $(