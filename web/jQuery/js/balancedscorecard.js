function fw_scorecard_indicador_init() {
    
    claveTipoIndicador = $(xml).find("registro").find("clave_tipo_indicador")[0].firstChild.data;
    
    if (claveTipoIndicador=="1") {
        $("#td_valor_actual").hide();
        $("#td_clave_tipo_actualizacion").hide();
        $("#td_clave_tipo_actualizacion").hide();
        $("#td_consulta_actualizacion").hide();
        $("#td_porcentaje_peso").hide();
        $("#td_clave_origen_dato").hide();
        $("#td_clave_origen_dato").hide();        
    } else {
        $("#td_valor_actual").show();
        $("#td_clave_tipo_actualizacion").show();
        $("#td_clave_tipo_actualizacion").show();
        $("#td_consulta_actualizacion").show();
        $("#td_porcentaje_peso").show();
        $("#td_clave_origen_dato").show();
        $("#td_clave_origen_dato").show();                
    }
    
    $("#clave_tipo_indicador").change(function(){
    if (claveTipoIndicador=="1") {
        $("#td_valor_actual").hide();
        $("#td_clave_tipo_actualizacion").hide();
        $("#td_clave_tipo_actualizacion").hide();
        $("#td_consulta_actualizacion").hide();
        $("#td_porcentaje_peso").hide();
        $("#td_clave_origen_dato").hide();
        $("#td_clave_origen_dato").hide();        
    } else {
        $("#td_valor_actual").show();
        $("#td_clave_tipo_actualizacion").show();
        $("#td_clave_tipo_actualizacion").show();
        $("#td_consulta_actualizacion").show();
        $("#td_porcentaje_peso").show();
        $("#td_clave_origen_dato").show();
        $("#td_clave_origen_dato").show();                
    }
        
        
    });
    
    
}