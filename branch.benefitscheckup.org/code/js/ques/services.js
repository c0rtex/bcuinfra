'use strict';

/* Services */

var services = angular.module('services', ['ngResource']);
var webServiceURL="http://localhost/cf/components";

services.factory('questionSet', ['$resource',
  function($resource){
    return $resource(webServiceURL+'/:questionSet.cfc?method=getQuestionSet&subset_id=:subset_id&state_id=:state_id&partner_id=:partner_id&prev_id=:prev_id&CFID=:CFID&CFTOKEN=:CFTOKEN&callback=JSON_CALLBACK', {}, {
      query: {method:'JSONP',
              params:{questionSet:'questionSet1',subset_id:0,state_id:'',partner_id:0,prev_id:-1,CFID:0,CFTOKEN:''},
              isArray:false}
    });
  }
]);

services.factory('Screening',['$resource',
    function($resource){
        return $resource(webServiceURL+'/ScreeningProcessor.cfc?method=doScreening&CFID=:CFID&CFTOKEN=:CFTOKEN&state_id=:state_id&subset_id=:subset_id&partner_id=:partner_id&pgno=:pgno&prev_id=:prev_id&callback=JSON_CALLBACK', {}, {
            query:{method:'JSONP',
                 params:{CFID:0,CFTOKEN:'',subset_id:0,state_id:'',partner_id:0,prev_id:-1,pgno:1}}
        });
    }
]);

services.factory('ZipValidator',['$resource',
    function($resource){
        return $resource(webServiceURL+'/orm/zip.cfc?method=validateZip&zipCode=:zip&state_id=:state_id&callback=JSON_CALLBACK', {}, {
            query:{method:'JSONP',
                params:{zip:"",state_id:''}}
        });
    }
]);

services.factory('programFinder',['$resource',
    function($resource){
        return $resource(webServiceURL+'ProgramFinder.cfc?method=proceligibilityByScreening&callback=JSON_CALLBACK', {}, {
            query:{method:'JSONP',
                params:{CFID:0,CFTOKEN:''}}
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