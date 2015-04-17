function fw_scorecard_indicador_init() {
    claveTipoIndicador=($(xml).find("registro").find("clave_tipo_indicador")[0].firstChild.data==""?"1":$(xml).find("registro").find("clave_tipo_indicador")[0].firstChild.data);
    claveTipoActualizacion=($(xml).find("registro").find("clave_tipo_indicador")[0].firstChild.data==""?"1":$(xml).find("registro").find("clave_tipo_indicador")[0].firstChild.data);
    
    $("<br><input type='button' value='Valida consulta'  />" )
            .insertAfter("#consulta_actualizacion")
            .button()
            .click(function() {
        $("#divwait").dialog({
            height: 140,
            modal: true,
            autoOpen: true,
            closeOnEscape:false
        });
        
        valor=validateSQLAndReturnValue($("#consulta_actualizacion").val(),$("#clave_origen_dato").val());
        if (valor!=null) {
            $("#valor_actual").val(valor);
        }
        $("#divwait").dialog("close");
    }); 
    
    if (claveTipoActualizacion=="1") {
        $("#td_consulta_actualizacion").parent().show();
        $("#td_clave_origen_dato").parent().show();
    } else {
        $("#td_consulta_actualizacion").parent().hide();
        $("#td_clave_origen_dato").parent().hide();
    }
        
    if (claveTipoIndicador=="1") {
        $("#td_valor_actual").parent().hide();
        $("#td_clave_tipo_actualizacion").parent().hide();
        $("#td_consulta_actualizacion").parent().hide();
        $("#td_porcentaje_peso").parent().hide();
        $("#td_clave_origen_dato").parent().hide();
        $("#td_dias_frecuencia_rastreo").parent().hide();
        //Oculta los tabs de objetivos y propietarios
        $("#lnkFormTab_145_783").parent().hide();
        $("#lnkFormTab_145_776").parent().hide();
    } else {
        $("#td_valor_actual").parent().show();
        $("#td_clave_tipo_actualizacion").parent().show();
        $("#td_consulta_actualizacion").parent().show();
        $("#td_porcentaje_peso").parent().show();
        $("#td_clave_origen_dato").parent().show();
        $("#td_dias_frecuencia_rastreo").parent().show();
        //Muestra los tabs de objetivos y propietarios
        $("#lnkFormTab_145_783").parent().show();
        $("#lnkFormTab_145_776").parent().show();        
    }
    
    $("#clave_tipo_indicador").change(function(){
        if ($(this).val()=="1") {
            $("#td_valor_actual").parent().hide();
            $("#td_clave_tipo_actualizacion").parent().hide();
            $("#td_consulta_actualizacion").parent().hide();
            $("#td_porcentaje_peso").parent().hide();
            $("#td_clave_origen_dato").parent().hide();       
            $("#td_dias_frecuencia_rastreo").parent().hide();
            //Oculta los tabs de objetivos y propietarios
            $("#lnkFormTab_145_783").parent().hide();
            $("#lnkFormTab_145_776").parent().hide();
        } else {
            $("#td_valor_actual").parent().show();
            $("#td_clave_tipo_actualizacion").parent().show();
            $("#td_consulta_actualizacion").parent().show();
            $("#td_porcentaje_peso").parent().show();
            $("#td_clave_origen_dato").parent().show();
            $("#td_dias_frecuencia_rastreo").parent().show();
            //Muestra los tabs de objetivos y propietarios
            $("#lnkFormTab_145_783").parent().show();
            $("#lnkFormTab_145_776").parent().show();               
        }
        
    });
    
    $("#clave_tipo_actualizacion").change(function(){
        if ($(this).val()=="1") {
            $("#td_consulta_actualizacion").parent().show();
            $("#td_clave_origen_dato").parent().show();
        } else {
            $("#td_consulta_actualizacion").parent().hide();
            $("#td_clave_origen_dato").parent().hide();
        }    
    });  
    
}

function fw_scorecard_valor_historico_grid_init() {

}


//1. se requiere una llamada ajax para saber qué forma está asociada
//2. Inyectar html del grid del detalle y del chart
function presenta_detalle_balanced_scorecard(fecha) {
    alert(fecha);
     $.ajax({ url: "control?$cmd=plain&$ta=select&$cf=775&$w=clave_indicador=" +  $("#_cache_").val(),
            dataType: ($.browser.msie) ? "text" : "xml",
            type: "POST",
            success: function(data) {
                  if (typeof data == "string") {
                      xmlDetalles = new ActiveXObject("Microsoft.XMLDOM");
                      xmlDetalles.async = false;
                      xmlDetalles.validateOnParse = "true";
                      xmlDetalles.loadXML(data);

                      if (xmlDetalles.parseError.errorCode > 0) {
                          alert("Error de compilación xml:" + xmlDetalles.parseError.errorCode + "\nParse reason:" + xmlDetalles.parseError.reason + "\nLinea:" + xmlDetalles.parseError.line);
                      }
                  }
                  else {
                      xmlDetalles = data;
                  }

                  claveFormaDetalle=$(xmlDetalles).find("clave_forma_detalle")[0].firstChild.data;
                  
                  if (claveFormaDetalle!="") {
                    $("#grid_datos_detalle").remove();
                    $("#chart_datos_detalle_portlet").remove();
                                        
                    $("#grid_datos").parent()
                    .append('<div id="grid_datos_detalle" style="float:left; clear:left; margin-left: 10px; width: 450px; height: 560px; "  app="145" form="' + claveFormaDetalle + '" wsParameters="" titulo="" inDesktop="true" ></div>' + 
                    '<div id="chart_datos_detalle_portlet" class="portlet" style="float:left; margin-left: 10px; width: 450px; height: 610px;">'+
                    '<div class="portlet-header">Detalles del indicador</div>'+
                    '<div class="portlet-content"  style="margin: 5px;">'+
                        '<div id="chart_datos_detalle" id="chart_datos_detalle" style="background-color: #FFF; height:570px;" ></div>'+
                    '</div>');                      
                    var aMeses = ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"];
                    $("#grid_datos_detalle").appgrid({app: "145",
                            entidad: claveFormaDetalle,
                            valoresReemplazo: "%ano=" + fecha.split("/")[2] +";%mes="+ fecha.split("/")[1],
                            titulo: "Detalles del indicador "+ aMeses[parseInt(fecha.split("/")[1]) - 1] + " "+ fecha.split("/")[2],
                            inDesktop:"true",
                            height:"480px",
                            removeGridTitle:true,
                            showFilterLink:false,
                            inQueue:true,
                            insertInDesktopEnabled:0,
                            editingApp:"1",
                            width:"100%"
                    });
                    
                    barrasIndicadorDetalles(claveFormaDetalle,"%ano=" + fecha.split("/")[2] +";%mes="+ fecha.split("/")[1],"","chart_datos_detalle");
                    
                    $( "#chart_datos_detalle_portlet" ).sortable({
                        connectWith: ".column"
                    });

                    $( "#chart_datos_detalle_portlet" ).addClass( "ui-widget ui-widget-content ui-helper-clearfix ui-corner-all" )
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

                  }

              },
              error: function (xhr, err) {
                  if (xhr.responseText.indexOf("Iniciar sesi&oacute;n") > -1) {
                      alert("Su sesión ha expirado, por seguridad es necesario volverse a registrar");
                      window.location = 'login.jsp';
                  }
                  alert("Error al recuperar responsables del indicador");
              }
          });
                    
    

    //3. Llamar al objeto jqgrid
    //4. Llamar al objeto del chart
}

                  