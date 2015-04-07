function chartValoresHistoricosIndicador(claveIndicador, titulo, divId) {
            $.getJSON( "chart.jsp?$cf=782&$w=clave_indicador=" + claveIndicador, function( data ) {            
              var plot1 = jQuery.jqplot (divId, [data], 
                { 
                  title: titulo,
                axes:{xaxis:{renderer:$.jqplot.DateAxisRenderer}},
                series:[{lineWidth:4, markerOptions:{style:'square'}}],
                seriesDefaults: {color: '#459e00'}
                }
              );
            }).fail(function( jqxhr, textStatus, error ) {
                var err = textStatus + ", " + error;
                console.log( "Request Failed: " + err );
            });
}

function entregas_por_estado_2() {
var plot2 = $.jqplot('entregas_x_estado', [
        [[2,1], [4,2], [6,3], [3,4]], 
        [[5,1], [1,2], [3,3], [4,4]], 
        [[4,1], [7,2], [1,3], [2,4]]], {
        seriesDefaults: {
            renderer:$.jqplot.BarRenderer,
            // Show point labels to the right ('e'ast) of each bar.
            // edgeTolerance of -15 allows labels flow outside the grid
            // up to 15 pixels.  If they flow out more than that, they 
            // will be hidden.
            pointLabels: { show: true, location: 'e', edgeTolerance: -15 },
            // Rotate the bar shadow as if bar is lit from top right.
            shadowAngle: 135,
            // Here's where we tell the chart it is oriented horizontally.
            rendererOptions: {
                barDirection: 'horizontal'
            }
        },
        axes: {
            yaxis: {
                renderer: $.jqplot.CategoryAxisRenderer
            }
        }
    });
}    