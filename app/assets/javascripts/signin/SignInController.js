theBlog.controller('SignInController', function($scope, $http, localStorageService) {
    $scope.signIn = function() {
        $scope.username;
        $scope.password;
        
        $http({
            method: 'POST',
            url: '/api/v1/sessions',
            data: {
                username: $scope.username,
                password: $scope.password
            },
            headers: {"Content-Type": "application/json"}
        }).success(function(data) {
            if(data.errorCode == 0) {
                localStorageService.add('auth_token', data.auth_token);
                window.location = "/";
            } else if(data.errorCode == 100) {
                alert("username을 입력해주세요.");
            } else if(data.errorCode == 101) {
                alert("password를 입력해주세요.");
            } else if(data.errorCode == 400) {
                alert("username과 password가 일치하지 않습니다.");
            } else {
                alert("알 수 없는 오류입니다.")
            }
        });
    }
});