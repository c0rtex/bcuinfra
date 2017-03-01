app.directive('ncoaPrograms',[function(){

    return {
        restrict: 'A',
        link: function(scope,elm){
            scope.programs = window.programs;
            scope.currentProgramsList =scope.programs.slice(0,10);
            scope.pageCount=Math.ceil(scope.programs.length/10);
            scope.currentPage= scope.pageCount==0 ? 0 : 1;
            scope.showPage = function(pageNum) {
                if (pageNum<1) {
                    scope.currentPage= scope.pageCount==0 ? 0 : 1;
                } else if (pageNum>Math.ceil(scope.programs.length/10)) {
                    scope.currentPage = Math.ceil(scope.programs.length/10);
                } else {
                    scope.currentPage = pageNum;
                }
                scope.currentProgramsList =scope.programs.slice((scope.currentPage-1)*10, scope.currentPage*10);
                return false;
            }
        }
    }

}]);
