function beneficiario_init() {
    $("#rpu").blur(function() {

        if (!check_number(this)) {
            alert("EL RPU debe contener solo número, verifique");
            $(this).val("");
            return;
        }

        if ($(this).val().length != 12) {
            alert("El RPU no contiene 12 digitos, verifique");
            $(this).val("");
            return;
        }

        $.ajax({
            url: "control?$cmd=validabeneficiario&rpu=" + $(this).val(),
            dataType: ($.browser.msie) ? "text" : "xml",
            type: "POST",
            success: function(data) {
                if (typeof data == "string") {
                    xmlRPU = new ActiveXObject("Microsoft.XMLDOM");
                    xmlRPU.async = false;
                    xmlRPU.validateOnParse = "true";
                    xmlRPU.loadXML(data);

                    if (xmlRPU.parseError.errorCode > 0) {
                        alert("Error de compilación xml:" + xmlRPU.parseError.errorCode + "\nParse reason:" + xmlRPU.parseError.reason + "\nLinea:" + xmlRPU.parseError.line);
                    }
                }
                else {
                    xmlRPU = data;
                }
                
                //Compruba que no venga con errores
                if ($(xmlRPU).find("error").length>0) 
                    alert($(xmlRPU).find("error").text());
                else  {
                    rpu = $(xmlRPU).find("rpu")[0].childNodes[0].data.substring(3, 15);
                    
                    //Validar  el tipo de facturacion
                    $("#tarifa").val($(xmlRPU).find("tipo_facturacion")[0].childNodes[0].data);
                    $("#nombre").val($(xmlRPU).find("nombre_beneficiario")[0].childNodes[0].data);
                    $("#direccion").val($(xmlRPU).find("direccion")[0].childNodes[0].data);
                    
                    //Validar  la zona
                    zona = $(xmlRPU).find("zona")[0].childNodes[0].data; // 01=urbana
                    $("#poblacion").val($(xmlRPU).find("poblacion")[0].childNodes[0].data);
                    $("#clave_municipio option[value='" + $(xmlRPU).find("clave_municipio")[0].childNodes[0].data + "']").attr("selected", "selected");
                    $("#clave_estado option[value='" + $(xmlRPU).find("clave_estado")[0].childNodes[0].data+ "']").attr("selected", "selected");
                    $("#btnGuardar_129_613_0").attr("disabled", "enabled");
                }
                
            },
            error: function(xhr, err) {
                    alert("Error al buscar RPU: \n" + +xhr.responseText);
            }
        })

    });


    //Si el perfil es el de call center deshabilita el botón guardar
    if ($("#_cp_").val() == 4) {
        $("#btnGuardar_129_613_0").attr("disabled", "disabled");
    }
}

function beneficiario_grid_init() {

    $(".startsurvey").click(function() {
        nCuestionario = this.id.split("_")[1];
        nProspecto = this.id.split("_")[2];
        sModo = this.id.split("_")[3];
        if (sModo == 'insert') {
            $("#divwait")
                    .html("<br /><p style='text-align: center'><img src='img/throbber.gif' />&nbsp;Generando cuestionario...</p>")
                    .attr('title', 'Espere un momento por favor')
                    .dialog({
                        height: 140,
                        modal: true,
                        autoOpen: true,
                        closeOnEscape: false
                    });
            //Inserta cuestionario de participante en blanco
            $.ajax({
                url: "control?$cmd=register&$cf=633&$pk=0&$ta=insert&clave_beneficiario=" + nProspecto + "&clave_cuestionario=" + nCuestionario + "&clave_empleado=" + $("#_ce_").val() + "&clave_estatus=1&fecha_inicio=%ahora",
                dataType: ($.browser.msie) ? "text" : "xml",
                success: function(data) {
                    if (typeof data == "string") {
                        xmlCuestionario = new ActiveXObject("Microsoft.XMLDOM");
                        xmlCuestionario.async = false;
                        xmlCuestionario.validateOnParse = "true";
                        xmlCuestionario.loadXML(data);

                        if (xmlCuestionario.parseError.errorCode > 0) {
                            alert("Error de compilación xml:" + xmlCuestionario.parseError.errorCode + "\nParse reason:" + xmlCuestionario.parseError.reason + "\nLinea:" + xmlCuestionario.parseError.line);
                        }
                    }
                    else {
                        xmlCuestionario = data;
                    }

                    nCuestionario = $(xmlCuestionario).find("pk")[0].childNodes[0].data;

                    $("#top").survey({
                        pk: nCuestionario,
                        modo: "open",
                        claveProspecto: nProspecto
                    });

                },
                error: function(xhr, err) {
                    alert("Error al recuperar los datos del cuestionario: \n" + +xhr.responseText);
                }
            })
        } else {
            $("#divwait")
                    .html("<br /><p style='text-align: center'><img src='img/throbber.gif' />&nbsp;Abriendo cuestionario...</p>")
                    .attr('title', 'Espere un momento por favor')
                    .dialog({
                        height: 140,
                        modal: true,
                        autoOpen: true,
                        closeOnEscape: false
                    });

            $("#top").survey({
                pk: nCuestionario,
                modo: sModo,
                claveProspecto: nProspecto
            });
        }
    });

}