function punto_entregas_grid_init() {

    $(".startsurvey").click(function() {
        nCuestionario=this.id.split("_")[1];
        nProspecto=this.id.split("_")[2];
        sModo = this.id.split("_")[3];
        
        if (sModo=='insert') {
            $("#divwait")
            .html("<br /><p style='text-align: center'><img src='img/throbber.gif' />&nbsp;Generando cuestionario...</p>")
            .attr('title','Espere un momento por favor') 
            .dialog({
                height: 140,
                modal: true,
                autoOpen: true,
                closeOnEscape:false
            });
            //Inserta cuestionario de participante en blanco
            $.ajax({
            url: "control?$cmd=register&$cf=633&$pk=0&$ta=insert&clave_punto="+nProspecto+"&clave_cuestionario="+nCuestionario+"&clave_empleado="+$("#_ce_").val() + "&clave_estatus=1&fecha_inicio=%ahora",
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
            .attr('title','Espere un momento por favor') 
            .dialog({
                height: 140,
                modal: true,
                autoOpen: true,
                closeOnEscape:false
            });
            
            $("#top").survey({
                pk: nCuestionario,
                modo: sModo,
                claveProspecto: nProspecto
            });
        }
    });
    
}