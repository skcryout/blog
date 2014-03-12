theBlog.controller('HomeController', ["$scope", "$http", "localStorageService", function($scope, $http, localStorageService) {
    $http.get("/api/v1/posts").success(function(data) {
        $scope.users = data;
    });
}]);