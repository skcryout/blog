theBlog.controller('BlogController', ["$scope", "$http", "localStorageService", function($scope, $http, localStorageService) {
    $scope.posts;
    $scope.opinion;
    $http({
        method: 'GET',
        url: '/api/v1/posts/' + window.location.pathname.split("/")[1],
        data: {},
        headers: {"Content-Type": "application/json"}
    }).success(function(data) {
        if(data.errorCode == -4444) {
            alert("존재하지 않는 url입니다.");
        } else {
            console.log(data.posts);
            $scope.posts = data.posts;
        }
        
        
    });

    $scope.post_opinion = function(post_id, opinion) {
     
        $http({
            method: 'POST',
            url: '/api/v1/comments',
            data: {
                post_id: post_id,
                content: opinion
            },
            headers: {"Content-Type": "application/json"}
        }).success(function(data) {
            
        });
    }
}]);