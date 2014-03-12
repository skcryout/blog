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
            if(data.posts.length == 0)
                $scope.postFlag = true;
        } 
    });

    $scope.post_opinion = function(post_id, opinion) {
        $http({
            method: 'POST',
            url: '/api/v1/comments',
            data: {
                post_id: post_id,
                content: opinion,
                auth_token: localStorageService.get('auth_token')
            },
            headers: {"Content-Type": "application/json"}
        }).success(function(data) {
            if(data.errorCode == 0) {
                alert('댓글이 성공적으로 등록되었습니다.');
                window.location = window.location;
            } else if(data.errorCode == -44) {
                alert('로그인을 해야 댓글을 달 수 있습니다.');
            } else {
                alert("서버에 문제가 생겼습니다.");
            }
        });
    }

    $scope.delete_post = function(post_id) {
        
    }

    $scope.update_post = function(post_id) {
        
    }
}]);