 
import { Injectable } from '@angular/core';  
import { Login, User } from './login.model';
import {HttpClient} from '@angular/common/http';
import { ToastrService } from 'ngx-toastr'; 
import { Router } from '@angular/router';
 

@Injectable({ providedIn: 'root' })
export class AuthenticationService {
    private isLoggedIn!: string;
    public formData!: Login;
    readonly rootUrl = "https://localhost:44358/api/Login";

    private _currentUser!: User;
    private _returnUrl!: string;
 

    constructor(private http: HttpClient, 
                private toastr : ToastrService,
                private router: Router) {
        
        this.isLoggedIn = localStorage.getItem('isLoggedIn') ?? "0";
        this._returnUrl = "/teachers";
         
    }

    public isLoggdIn(): boolean {
        if (this.isLoggedIn == "1")
          return true;
        else return false;
    }

    public getCurrentUser(): User {
      if (this.isLoggdIn() == true){
        this._currentUser.isLoggedIn = "1";
        this._currentUser.Name = localStorage.getItem('Email') ?? "0";
        this._currentUser.RoleName = localStorage.getItem('RoleName') ?? "0"; 
        this._currentUser.Token = localStorage.getItem('Token') ?? "0";
      } 
      else {
        this._currentUser.isLoggedIn = "0";
      }
      return this._currentUser;
  }

    login(_formData:Login){
      this.http.post(this.rootUrl ,_formData) 
      .subscribe((res : any)  =>{
           
        if(res.Status == "SUCCESS") {
          localStorage.setItem('isLoggedIn', "1");
          localStorage.setItem('Token', res.Result.Token);
          localStorage.setItem('Email',   res.Result.Email);
          localStorage.setItem('RoleName',res.Result.RoleName);
          localStorage.setItem('UserName',res.Result.UserName);
          localStorage.setItem('Name', res.Result.FirstName + " " + res.Result.LastName); 
          this.toastr.success(res.Message, 'Login Success');

          this.router.navigate([this._returnUrl]); 
          window.location.reload();
        }
        else {
          localStorage.setItem('isLoggedIn', "0");
          this.toastr.error(res.Message, 'Login Failed');
          this.router.navigate(['/login']);
        }
         
          
  
       });
    }

    logout() {
      localStorage.setItem('isLoggedIn', "0");
      localStorage.removeItem('session');
      localStorage.removeItem('Email');
      localStorage.removeItem('RoleName');
      localStorage.removeItem('Name');
      localStorage.setItem("Name","");

      this.router.navigateByUrl('/login', { skipLocationChange: true }).then(() => {
      this.router.navigate(['/login']);
      window.location.reload();
    });       
      
    }
}