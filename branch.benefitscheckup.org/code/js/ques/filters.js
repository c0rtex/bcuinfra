'use strict';

questionnaireApp.filter('trustAsHtml', function($sce) {
  return $sce.trustAsHtml;
});
