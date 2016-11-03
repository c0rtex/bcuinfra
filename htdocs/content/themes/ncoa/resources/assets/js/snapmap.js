// Array used to identify the # of a map based on the state
var map_ids = {'AL': 1, 'AK': 2, 'AZ': 3, 'AR': 4, 'CA': 5, 'CO': 6, 'CT': 7, 'DE': 8, 'FL': 9, 'GA': 10, 'HI': 11,
    'ID': 12, 'IL': 13, 'IN': 14, 'IA': 15, 'KS': 16, 'KY': 17, 'LA': 18, 'ME': 19, 'MD': 20, 'MA': 21, 'MI': 22,
    'MN': 23, 'MS': 24, 'MO': 25, 'MT': 26, 'NE': 27, 'NV': 28, 'NH': 29, 'NJ': 30, 'NM': 31, 'NY': 32, 'NC': 33,
    'ND': 34, 'OH': 35, 'OK': 36, 'OR': 37, 'PA': 38, 'RI': 39, 'SC': 40, 'SD': 41, 'TN': 42, 'TX': 43, 'UT': 44,
    'VT': 45, 'VA': 46, 'WA': 47, 'WV': 48, 'WI': 49, 'WY': 50, 'PR': 51, 'GU': 52, 'VI': 53
};

var map_config = {
    'default':{
        'borderColor':'#ffffff', //inter-state borders
        'lakesColor':'#ffffff', // lakes color
        'namesColor':'#ffffff', //color of short names
        'mapShadow':'#1F3D7D', //shadow color below the map
        'shadowOpacity':'50', //shadow opacity, value, 0-100
        'hoverShadow':'#1F3D7D', //tooltip shadow color
    },
    'map_1':{
        'state_code': 'AL',
        'hover': 'ALABAMA', //state hover content
        'url':'/fact-sheets/factsheet_nutrition_al_snap_program/', //Goto URL
        'target':'same_window', //open link in new window:new_window, open in current window:same_window, or none for nothing.
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D', //state's color when mouse hover
        'downColor':'#FFEE88',//state's color when mouse clicking
        'enable':true,//true/false to enable/disable this state
    },
    'map_2':{
        'state_code': 'AK',
        'hover': 'ALASKA',
        'url':'/fact-sheets/factsheet_nutrition_ak_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true
    },
    'map_3':{
        'state_code': 'AZ',
        'hover': 'ARIZONA',
        'url':'/fact-sheets/factsheet_nutrition_az_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_4':{
        'state_code': 'AR',
        'hover': 'ARKANSAS',
        'url':'/fact-sheets/factsheet_nutrition_ar_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_5':{
        'state_code': 'CA',
        'hover': 'CALIFORNIA',
        'url':'/fact-sheets/factsheet_nutrition_ca_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_6':{
        'state_code': 'CO',
        'hover': 'COLORADO',
        'url':'/fact-sheets/factsheet_nutrition_co_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_7':{
        'state_code': 'CT',
        'hover': 'CONNECTICUT',
        'url':'/fact-sheets/factsheet_nutrition_ct_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_8':{
        'state_code': 'DE',
        'hover': 'DELAWARE',
        'url':'/fact-sheets/factsheet_nutrition_de_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_9':{
        'state_code': 'FL',
        'hover': 'FLORIDA',
        'url':'/fact-sheets/factsheet_nutrition_fl_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_10':{
        'state_code': 'GA',
        'hover': 'GEORGIA',
        'url':'/fact-sheets/factsheet_nutrition_ga_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_11':{
        'state_code': 'HI',
        'hover': 'HAWAII',
        'url':'/fact-sheets/factsheet_nutrition_hi_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_12':{
        'state_code': 'ID',
        'hover': 'IDAHO',
        'url':'/fact-sheets/factsheet_nutrition_id_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_13':{
        'state_code': 'IL',
        'hover': 'ILLINOIS',
        'url':'/fact-sheets/factsheet_nutrition_il_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_14':{
        'state_code': 'IN',
        'hover': 'INDIANA',
        'url':'/fact-sheets/factsheet_nutrition_in_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_15':{
        'state_code': 'IA',
        'hover': 'IOWA',
        'url':'/fact-sheets/factsheet_nutrition_ia_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_16':{
        'state_code': 'KS',
        'hover': 'KANSAS',
        'url':'/fact-sheets/factsheet_nutrition_ks_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_17':{
        'state_code': 'KY',
        'hover': 'KENTUCKY',
        'url':'/fact-sheets/factsheet_nutrition_ky_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_18':{
        'state_code': 'LA',
        'hover': 'LOUISIANA',
        'url':'/fact-sheets/factsheet_nutrition_la_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_19':{
        'state_code': 'ME',
        'hover': 'MAINE',
        'url':'/fact-sheets/factsheet_nutrition_me_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_20':{
        'state_code': 'MD',
        'hover': 'MARYLAND',
        'url':'/fact-sheets/factsheet_nutrition_md_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_21':{
        'state_code': 'MA',
        'hover': 'MASSACHUSETTS',
        'url':'/fact-sheets/factsheet_nutrition_ma_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_22':{
        'state_code': 'MI',
        'hover': 'MICHIGAN',
        'url':'/fact-sheets/factsheet_nutrition_mi_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_23':{
        'state_code': 'MN',
        'hover': 'MINNESOTA',
        'url':'/fact-sheets/factsheet_nutrition_mn_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_24':{
        'state_code': 'MS',
        'hover': 'MISSISSIPPI',
        'url':'/fact-sheets/factsheet_nutrition_ms_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_25':{
        'state_code': 'MO',
        'hover': 'MISSOURI',
        'url':'/fact-sheets/factsheet_nutrition_mo_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_26':{
        'state_code': 'MT',
        'hover': 'MONTANA',
        'url':'/fact-sheets/factsheet_nutrition_mt_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_27':{
        'state_code': 'NE',
        'hover': 'NEBRASKA',
        'url':'/fact-sheets/factsheet_nutrition_ne_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_28':{
        'state_code': 'NV',
        'hover': 'NEVADA',
        'url':'/fact-sheets/factsheet_nutrition_nv_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_29':{
        'state_code': 'NH',
        'hover': 'NEW HAMPSHIRE',
        'url':'/fact-sheets/factsheet_nutrition_nh_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_30':{
        'state_code': 'NJ',
        'hover': 'NEW JERSEY',
        'url':'/fact-sheets/factsheet_nutrition_nj_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_31':{
        'state_code': 'NM',
        'hover': 'NEW MEXICO',
        'url':'/fact-sheets/factsheet_nutrition_nm_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_32':{
        'state_code': 'NY',
        'hover': 'NEW YORK',
        'url':'/fact-sheets/factsheet_nutrition_ny_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_33':{
        'state_code': 'NC',
        'hover': 'NORTH CAROLINA',
        'url':'/fact-sheets/factsheet_nutrition_nc_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_34':{
        'state_code': 'ND',
        'hover': 'NORTH DAKOTA',
        'url':'/fact-sheets/factsheet_nutrition_nd_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_35':{
        'state_code': 'OH',
        'hover': 'OHIO',
        'url':'/fact-sheets/factsheet_nutrition_oh_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_36':{
        'state_code': 'OK',
        'hover': 'OKLAHOMA',
        'url':'/fact-sheets/factsheet_nutrition_ok_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_37':{
        'state_code': 'OR',
        'hover': 'OREGON',
        'url':'/fact-sheets/factsheet_nutrition_or_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_38':{
        'state_code': 'PA',
        'hover': 'PENNSYLVANIA',
        'url':'/fact-sheets/factsheet_nutrition_pa_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_39':{
        'state_code': 'RI',
        'hover': 'RHODE ISLAND',
        'url':'/fact-sheets/factsheet_nutrition_ri_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_40':{
        'state_code': 'SC',
        'hover': 'SOUTH CAROLINA',
        'url':'/fact-sheets/factsheet_nutrition_sc_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#FFEE88',
        'enable':true,
    },
    'map_41':{
        'state_code': 'SD',
        'hover': 'SOUTH DAKOTA',
        'url':'/fact-sheets/factsheet_nutrition_sd_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#FFEE88',
        'enable':true,
    },
    'map_42':{
        'state_code': 'TN',
        'hover': 'TENNESSEE',
        'url':'/fact-sheets/factsheet_nutrition_tn_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_43':{
        'state_code': 'TX',
        'hover': 'In Texas, over <strong>333,000 people</strong> are using SNAP to stretch their grocery budget. Are you?',
        'url':'/fact-sheets/factsheet_nutrition_tx_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_44':{
        'state_code': 'UT',
        'hover': 'UTAH',
        'url':'/fact-sheets/factsheet_nutrition_ut_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_45':{
        'state_code': 'VT',
        'hover': 'VERMONT',
        'url':'/fact-sheets/factsheet_nutrition_vt_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_46':{
        'state_code': 'VA',
        'hover': 'VIRGINIA',
        'url':'/fact-sheets/factsheet_nutrition_va_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_47':{
        'state_code': 'WA',
        'hover': 'WASHINGTON',
        'url':'/fact-sheets/factsheet_nutrition_wa_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_48':{
        'state_code': 'WV',
        'hover': 'WEST VIRGINIA',
        'url':'/fact-sheets/factsheet_nutrition_wv_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_49':{
        'state_code': 'WI',
        'hover': 'WISCONSIN',
        'url':'/fact-sheets/factsheet_nutrition_wi_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_50':{
        'state_code': 'WY',
        'hover': 'WYOMING',
        'url':'/fact-sheets/factsheet_nutrition_wy_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_51':{
        'state_code': 'PR',
        'hover': 'Puerto Rico',
        'url':'/fact-sheets/factsheet_nutrition_pr_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_52':{
        'state_code': 'GU',
        'hover': 'Guam',
        'url':'/fact-sheets/factsheet_nutrition_gu_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    },
    'map_53':{
        'state_code': 'VI',
        'hover': 'Virgin Islands',
        'url':'/fact-sheets/factsheet_nutrition_vi_snap_program/',
        'target':'same_window',
        'upColor':'#1888de', //state's color when page loads
        'overColor':'#1F3D7D',
        'downColor':'#993366',
        'enable':true,
    }
};

var pin_config = {
    'default':{
        'pinShadow':'#000', //shadow color below the points
        'pinShadowOpacity':'50', //shadow opacity, value, 0-100
    },
    'points':[
        // {
        // 	'shape':'circle',
        // 	'hover':'In Texas, over <strong>333,000 people</strong> are using SNAP to stretch their grocery budget. Are you?',
        // 	'pos_X':362,
        // 	'pos_Y':376,
        // 	'diameter':12,
        // 	'outline':'#FFF',
        // 	'thickness':1,
        // 	'upColor':'#FF0000',
        // 	'overColor':'#FFEE88',
        // 	'downColor':'#00ffff',
        // 	'url':'http://www.html5interactivemaps.com',
        // 	'target':'same_window',
        // 	'enable':true,
        // }
    ]
}

// Quick feature detection
function isTouchEnabled() {
    return (('ontouchstart' in window)
    || (navigator.MaxTouchPoints > 0)
    || (navigator.msMaxTouchPoints > 0));
}

$(function(){
    addEvent('map_1');
    addEvent('map_2');
    addEvent('map_3');
    addEvent('map_4');
    addEvent('map_5');
    addEvent('map_6');
    addEvent('map_7');
    addEvent('map_8');
    addEvent('map_9');
    addEvent('map_10');
    addEvent('map_11');
    addEvent('map_12');
    addEvent('map_13');
    addEvent('map_14');
    addEvent('map_15');
    addEvent('map_16');
    addEvent('map_17');
    addEvent('map_18');
    addEvent('map_19');
    addEvent('map_20');
    addEvent('map_21');
    addEvent('map_22');
    addEvent('map_23');
    addEvent('map_24');
    addEvent('map_25');
    addEvent('map_26');
    addEvent('map_27');
    addEvent('map_28');
    addEvent('map_29');
    addEvent('map_30');
    addEvent('map_31');
    addEvent('map_32');
    addEvent('map_33');
    addEvent('map_34');
    addEvent('map_35');
    addEvent('map_36');
    addEvent('map_37');
    addEvent('map_38');
    addEvent('map_39');
    addEvent('map_40');
    addEvent('map_41');
    addEvent('map_42');
    addEvent('map_43');
    addEvent('map_44');
    addEvent('map_45');
    addEvent('map_46');
    addEvent('map_47');
    addEvent('map_48');
    addEvent('map_49');
    addEvent('map_50');
    addEvent('map_51');
    addEvent('map_52');
    addEvent('map_53');

    // Get count for all States (to display in map);
    $.getJSON(window.webServiceUrl+'/rest/backend/snap/countallstates/2016', function(data) {
        var states_count = data.DATA;

        states_count.forEach(function(element) {
            if (element[1] in map_ids) {
                var count = element[2].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); //Format number (add comma to separate thousands)
                map_config['map_' + map_ids[element[1]]]['hover'] = 'In '+element[0]+', over <strong>'+count+' people</strong> are using SNAP to stretch their grocery budget. Are you?';
            }
        });
    });
})
$(function(){
    if($('#lakes').find('path').eq(0).attr('fill') != 'undefined'){
        $('#lakes').find('path').attr({'fill':map_config['default']['lakesColor']}).css({'stroke':map_config['default']['borderColor']});
    }

    $('#map-tip').css({
        'box-shadow':'1px 2px 4px '+map_config['default']['hoverShadow'],
        '-moz-box-shadow':'2px 3px 6px '+map_config['default']['hoverShadow'],
        '-webkit-box-shadow':'2px 3px 6px '+map_config['default']['hoverShadow'],
    });

    if($('#shadow').find('path').eq(0).attr('fill') != 'undefined'){
        var shadowOpacity = map_config['default']['shadowOpacity'];
        var shadowOpacity = parseInt(shadowOpacity);
        if (shadowOpacity >=100){shadowOpacity = 1;}else if(shadowOpacity <=0){shadowOpacity =0;}else{shadowOpacity = shadowOpacity/100;}

        $('#shadow').find('path').attr({'fill':map_config['default']['mapShadow']}).css({'fill-opacity':shadowOpacity})
    }
});

function addEvent(id,relationId){
    var _obj = $('#'+id);
    var _Textobj = $('#'+id+','+'#'+map_config[id]['namesId']);

    $('#'+['text-abb']).attr({'fill':map_config['default']['namesColor']});

    _obj.attr({'fill':map_config[id]['upColor'],'stroke':map_config['default']['borderColor']});
    _Textobj.attr({'cursor':'default'});
    if(map_config[id]['enable'] == true){
        if (isTouchEnabled()) {
            //clicking effect
            _Textobj.on('touchstart', function(e){
                var touch = e.originalEvent.touches[0];
                var x=touch.pageX+10, y=touch.pageY+15;
                var tipw=$('#map-tip').outerWidth(), tiph=$('#map-tip').outerHeight(),
                    x=(x+tipw>$(document).scrollLeft()+$(window).width())? x-tipw-(20*2) : x
                y=(y+tiph>$(document).scrollTop()+$(window).height())? $(document).scrollTop()+$(window).height()-tiph-10 : y
                $('#'+id).css({'fill':map_config[id]['downColor']});
                $('#map-tip').show().html(map_config[id]['hover']);
                $('#map-tip').css({left:x, top:y})
            })
            _Textobj.on('touchend', function(){
                $('#'+id).css({'fill':map_config[id]['upColor']});
                if(map_config[id]['target'] == 'new_window'){
                    window.open(map_config[id]['url']);
                }else if(map_config[id]['target'] == 'same_window'){
                    window.parent.location.href=map_config[id]['url'];
                }
            })
        }
        _Textobj.attr({'cursor':'pointer'});
        _Textobj.hover(function(){
            //moving in/out effect
            $('#map-tip').show().html(map_config[id]['hover']);
            _obj.css({'fill':map_config[id]['overColor']})
        },function(){
            $('#map-tip').hide();
            $('#'+id).css({'fill':map_config[id]['upColor']});
        })
        //clicking effect
        _Textobj.mousedown(function(){
            $('#'+id).css({'fill':map_config[id]['downColor']});
        })
        _Textobj.mouseup(function(){
            $('#'+id).css({'fill':map_config[id]['overColor']});
            if(map_config[id]['target'] == 'new_window'){
                window.open(map_config[id]['url']);
            }else if(map_config[id]['target'] == 'same_window'){
                window.parent.location.href=map_config[id]['url'];
            }
        })
        _Textobj.mousemove(function(e){
            var x=e.pageX+10, y=e.pageY+15;
            var tipw=$('#map-tip').outerWidth(), tiph=$('#map-tip').outerHeight(),
                x=(x+tipw>$(document).scrollLeft()+$(window).width())? x-tipw-(20*2) : x
            y=(y+tiph>$(document).scrollTop()+$(window).height())? $(document).scrollTop()+$(window).height()-tiph-10 : y
            $('#map-tip').css({left:x, top:y})
        })
    }
}

//The pins code
$(function(){
    if($('#pin-shadow').find('path').eq(0).attr('fill') != 'undefined'){
        var pinShadowOpacity = pin_config['default']['pinShadowOpacity'];
        var pinShadowOpacity = parseInt(pinShadowOpacity);
        if (pinShadowOpacity >=100){pinShadowOpacity = 1;}else if(pinShadowOpacity <=0){pinShadowOpacity =0;}else{pinShadowOpacity = pinShadowOpacity/100;}

        $('#pin-shadow').find('path').attr({'fill':pin_config['default']['pinShadow']}).css({'fill-opacity':pinShadowOpacity})
    };


    var points_len = pin_config['points'].length;
    if( points_len > 0){
        var xmlns = "http://www.w3.org/2000/svg";
        var tsvg_obj = document.getElementById("map_points");
        var svg_circle,svg_rect;
        for(var i=0;i<points_len;i++){
            if (pin_config['points'][i]['shape']=="circle"){
                svg_circle = document.createElementNS(xmlns, "circle");
                svg_circle.setAttributeNS(null, "cx", pin_config['points'][i]['pos_X']+1);
                svg_circle.setAttributeNS(null, "cy", pin_config['points'][i]['pos_Y']+1);
                svg_circle.setAttributeNS(null, "r", pin_config['points'][i]['diameter']/2);
                svg_circle.setAttributeNS(null, "fill", pin_config['default']['pinShadow']);
                svg_circle.setAttributeNS(null, "style",'fill-opacity:'+pinShadowOpacity);
                svg_circle.setAttributeNS(null, "id",'map_points_shadow_'+i);
                tsvg_obj.appendChild(svg_circle);
                svg_circle = document.createElementNS(xmlns, "circle");
                svg_circle.setAttributeNS(null, "cx", pin_config['points'][i]['pos_X']);
                svg_circle.setAttributeNS(null, "cy", pin_config['points'][i]['pos_Y']);
                svg_circle.setAttributeNS(null, "r", pin_config['points'][i]['diameter']/2);
                svg_circle.setAttributeNS(null, "fill", pin_config['points'][i]['upColor']);
                svg_circle.setAttributeNS(null, "stroke",pin_config['points'][i]['outline']);
                svg_circle.setAttributeNS(null, "stroke-width",pin_config['points'][i]['thickness']);
                svg_circle.setAttributeNS(null, "id",'map_points_'+i);
                tsvg_obj.appendChild(svg_circle);
                dynamicAddEvent(i);
            }
            else if(pin_config['points'][i]['shape']=="rectangle"){
                svg_rect = document.createElementNS(xmlns, "rect");
                svg_rect.setAttributeNS(null, "x", pin_config['points'][i]['pos_X']- pin_config['points'][i]['width']/2+1);
                svg_rect.setAttributeNS(null, "y", pin_config['points'][i]['pos_Y']- pin_config['points'][i]['height']/2+1);
                svg_rect.setAttributeNS(null, "width", pin_config['points'][i]['width']);
                svg_rect.setAttributeNS(null, "height", pin_config['points'][i]['height']);
                svg_rect.setAttributeNS(null, "fill", pin_config['default']['pinShadow']);
                svg_rect.setAttributeNS(null, "style",'fill-opacity:'+pinShadowOpacity);
                svg_rect.setAttributeNS(null, "id",'map_points_shadow_'+i);
                tsvg_obj.appendChild(svg_rect);
                svg_rect = document.createElementNS(xmlns, "rect");
                svg_rect.setAttributeNS(null, "x", pin_config['points'][i]['pos_X']- pin_config['points'][i]['width']/2);
                svg_rect.setAttributeNS(null, "y", pin_config['points'][i]['pos_Y']- pin_config['points'][i]['height']/2);
                svg_rect.setAttributeNS(null, "width", pin_config['points'][i]['width']);
                svg_rect.setAttributeNS(null, "height", pin_config['points'][i]['height']);
                svg_rect.setAttributeNS(null, "fill", pin_config['points'][i]['upColor']);
                svg_rect.setAttributeNS(null, "stroke",pin_config['points'][i]['outline']);
                svg_rect.setAttributeNS(null, "stroke-width",pin_config['points'][i]['thickness']);
                svg_rect.setAttributeNS(null, "id",'map_points_'+i);
                tsvg_obj.appendChild(svg_rect);
                dynamicAddEvent(i);
            }
        }
    }
});

function dynamicAddEvent(id){
    var obj = $('#map_points_'+id);

    if(pin_config['points'][id]['enable'] == true){
        if (isTouchEnabled()) {
            obj.on('touchstart', function(e){
                var touch = e.originalEvent.touches[0];
                var x=touch.pageX+10, y=touch.pageY+15;
                var tipw=$('#map-tip').outerWidth(), tiph=$('#map-tip').outerHeight(),
                    x=(x+tipw>$(document).scrollLeft()+$(window).width())? x-tipw-(20*2) : x
                y=(y+tiph>$(document).scrollTop()+$(window).height())? $(document).scrollTop()+$(window).height()-tiph-10 : y
                $('#'+id).css({'fill':pin_config['points'][id]['downColor']});
                $('#map-tip').show().html(pin_config['points'][id]['hover']);
                $('#map-tip').css({left:x, top:y})
            })
            obj.on('touchend', function(){
                $('#'+id).css({'fill':pin_config['points'][id]['upColor']});
                if(pin_config['points'][id]['target'] == 'new_window'){
                    window.open(pin_config['points'][id]['url']);
                }else if(pin_config['points'][id]['target'] == 'same_window'){
                    window.parent.location.href=pin_config['points'][id]['url'];
                }
            })
        }
        obj.attr({'cursor':'pointer'});
        obj.hover(function(){
            $('#map-tip').show().html(pin_config['points'][id]['hover']);
            obj.css({'fill':pin_config['points'][id]['overColor']})
        },function(){
            $('#map-tip').hide();
            obj.css({'fill':pin_config['points'][id]['upColor']});
        })
        //clicking effect
        obj.mousedown(function(){
            obj.css({'fill':pin_config['points'][id]['downColor']});
        })
        obj.mouseup(function(){
            obj.css({'fill':pin_config['points'][id]['overColor']});
            if(pin_config['points'][id]['target'] == 'new_window'){
                window.open(pin_config['points'][id]['url']);
            }else if(pin_config['points'][id]['target'] == 'same_window'){
                window.parent.location.href=pin_config['points'][id]['url'];
            }
        })
        obj.mousemove(function(e){
            var x=e.pageX+10, y=e.pageY+15;
            var tipw=$('#map-tip').outerWidth(), tiph=$('#map-tip').outerHeight(),
                x=(x+tipw>$(document).scrollLeft()+$(window).width())? x-tipw-(20*2) : x
            y=(y+tiph>$(document).scrollTop()+$(window).height())? $(document).scrollTop()+$(window).height()-tiph-10 : y
            $('#map-tip').css({left:x, top:y})
        })
    }
}