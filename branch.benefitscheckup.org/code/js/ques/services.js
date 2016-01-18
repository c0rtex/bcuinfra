'use strict';

/* Services */

var services = angular.module('services', ['ngResource']);

services.factory('questionSet1', ['$resource',
  function($resource){
    return $resource('http://localhost/cf/components/questionSet1.cfc?method=getQuestionSet&subset_id=:subset_id&state_id=:state_id&partner_id=:partner_id&callback=JSON_CALLBACK', {}, {
      query: {method:'JSONP',
              params:{subset_id:0,state_id:'',partner_id:0,org_id:0},
              isArray:false}
    });
  }]);

services.factory('questionSet2', ['$resource',
    function($resource){
        return $resource('http://localhost/cf/components/questionSet2.cfc?method=getQuestionSet&callback=JSON_CALLBACK', {}, {
            query: {method:'JSONP',
                params:{subset_id:0,state_id:'',partner_id:0,org_id:0},
                isArray:false}
        });
    }]);

services.factory('questionSet3', ['$resource',
    function($resource){
        return $resource('http://localhost/cf/components/questionSet3.cfc?method=getQuestionSet&callback=JSON_CALLBACK', {}, {
            query: {method:'JSONP',
                params:{subset_id:0,state_id:'',partner_id:0,org_id:0},
                isArray:false}
        });
    }]);

services.factory('questionSet4', ['$resource',
    function($resource){
        return $resource('http://localhost/cf/components/questionSet4.cfc?method=getQuestionSet&callback=JSON_CALLBACK', {}, {
            query: {method:'JSONP',
                params:{subset_id:0,state_id:'',partner_id:0,org_id:0},
                isArray:false}
        });
    }]);
