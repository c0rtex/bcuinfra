'use strict';

/* Services */

var services = angular.module('services', ['ngResource']);
var webServiceURL="http://localhost/cf/components";

services.factory('questionSet', ['$resource',
  function($resource){
    return $resource(webServiceURL+'/:questionSet.cfc?method=getQuestionSet&subset_id=:subset_id&state_id=:state_id&partner_id=:partner_id&prev_id=:prev_id&CFID=:CFID&CFTOKEN=:CFTOKEN&callback=JSON_CALLBACK', {}, {
      query: {method:'JSONP',
              params:{questionSet:'questionSet1',subset_id:0,state_id:'',partner_id:0,prev_id:0,CFID:0,CFTOKEN:''},
              isArray:false}
    });
  }
]);

services.factory('screening',['$resource',
    function($resource){
        return $resource(webServiceURL+'/ScreeningService.cfc?method=doScreening', {}, {
            save: {method:'POST',
                params:{subset_id:0,state_id:'',partner_id:0,prev_id:0,CFID:0,CFTOKEN:'',response:""}}
        });
    }
]);

services.factory('all', ['$resource','$scope',
    function($resource,$scope){
        return $resource(webServiceURL+'/customQuestionSet.cfc?method=getQuestionSet&subset_id=:subset_id&state_id=:state_id&partner_id=:partner_id&prev_id=:prev_id&callback=JSON_CALLBACK', {}, {
            query: {method:'JSONP',
                params:{subset_id:0,state_id:'',partner_id:0,prev_id:0},
                isArray:false}
        });
    }]);