# SchoolManagement
 This project is for manage teacher , student and courses



•	Oracle Database, Stored Procedures
•	ASP.NET, WebApi 2
•	Nodejs  [14.17.0]
•	Npm [7.17.0]
•	JSON
•	Angular [12.1.0]
•	JavaScript
•	JQuery 
•	Bootstrap: [5.0.2]
•	HTML



===================== Angular Commands Used ===========================
ng new <project name>
ng generate module app-routing --flat --module=app 
ng serve
ng g c login
ng g s shared/login
ng g cl shared/login --type=model
ng g guard <guard_name>
     * CanActivate
     * CanActivateChild
     * CanDeactivate
     * Resolve
     * CanLoad
	 
====================== Links ==============================

https://angular.io/tutorial/toh-pt5   // app-routing 



================Install Instructions=========================

1. Install Oracle Database 12c
2. Create schema using command given on folder:  "Database/1. Create Schema Script.sql"  using sys user logged in as sysdba.
3. Run "Database/2. Table and Package Script.sql , 3. Roles Config.sql , 4. Create Admin User.sql" on database schema "user: schoolmgmt, password: schoolmgmt".
4. Validate all packages on database.

5. Run Backend project on visual studio 2019 on port: 44358, Url should be: https://localhost:44358
6. Install nodejs 14.17.1
7. Open command promt on directory "FrontEnd\SchoolMgmt" 
8. Install NPM 7.17.0
9. RUN command: npm install --save-dev package 
10. RUN command:  ng serve
