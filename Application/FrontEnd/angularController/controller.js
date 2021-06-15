var app = angular.module('mainApp',['ngRoute']);

app.config(function($routeProvider){
    $routeProvider
    .when('/',{
        templateUrl: 'login.html'
    })
    .when('/dashboard',{
        templateUrl:'dashboard.html'
    }).when('/test',{
        template:'<strong> test first </strong>'
    }).when('/test2',{
        template:'<strong> test second </strong>'
    })
    .otherwise({
        redirectTo: '/'
    });
});

app.controller('loginCtrl', function($scope, $location){
    $scope.submit = function(){
        console.log('submit');
        var uname = $scope.username;
        var password = $scope.password;
        if ($scope.username == 'admin' && $scope.password == '1')
        {
            $location.path('/test2');
        }
        else $location.path('/test');
    }
});