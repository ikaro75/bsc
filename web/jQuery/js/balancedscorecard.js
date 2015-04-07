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