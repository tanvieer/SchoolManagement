import { ChangePassword, Login } from './models/login.model';

import { Injectable } from '@angular/core';
import { Teacher } from './models/teacher.model';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Config } from '../config';

@Injectable({
  providedIn: 'root'
})
export class UsersService {

  formData!: Teacher;
  formData_ResetPass!: Login;
  formData_ChangePass!: ChangePassword;
  config = new Config();

  constructor(private http: HttpClient) {

  }
  
  resetPasswordByAdmin(_formData: Login) {   
    return this.http.post(`${this.config.url}/User/ResetPassword`, _formData, this.config.httpOptions);
  }

  changePassword(_formData: ChangePassword) {   
    return this.http.post(`${this.config.url}/User/ChangePassword`, _formData, this.config.httpOptions);
  }

  postTeacher(_formData: Teacher) {
    _formData.make_by = localStorage.getItem("UserName") ?? "admin";
    if (_formData.Password == "") {
      _formData.Password = _formData.UserName;
    }
    _formData.Session = localStorage.getItem("Token") ?? "";
    // return this.http.post(this.rootUrl + 'User/Register',_formData);   
    return this.http.post(`${this.config.url}/User/Register`, _formData, this.config.httpOptions);
  }

  updateUser(_formData: Teacher, _userName: string) {
    _formData.make_by = localStorage.getItem("UserName") ?? "admin";
    _formData.UserName = _userName;
    if (_formData.Password == "") {
      _formData.Password = _formData.UserName;
    }
    _formData.Session = localStorage.getItem("Token") ?? "";
    return this.http.post(`${this.config.url}/User/UpdateUser`, _formData, this.config.httpOptions);

  }

  getTeacherList() {
    return this.http.get(`${this.config.url}/User/GetUserList?userType=2`, this.config.httpOptions);
  }

  getStudentList() {
    return this.http.get(`${this.config.url}/User/GetUserList?userType=3`, this.config.httpOptions);
  }

  getAllUserList() {
    return this.http.get(`${this.config.url}/User/GetUserList?userType=0`, this.config.httpOptions);
  }

  getUserInfo(_userName: string) {
    return this.http.get(`${this.config.url}/User/Get?id=${_userName}`, this.config.httpOptions);
  }

  deleteUser(_id: string) {
    return this.http.delete(`${this.config.url}/User/DeleteUser?userName=${_id}`, this.config.httpOptions);
  }


  getClassList() {
    return this.http.get(`${this.config.url}/Class/GetClassList`, this.config.httpOptions);
  }


}
