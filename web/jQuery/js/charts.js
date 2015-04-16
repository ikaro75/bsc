function timeLineValoresHistoricosIndicador(claveFormaDetalle, valorDeReemplazo, titulo, divId) {
            $.getJSON( "chart.jsp?$cf=" + claveFormaDetalle + "&$ta=timeline&$vr="+encodeURIComponent(valorDeReemplazo)+"&$ts=1", function( data ) {            
              /*var plot1 = jQuery.jqplot (divId, [data], 
                { 
                  title: titulo,
                axes:{xaxis:{renderer:$.jqplot.DateAxisRenderer}},
                series:[{lineWidth:4, markerOptions:{style:'square'}}],
                seriesDefaults: {color: '#459e00'}
                }
              );*/

              var plot1 = $.jqplot(divId, [data], {
              title:titulo,
              axes:{
              xaxis:{
                renderer:$.jqplot.DateAxisRenderer
              },
              yaxis:{
                tickOptions:{
                  formatString:'%.2f%'
                  }
              }
                },
                highlighter: {
                show: true,
                sizeAdjust: 7.5
                },
                cursor: {
              show: false
                }});

            }).fail(function( jqxhr, textStatus, error ) {
                var err = textStatus + ", " + error;
                console.log( "Request Failed: " + err );
            });
}

function barrasIndicadorDetalles(claveFormaDetalle, valorDeReemplazo, titulo, divId) {
    $.getJSON( "chart.jsp?$cf=" + claveFormaDetalle + "&$ta=select&$vr="+encodeURIComponent(valorDeReemplazo)+"&$ts=2", function(data) {
            
            //El primer valor son las etiquetas, el segundo los valores de las barras
             for (var i=0, len=data.length; i < len; i++) {
               console.log(data[i]);
            }
            
            var barra = $.jqplot(divId, [data[1]], {
            title: titulo, 
            seriesDefaults: {
                renderer: $.jqplot.BarRenderer,
                rendererOptions: {barDirection: 'horizontal'}
            },
            series:[
             {pointLabels:{show: true,labels:data[0]},
              shadowAngle: 135
              }],
            axes: {
              xaxis:{renderer:$.jqplot.CategoryAxisRenderer},
              yaxis:{padMax:1.3}
            }
            });

            }).fail(function( jqxhr, textStatus, error ) {
                var err = textStatus + ", " + error;
                console.log( "Request Failed: " + err );
            });
            
}