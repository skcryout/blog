theBlog.controller('SignUpController', function($scope, $http, localStorageService) {
    $scope.signUp = function() {
        $scope.username;
        $scope.password;
        $scope.password_confirmation;
        $http({
            method: 'POST',
            url: '/api/v1/users',
            data: {
                username: $scope.username,
                password: $scope.password,
                password_confirmation: $scope.password_confirmation
            },
            headers: {"Content-Type": "application/json"}
        }).success(function(data) {
            if(data.errorCode == 0) {
                localStorageService.add('auth_token', data.auth_token)
                alert("회원가입이 완료 되었습니다.");
                window.location = "/";
            } else if(data.errorCode == 100) {
                alert("username을 입력해주세요.");
            } else if(data.errorCode == 101) {
                alert("password를 입력해주세요.");
            } else if(data.errorCode == 102) {
                alert("password는 최소 6자 이상이어야 합니다.");
            } else if(data.errorCode == 103) {
                alert("password와 password_confirmation이 일치하지 않습니다.");
            } else if(data.errorCode == 120) {
                alert("해당 Username이 이미 존재합니다.");
            }
        });
    }
});