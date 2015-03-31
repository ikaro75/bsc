function fw_scorecard_indicador_init() {
    
    claveTipoIndicador = $(xml).find("registro").find("clave_tipo_indicador")[0].firstChild.data;
    claveTipoIndicador=(claveTipoIndicador==""?"1":"2");
    claveTipoActualizacion = $(xml).find("registro").find("clave_tipo_indicador")[0].firstChild.data;
    claveTipoActualizacion=(claveTipoActualizacion==""?"1":"2");
    
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
    } else {
        $("#td_valor_actual").parent().show();
        $("#td_clave_tipo_actualizacion").parent().show();
        $("#td_consulta_actualizacion").parent().show();
        $("#td_porcentaje_peso").parent().show();
        $("#td_clave_origen_dato").parent().show();
        $("#td_dias_frecuencia_rastreo").parent().show();
    }
    
    $("#clave_tipo_indicador").change(function(){
        if ($(this).val()=="1") {
            $("#td_valor_actual").parent().hide();
            $("#td_clave_tipo_actualizacion").parent().hide();
            $("#td_consulta_actualizacion").parent().hide();
            $("#td_porcentaje_peso").parent().hide();
            $("#td_clave_origen_dato").parent().hide();       
            $("#td_dias_frecuencia_rastreo").parent().hide();
        } else {
            $("#td_valor_actual").parent().show();
            $("#td_clave_tipo_actualizacion").parent().show();
            $("#td_consulta_actualizacion").parent().show();
            $("#td_porcentaje_peso").parent().show();
            $("#td_clave_origen_dato").parent().show();
            $("#td_dias_frecuencia_rastreo").parent().show();
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