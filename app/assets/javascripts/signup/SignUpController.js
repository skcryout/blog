theBlog.controller('SignUpController', function($scope, $http) {
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
            console.log(data);
        });
    }
});