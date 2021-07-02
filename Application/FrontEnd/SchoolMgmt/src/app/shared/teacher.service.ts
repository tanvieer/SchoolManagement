 
import { Injectable } from '@angular/core';
import { Teacher, JwtToken } from './teacher.model';
import {HttpClient, HttpHeaders} from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class TeacherService {
  
  formData!: Teacher;  
  _jwtToken!: JwtToken; 

  readonly rootUrl = "https://localhost:44358/api/";

  constructor(private http : HttpClient) {
    this._jwtToken = new JwtToken();

   }

  postTeacher(_formData : Teacher){
    //this.getTeacherList();
    _formData.RoleId = "1";
    _formData.make_by = "t";
    _formData.Password = _formData.UserName;
    _formData.Session = localStorage.getItem("Token")?? "";

    return this.http.post(this.rootUrl + 'User/Register',_formData); 

  }

  getTeacherList(){ 
     this._jwtToken.RoleId = "2";
     this._jwtToken.make_by = "t"; 
     this._jwtToken.Session = localStorage.getItem("Token")?? ""; 
     return this.http.post(this.rootUrl + 'User/GetUserList',this._jwtToken);  
  }

  


}
