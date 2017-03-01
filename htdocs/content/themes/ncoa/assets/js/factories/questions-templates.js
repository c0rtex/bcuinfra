app.factory('questionTemplates',[function() {

    var directivePath = "/content/themes/ncoa/resources/views/directives/question/";

    var questionTemplates = {"zip":directivePath+"zip.html",
        "client":directivePath+"client.html",
        "veteran":directivePath+"veteran.html",
        "dob":directivePath+"dob.html",
        "marital_stat":directivePath+"marital_stat.html",
        "bcuqc_income":directivePath+"bcuqc_income.html",
        "bcuqc_interest_category":directivePath+"bcuqc_interest_category.html",
        "citizen":directivePath+"citizen.html",
        "sp_veteran":directivePath+"sp_veteran.html",
        "incomegrid":directivePath+"incomegrid.html",
        "assetgrid":directivePath+"assetgrid.html"};

    return questionTemplates;
}]);
