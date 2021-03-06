theBlog.controller('BlogController', ["$scope", "$http", "localStorageService", function($scope, $http, localStorageService) {
    $http({
        method: 'GET',
        url: '/api/v1/posts/' + window.location.pathname.split("/")[1],
        data: {},
        headers: {"Content-Type": "application/json"}
    }).success(function(data) {
        if(data.errorCode == -4444) {
            $scope.urlFlag = true;
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
        $http({
            method: 'DELETE',
            url: '/api/v1/posts',
            data: {
                post_id: post_id,
                auth_token: localStorageService.get('auth_token')
            },
            headers: {"Content-Type": "application/json"}
        }).success(function(data) {
            if(data.errorCode == 0) {
                alert("글이 성공적으로 지워졌습니다.");
            } else if(data.erroCode == 10) {
                alert("자신의 글만 지울 수 있습니다.");
            } else {
                alert("에러 발생!!");
            }
        });
    }

    $scope.update_post = function(post_id) {
        window.location = "/posts/edit/" + post_id;
    }
}]);