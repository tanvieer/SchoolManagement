 
import { Injectable } from '@angular/core';
import { Teacher, JwtToken,statusResultL,statusResultO } from './teacher.model';
import {HttpClient, HttpHeaders} from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class TeacherService {
  
  formData!: Teacher; 
  _statusResultL!: statusResultL;
  _statusResultO!: statusResultO;
  _jwtToken!: JwtToken;
  _list : Teacher[] | undefined;

  readonly rootUrl = "https://localhost:44358/api/";

  constructor(private http : HttpClient) { }

  postTeacher(_formData : Teacher){
    //this.getTeacherList();
    _formData.RoleId = "1";
    _formData.make_by = "t";
    _formData.Password = _formData.UserName;
    _formData.Session = "C176404B75A146738D746ED47F6FB588";

    return this.http.post(this.rootUrl + 'User/Register',_formData);
    //  return this.http.post(this.rootUrl + 'User/Register', formData,
    //  {
    //    headers: new HttpHeaders({
    //         'Content-Type' : 'application/json', 
    //         'Access-Control-Allow-Headers' : 'Content-Type',
    //         'Access-Control-Allow-Origin': '*'
    //       })
    //  }); 

    // this.http.post(this.rootUrl + 'User/Register',_formData)
    // .toPromise().then(res => this._statusResultO as statusResultO);

  }

  async getTeacherList(){
     this._jwtToken.RoleId = "1";
     this._jwtToken.make_by = "t"; 
     this._jwtToken.Session = "C176404B75A146738D746ED47F6FB588";
     // console.log(_Session);
      const res = await this.http.post(this.rootUrl + 'User/GetUserList',this._jwtToken);
      console.log(await res);
      console.log("End");
      //  .
      //  toPromise().then(res => this._statusResultL as statusResultL);
      // console.log(this._statusResultL);
  }

  


}
