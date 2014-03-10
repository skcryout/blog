theBlog.controller('TitleController', function($scope, $http) {
    $http.get('/api/v1/title').success(function(data) {
        $scope.users = data.number_of_users;
        $scope.posts = data.number_of_posts;
    });
});