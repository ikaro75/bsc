function compras_init() {
    $("#clave_tipo_documento option[value='1']").remove();
    $("#clave_tipo_documento option[value='2']").remove();
    $("#clave_tipo_documento option[value='3']").remove();
    $("#clave_tipo_documento option[value='4']").remove();
    $("#clave_tipo_documento option[value='5']").remove();
    $("#clave_tipo_documento option[value='7']").remove();
    $("#clave_tipo_documento option[value='8']").remove();
    $("#clave_tipo_documento option[value='9']").remove();
    $("#clave_tipo_documento option[value='10']").remove();
    
    $("#fecha_pago").hide();
    $("#td_fecha_pago").html("");
    $("#td_clave_moneda_enganche").parent().hide();
    $("#td_tipo_cambio_enganche").parent().hide();
    $("#td_numero_pagos").parent().hide();
    $("#td_tipo_cambio_pagos").parent().hide();
    $("#td_dias_plazo").parent().hide();
    $("#td_tasa_interes_pago").parent().hide();
            
    $("#form_31_601_0 #pago_a_plazo").change(function(){
        if ($(this).attr("checked")=="checked")  { // Pago en plazos 
            $("#td_fecha_pago").html("Fecha de pago (a 30 d&iacute;as)");
            $("#fecha_pago").show();
            $("#td_clave_moneda_enganche").parent().show();
            $("#td_tipo_cambio_enganche").parent().show();
            $("#td_numero_pagos").parent().show();
            $("#td_tipo_cambio_pagos").parent().show();
            $("#td_dias_plazo").parent().show();
            $("#td_tasa_interes_pago").parent().show();
            
            $("#fecha_pago").addClass("obligatorio");
            $("#clave_moneda_enganche").addClass("obligatorio");
            $("#tipo_cambio_enganche").addClass("obligatorio");
            $("#importe_enganche").addClass("obligatorio");
            $("#numero_pagos").addClass("obligatorio");
            $("#clave_moneda_pagos").addClass("obligatorio");
            $("#tipo_cambio_pagos").addClass("obligatorio");
            $("#importe_pagos").addClass("obligatorio");
            $("#dias_plazo").addClass("obligatorio");
            $("#fecha_primer_pago").addClass("obligatorio");
            $("#tasa_interes_pago").addClass("obligatorio");
            
            
        } else  {
            $("#td_fecha_pago").html("");
            $("#fecha_pago").hide();
            $("#td_clave_moneda_enganche").parent().hide();
            $("#td_tipo_cambio_enganche").parent().hide();
            $("#td_numero_pagos").parent().hide();
            $("#td_tipo_cambio_pagos").parent().hide();
            $("#td_dias_plazo").parent().hide();
            $("#td_tasa_interes_pago").parent().hide();
            
            $("#fecha_pago").removeClass("obligatorio");
            $("#clave_moneda_enganche").removeClass("obligatorio");
            $("#tipo_cambio_enganche").removeClass("obligatorio");
            $("#importe_enganche").removeClass("obligatorio");
            $("#numero_pagos").removeClass("obligatorio");
            $("#clave_moneda_pagos").removeClass("obligatorio");
            $("#tipo_cambio_pagos").removeClass("obligatorio");
            $("#importe_pagos").removeClass("obligatorio");
            $("#dias_plazo").removeClass("obligatorio");
            $("#fecha_primer_pago").removeClass("obligatorio");
            $("#tasa_interes_pago").removeClass("obligatorio");
        }    
        
    });
}

function compras_detalle_init() {
    $("#cantidad,#importe_unitario,#clave_impuesto").change(function() {
        importe=parseFloat($("#importe_unitario").val().replace(/,/g,"").replace(/\$/g,""));
        porcentaje_iva=parseFloat($("#clave_impuesto option:selected").html().split("%")[0]);
        cantidad=parseFloat($("#cantidad").val());
        importe_iva= cantidad * (parseFloat($("#importe_unitario").val().replace(/,/g,"").replace(/\$/g,"")) * porcentaje_iva /100);

        $("#importe_total").val(formatCurrency(cantidad * importe + importe_iva));
        $("#importe_unitario").val(formatCurrency($("#importe_unitario").val()));
        $("#importe_impuesto").val(formatCurrency(importe_iva));
    });
    
    $("#clave_producto").change(function () {
        $.ajax({
            url: "control?$cmd=plain&$cf=569&$pk=" + $(this).val() + "&$ta=foreign&$w=clave_producto=" + $(this).val(),
            dataType: ($.browser.msie) ? "text" : "xml",
            success: function(data) {
                if (typeof data == "string") {
                    xmlProducto = new ActiveXObject("Microsoft.XMLDOM");
                    xmlProducto.async = false;
                    xmlProducto.validateOnParse = "true";
                    xmlProducto.loadXML(data);

                    if (xmlProducto.parseError.errorCode > 0) {
                        alert("Error de compilación xml:" + xmlProducto.parseError.errorCode + "\nParse reason:" + xmlInsumo.parseError.reason + "\nLinea:" + xmlInsumo.parseError.line);
                    }
                }
                else {
                    xmlProducto = data;
                }

                $("#importe_unitario").val(formatCurrency($(xmlProducto).find("precio").text()));
                $("#clave_unidad option[value=" + $(xmlProducto).find("clave_unidad_entrada").text()+ "]").attr("selected", true);
                $("#clave_impuesto option[value=" + $(xmlProducto).find("clave_impuesto_predeterminado").text().replace("%","")+ "]").attr("selected", true);
                 
            },
            error: function(xhr, err) {
                alert("Error al recuperar los datos del insumo: \n" + +xhr.responseText);
            }
        });
    });    
}