theBlog.controller('PostsController', ["$scope", "$http", "localStorageService", function($scope, $http, localStorageService) {
    $scope.create_post = function() {
        $scope.title;
        $scope.content;
        
        $http({
            method: 'POST',
            url: '/api/v1/posts',
            data: {
                title: $scope.title,
                content: $scope.content,
                auth_token: localStorageService.get('auth_token')
            },
            headers: {"Content-Type": "application/json"}
        }).success(function(data) {
            if(data.errorCode == 0) {
                alert("작성하신 글이 성공적으로 저장되었습니다.");
                window.location = "/" + data.username;
            } else if(data.errorCode == -444) {
                alert("연결에 문제가 있습니다. 관리자에게 문의 주세요.");
            } else if(data.errorCode == -4444) {
                alert("로그인을 하셔야 글을 쓰실 수 있습니다.");
            } else {
                alert("알 수 없는 오류입니다. 관리자에게 문의 주세요.");
            }
        });
    }

    $scope.update_post = function(post_id) {
        
    }
}]);