import { Injectable } from '@angular/core';
import { Login, statusResultO } from './login.model';
import {HttpClient} from '@angular/common/http';
import { ToastrService } from 'ngx-toastr'; 


@Injectable({
  providedIn: 'root'
})
export class LoginService {
  
  formData!: Login;
  _statusResultO!: statusResultO;
  readonly rootUrl = "https://localhost:44358/api/Login";

 
  constructor(private http : HttpClient, 
              private toastr : ToastrService) { }

  Login(_formData:Login){
    this.http.post(this.rootUrl ,_formData) 
    .subscribe((res : any)  =>{
       
      //console.log(res);
       
      if(res.Status == "SUCCESS") {
        localStorage.setItem('session', res.Result.Token);
        localStorage.setItem('Email',   res.Result.Email);
        localStorage.setItem('RoleName',res.Result.RoleName);
        localStorage.setItem('Name', res.Result.FirstName + " " + res.Result.LastName); 
        this.toastr.success(res.Message, 'Login Success');
      }
      else this.toastr.error(res.Message, 'Login Failed');
       
        

     });
  }

}
