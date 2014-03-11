theBlog.controller('BlogController', ["$scope", "$http", "localStorageService", function($scope, $http, localStorageService) {
    $scope.posts;
    $http({
        method: 'GET',
        url: '/api/v1/posts/' + window.location.pathname.split("/")[1],
        data: {},
        headers: {"Content-Type": "application/json"}
    }).success(function(data) {
        if(data.errorCode == -4444) {
            alert("존재하지 않는 url입니다.");
        } else {
            $scope.posts = data.posts;
        }
        
        
    });   
}]);