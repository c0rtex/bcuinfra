'use strict';

/* Services */

var services = angular.module('services', ['ngResource']);
var webServiceURL="http://localhost/cf/components";

services.factory('questionSet1', ['$resource',
  function($resource){
    return $resource(webServiceURL+'/questionSet1.cfc?method=getQuestionSet&subset_id=:subset_id&state_id=:state_id&partner_id=:partner_id&prev_id=:prev_id&callback=JSON_CALLBACK', {}, {
      query: {method:'JSONP',
              params:{subset_id:0,state_id:'',partner_id:0,prev_id:0},
              isArray:false}
    });
  }]);

services.factory('questionSet2', ['$resource',
    function($resource){
        return $resource(webServiceURL+'/questionSet2.cfc?method=getQuestionSet&subset_id=:subset_id&state_id=:state_id&partner_id=:partner_id&prev_id=:prev_id&callback=JSON_CALLBACK', {}, {
            query: {method:'JSONP',
                params:{subset_id:0,state_id:'',partner_id:0,prev_id:0},
                isArray:false}
        });
    }]);

services.factory('questionSet3', ['$resource',
    function($resource){
        return $resource(webServiceURL+'/questionSet3.cfc?method=getQuestionSet&subset_id=:subset_id&state_id=:state_id&partner_id=:partner_id&prev_id=:prev_id&callback=JSON_CALLBACK', {}, {
            query: {method:'JSONP',
                params:{subset_id:0,state_id:'',partner_id:0,prev_id:0},
                isArray:false}
        });
    }]);

services.factory('questionSet4', ['$resource',
    function($resource){
        return $resource(webServiceURL+'/questionSet4.cfc?method=getQuestionSet&subset_id=:subset_id&state_id=:state_id&partner_id=:partner_id&prev_id=:prev_id&callback=JSON_CALLBACK', {}, {
            query: {method:'JSONP',
                params:{subset_id:0,state_id:'',partner_id:0,prev_id:0},
                isArray:false}
        });
    }]);

services.factory('all', ['$resource',
    function($resource){
        return $resource(webServiceURL+'/customQuestionSet.cfc?method=getQuestionSet&subset_id=:subset_id&state_id=:state_id&partner_id=:partner_id&prev_id=:prev_id&callback=JSON_CALLBACK', {}, {
            query: {method:'JSONP',
                params:{subset_id:0,state_id:'',partner_id:0,prev_id:0},
                isArray:false}
        });
    }]);