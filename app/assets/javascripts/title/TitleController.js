theBlog.controller('TitleController', ["$scope", "$http", function($scope, $http) {
    $scope.users = 0;
    $scope.posts = 0;
    $http.get('/api/v1/title').success(function(data) {
        $scope.users = data.number_of_users;
        $scope.posts = data.number_of_posts;
    });
}]);