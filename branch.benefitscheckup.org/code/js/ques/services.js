'use strict';

/* Services */

var services = angular.module('services', ['ngResource']);

services.factory('questionSet1', ['$resource',
  function($resource){
    return $resource('http://localhost/cf/components/questionSet1.cfc?method=getQuestionSet&callback=JSON_CALLBACK', {}, {
      query: {method:'JSONP',
              params:{},
              isArray:true}
    });
  }]);

services.factory('questionSet2', ['$resource',
    function($resource){
        return $resource('http://localhost/cf/components/questionSet2.cfc?method=getQuestionSet&callback=JSON_CALLBACK', {}, {
            query: {method:'JSONP',
                params:{},
                isArray:true}
        });
    }]);
