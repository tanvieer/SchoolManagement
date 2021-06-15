var myApp = angular.module("myApp", []);

myApp.controller("myController", function($scope){
	console.log("in controller...");
	$scope.newUser = {};
	$scope.info = "";

	$scope.users = [
		{username: "rimon", fullName: "Md. Mamunur Rashid Rimon", email:"rimonmath@gmail.com"},
		{username: "shamim", fullName: "Md. Tamim Hossain", email:"shamim@gmail.com"},
		{username: "tamim", fullName: "Tamim Iqbal", email:"tamim@gmail.com"}
	];
 


	$scope.saveUser = function(){
		console.log("Saving...");
		$scope.users.push($scope.newUser);
		$scope.info = "New User Added Successfully!";
		$scope.newUser = {};
	};

	$scope.selectUser = function(user){
		$scope.clickedUser = user;
	};

	$scope.deleteUser = function(){
		console.log($scope.users.indexOf($scope.clickedUser));
		$scope.users.splice($scope.users.indexOf($scope.clickedUser), 1);
		$scope.info = "User Deleted Successfully!";
	};

	$scope.clearInfo = function(){
		$scope.info = "";
	};
});