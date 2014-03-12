theBlog.controller('BlogController', ["$scope", "$http", "localStorageService", function($scope, $http, localStorageService) {
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
            if(data.errorCode == 0) {
                alert('댓글이 성공적으로 등록되었습니다.');
                window.location = window.location;
            } else {
                alert("서버에 문제가 생겼습니다.");
            }
        });
    }
}]);