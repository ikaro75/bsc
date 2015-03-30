/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function fw_viatico_solicitud_init(){
  
  $("#personal").change(function() {   
       //Llena la información del usuario solicitante 
        if ($(this).val()!="") {
            //Filtra los usuarios por el número de empleado 
            $.ajax({
            url: "control?$cmd=plain&$cf=6&$ta=select&$w=Personal='"+$("#personal").val()+"'",
            dataType: ($.browser.msie) ? "text" : "xml",
            type: "POST",
            success: function(data) {
                if (typeof data == "string") {
                    xmlViatico = new ActiveXObject("Microsoft.XMLDOM");
                    xmlViatico.async = false;
                    xmlViatico.validateOnParse = "true";
                    xmlViatico.loadXML(data);

                    if (xmlViatico.parseError.errorCode > 0) {
                        alert("Error de compilación xml:" + xmlViatico.parseError.errorCode + "\nParse reason:" + xmlViatico.parseError.reason + "\nLinea:" + xmlViatico.parseError.line);
                    }
                }
                else {
                    xmlViatico = data;
                }
                
                $("#_status_").val("");
                //Compruba que no venga con errores
                if ($(xmlViatico).find("error").length>0) {
                    alert($(xmlViatico).find("error").text());
                } else  {
                   nombre=$(xmlViatico).find("nombre")[0].childNodes[0].data;
                   apellidopaterno=$(xmlViatico).find("apellidopaterno")[0].childNodes[0].data;
                   apellidomaterno=$(xmlViatico).find("apellidomaterno")[0].childNodes[0].data;
                   departamento=$(xmlViatico).find("departamento")[0].childNodes[0].data;
                   uen=$(xmlViatico).find("uen")[0].childNodes[0].data;
                    $("#nombre").val(nombre+" "+apellidopaterno+" "+apellidomaterno);
                    $("#area").val(departamento);
                    $("#uen").val(uen);
                    //$("#divwait").dialog("close");
                }
                
            },
            error: function(xhr, err) {
                    alert("Error al buscar fecha de entrega: \n" + +xhr.responseText);
            }
        });            
        }
    }); 
}