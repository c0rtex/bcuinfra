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

<script type="text/javascript">
	var selected_zip, selected_state, clicked_state_name, offices;
	var data = Highcharts.geojson(Highcharts.maps['countries/us/us-all']),
	states_array = Highcharts.geojson(Highcharts.maps['countries/us/us-all']),
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
    	borderColor : '#fff',
    	point : {
	    	events : {
	    		click : function(e){
	    			
	    			cleanInfoBox();
	    			if(typeof(event.point) !== 'undefined')
	    				clicked_state_name = e.point.name;
	    			
	    			getSelectedState(clicked_state_name);
	    			
	    			setTimeout(function(){
	    				
	    				
	    				
	    			},800);
	    			
	    		}
	    	}
	    }
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
	drawOffices();
}
function drawOffices(){
	cleanInfoBox();
	var html = '';
	if(typeof(offices) !== 'undefined' && offices.length > 0){
		for(i = 0; i < offices.length; i++){
			html += offices[i].print_name + '<br/><br/>';	
		}
		
	}else{
		html = 'No offices were found in your chosen county or zipcode';
	}
	$('body #map-locator').fadeIn();
	$('.offices-info').html(html);

}
function cleanInfoBox(){
	$('body #map-locator').fadeOut();
	$('.offices-info').empty();
}
function removePlottedElements(){
	$('body #highmap-container').css('width','100%');
	$('body .highcharts-container, body .highcharts-container svg').css('width','100%');
	$('body #map-locator').fadeOut();
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
                        			click : function(e){
                        				cleanInfoBox();
                        				clicked_county = e.point.name;
	    								getSelectedCounty(clicked_state_name, clicked_county);
                        			}
                        		}
                        	}

                        	
                        });
                    });
                }
            }

            function getStateOnSeriesData( code ){
            	// var data_array = mapChart.series[0].data;
            	var index = 0;
            	

            	for(i = 0; i < states_array.length; i++){
            		if(states_array[i].properties['hc-a2'] == code.toUpperCase() ){
            			
            			index = i;
            			break;
            		}
            	}
            	return index;
            }

            function getSelectedState(state){
            	$.get('https://maps.googleapis.com/maps/api/geocode/json?address='+state+'&sensor=true',function(response){
            		selected_state = response.results;
            		getSelectedStateZip(selected_state[0].geometry.location.lat,selected_state[0].geometry.location.lng);
            	},'json');
            }
            function getSelectedCounty(state,county){
            	$.get('https://maps.googleapis.com/maps/api/geocode/json?address='+state+'+'+county+'&sensor=true',function(response){
            		selected_state = response.results;
            		getSelectedStateZip(selected_state[0].geometry.location.lat,selected_state[0].geometry.location.lng);
            	},'json');
            }
            function getSelectedStateZip(lat,long){
				 $.get('https://maps.googleapis.com/maps/api/geocode/json?sensor=false&latlng='+lat+','+long,function(response){
					var address_array = response.results[0].address_components;
					for( i = 0; i < address_array.length; i++ ){
						if(address_array[i].types[0] == 'postal_code'){
							selected_zip = address_array[i].long_name;
							
							break;
						}
					}
					drawOfficesByZip(selected_zip);
				},'json');
				
            }

            function drawOfficesByZip(zipcode){

            	$.get(window.webServiceUrl + '/rest/backend/entryPoints/forProgram/medicaid_ny_medicaid?zipcode='+zipcode,function(response){
            		offices = response;
            		plotElements();
            	},'json');
            }
        </script>