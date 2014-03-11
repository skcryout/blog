theBlog.controller('HeaderController', ["$scope", "$http", "localStorageService", function($scope, $http, localStorageService) {
    $scope.logged_in = false;
    $scope.logout = function() {
        $http({
            method: 'DELETE',
            url: '/api/v1/sessions',
            data: {
                auth_token: localStorageService.get('auth_token')
            },
            headers: {"Content-Type": "application/json"}
        }).success(function(data) {
            if(data.errorCode == 0){
                localStorageService.remove('auth_token');
                window.location = "/";
            } else  {
                
            }
                
        });
        
    }
    $http({
        method: 'POST',
        url: '/api/v1/sessions/check_auth_token',
        data: {
            auth_token: localStorageService.get('auth_token')
        },
        headers: {"Content-Type": "application/json"}
    }).success(function(data) {
        if(data.errorCode == 0) {
            $scope.logged_in = true;
        } else {
            $scope.logged_in = false;
        }
    });   
}]);