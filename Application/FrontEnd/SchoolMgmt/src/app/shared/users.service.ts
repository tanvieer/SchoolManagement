 
import { Injectable } from '@angular/core';
import { Teacher, JwtToken } from './models/teacher.model';
import {HttpClient, HttpHeaders} from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class UsersService {
  
  formData!: Teacher;  
  _jwtToken!: JwtToken; 

  readonly rootUrl = "https://localhost:44358/api/";

  constructor(private http : HttpClient) {
    this._jwtToken = new JwtToken();

   }


  postTeacher(_formData : Teacher){ 
    _formData.make_by = localStorage.getItem("UserName")?? "admin"; 
    if(_formData.Password == "") {
      _formData.Password = _formData.UserName;
    } 
    _formData.Session = localStorage.getItem("Token")?? "";  
    return this.http.post(this.rootUrl + 'User/Register',_formData);  
  }

  updateUser(_formData : Teacher){ 
    _formData.make_by = localStorage.getItem("UserName")?? "admin"; 
    if(_formData.Password == "") {
      _formData.Password = _formData.UserName;
    } 
    _formData.Session = localStorage.getItem("Token")?? "";  
    return this.http.post(this.rootUrl + 'User/UpdateUser',_formData);  
  }

  getTeacherList(){ 
     this._jwtToken.RoleId = "2";
     this._jwtToken.make_by = "t"; 
     this._jwtToken.Session = localStorage.getItem("Token")?? ""; 
     return this.http.post(this.rootUrl + 'User/GetUserList',this._jwtToken);  
  }

  getStudentList(){ 
    this._jwtToken.RoleId = "3";
    this._jwtToken.make_by = "t"; 
    this._jwtToken.Session = localStorage.getItem("Token")?? ""; 
    return this.http.post(this.rootUrl + 'User/GetUserList',this._jwtToken);  
 }

 getAllUserList(){ 
  this._jwtToken.RoleId = "0";
  this._jwtToken.make_by = "t"; 
  this._jwtToken.Session = localStorage.getItem("Token")?? ""; 
  return this.http.post(this.rootUrl + 'User/GetUserList',this._jwtToken);  
}
 

}
