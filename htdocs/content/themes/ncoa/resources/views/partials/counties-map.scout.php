<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://code.highcharts.com/maps/highmaps.js"></script>
<script src="https://code.highcharts.com/maps/modules/data.js"></script>
<script src="https://code.highcharts.com/maps/modules/drilldown.js"></script>
<script src="https://code.highcharts.com/mapdata/countries/us/us-all.js"></script>

<link href="https://netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">

<style>
g.highcharts-label text{
	color: #fff !important;
	fill: #fff !important;
	stroke:none;
}
g.highcharts-label tspan{
	stroke:none;
}
</style>
<div id="highmap-container" style="height:900px;float:left;width:100%"></div>
<div id="map-locator" style="float:right;width:22%; padding:1.5%;display: none">
	
	<h3>Medicaid Office(s):</h3>

	<div class="offices-info">
		
	</div>
</div>

<script>
	
	var data = Highcharts.geojson(Highcharts.maps['countries/us/us-all']),
    // Some responsiveness
    small = $('#highmap-container').width() < 400;

// Set drilldown pointers
$.each(data, function (i) {
	this.drilldown = this.properties['hc-key'];
    this.value = i; // Non-random bogus data
});

// Instanciate the map
mapChart = Highcharts.mapChart('highmap-container', {
	chart: {
		events: {
			drilldown: function (e) {
				drillDownPlot(e);
				this.setTitle(null, { text: e.point.name });
			},
			drillup: function () {
				removePlottedElements();
				this.setTitle(null, { text: 'USA' });
			}
		}
	},

	title: {
		text: ' '
	},

	subtitle: {
		text: ' ',
    	// floating: true,
    	align: 'left',
    	y: 50,
    	style: {
    		fontSize: '16px'
    	}
    },

    legend: {
    	enabled: false
    },
    // colorAxis: {
    // 	min: 0,
    // 	minColor: '#ff0000',
    // 	maxColor: '#ff0000'
    // },

    mapNavigation: {
    	enabled: false,
    	buttonOptions: {
    		verticalAlign: 'bottom'
    	}
    },

    plotOptions: {
    	map: {
    		states: {
    			hover: {
    				color: '#1F3D7D'
    			}
    		}
    	}
    },
    labels : {
    	style : {
    		color: '#fff'
    	}
    },
    series: [{
    	data: data,
    	name: 'Usa',
    	dataLabels: {
    		enabled: true,
    		format: '{point.properties.postal-code}'
    	},
    	borderColor : '#fff'
    }],

    drilldown: {
    	activeDataLabelStyle: {
    		color: '#FFFFFF',
    		textDecoration: 'none',
    		fontSize: '16px',
    		textOutline: '1px #000',
    		borderColor: '#fff'
    	},
    	drillUpButton: {
    		relativeTo: 'spacingBox',
    		position: {
    			x: 0,
    			y: 60
    		}
    	}
    },
    tooltip:{
    	enabled: false
    }
});

function plotElements(){
	$('body #highmap-container').css('width','70%');
	$('body .highcharts-container, body .highcharts-container svg').css('width','100%');
	$('body #map-locator').fadeIn();
	drawOffices();
}
function drawOffices(){
	$('.offices-info').empty();
	var html = '';
	if(typeof(offices) !== 'undefined'){
		for(i = 0; i < offices.length; i++){
			html += offices[i].print_name + '<br/><br/>';	
		}
		
	}else{
		html = 'Department of Workforce Services<br/>5735 South Redwood Road<br/>Taylorsville, UT 84123<br/>Toll-Free: (866) 435-7414<br/>View Google Map<br/>';
	}
	$('.offices-info').html(html);

}
function removePlottedElements(){
	$('body #highmap-container').css('width','100%');
	$('body .highcharts-container, body .highcharts-container svg').css('width','100%');
	$('nody #map-locator').fadeOut();
}

function drillDownPlot(e){
	if (!e.seriesOptions) {
		var chart = mapChart,
		mapKey = 'countries/us/' + e.point.drilldown + '-all',
                        // Handle error, the timeout is cleared on success
                        fail = setTimeout(function () {
                        	if (!Highcharts.maps[mapKey]) {
                        		chart.showLoading('<i class="icon-frown"></i> Failed loading ' + e.point.name);

                        		fail = setTimeout(function () {
                        			chart.hideLoading();
                        		}, 1000);
                        	}
                        }, 3000);

                    // Show the spinner
                    chart.showLoading('<i class="icon-spinner icon-spin icon-3x"></i>'); // Font Awesome spinner

                    // Load the drilldown map
                    $.getScript('https://code.highcharts.com/mapdata/' + mapKey + '.js', function () {

                    	data = Highcharts.geojson(Highcharts.maps[mapKey]);

                        // Set a non-random bogus value
                        $.each(data, function (i) {
                        	this.value = i;
                        });

                        // Hide loading and add series
                        chart.hideLoading();
                        clearTimeout(fail);
                        chart.addSeriesAsDrilldown(e.point, {
                        	name: e.point.name,
                        	data: data,
                        	dataLabels: {
                        		enabled: true,
                        		format: '{point.name}'
                        	},
                        	borderColor : '#fff',
                        	drilldown: {
                        		activeDataLabelStyle: {
                        			color: '#FFFFFF',
                        			textDecoration: 'none',
                        			fontSize: '20px',
                        			textOutline: '1px #000',
                        			borderColor: '#fff'
                        		}
                        	},
                        	point : {
                        		events :{
                        			click : plotElements
                        		}
                        	}

                        	
                        });
                    });
                }
            }

function getStateOnSeriesData( code ){
	var data_array = mapChart.series[0].data;
	var index = 0;
	for(i = 0; i < data_array.length; i++){
		if(data_array[i].properties['hc-a2'] == code.toUpperCase() ){
			console.log("alejo",data_array[i].name);
			index = i;
			break;
		}
	}
	return index;
}
        </script>