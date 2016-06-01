'use strict';

/* Services */

var services = angular.module('services', ['ngResource']);
var webServiceURL="http://localhost/cf/components";

services.factory('programFinder', ['$resource',
    function($resource){
        return $resource(webServiceURL+'/ProgramFinder.cfc?method=dspForms&cat=:cat&st=:st&callback=JSON_CALLBACK', {}, {
            query: {method:'JSONP',
                    params:{cat:'',st:''},
                    isArray:true}
        });
    }
]);
