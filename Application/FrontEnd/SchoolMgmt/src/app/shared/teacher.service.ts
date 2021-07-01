import { Injectable } from '@angular/core';
import { Teacher } from './teacher.model';
import {HttpClient, HttpHeaders} from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class TeacherService {
  
  formData!: Teacher; 
  readonly rootUrl = "https://localhost:44358/api/";

  constructor(private http : HttpClient) { }

  postTeacher(formData : Teacher){
   // return this.http.post(this.rootUrl + 'User/Register',formData);

    return this.http.post(this.rootUrl + 'User/Register', formData,
    {
      headers: new HttpHeaders({
           'Content-Type' : 'application/json', 
           'Access-Control-Allow-Headers' : 'Content-Type',
           'Access-Control-Allow-Origin': '*'
         })
    });


  }

  


}
