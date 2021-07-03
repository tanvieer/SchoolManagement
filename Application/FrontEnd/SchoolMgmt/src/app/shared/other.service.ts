import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Config } from '../config';
import { TucClass } from './models/tuc-class.model';
import { TucSubject } from './models/tuc-subject.model';

@Injectable({
  providedIn: 'root'
})
export class OtherService {
  config = new Config();
  constructor(private http : HttpClient) {  
  }


  getClassList(){  
    return this.http.get(`${this.config.url}/Class/GetClassList`,this.config.httpOptions);  
  }

  getClassInfo(_id:string){  
    return this.http.get(`${this.config.url}/Class/GetClassInfo?id=${_id}`,this.config.httpOptions);  
  }

  deleteClass(_id:string){  
    return this.http.get(`${this.config.url}/Class/DeleteClass?id=${_id}`,this.config.httpOptions);  
  }



  modifyClass(_formData : TucClass){  
    return this.http.post(`${this.config.url}/Class/ModifyClassInfo`,_formData,this.config.httpOptions);  
  
  }

  addNewClass(_formData : TucClass){  
    return this.http.post(`${this.config.url}/Class/AddNewClass`,_formData,this.config.httpOptions);  
  }


  /********************************************* */


  

  getSubjectList(){  
    return this.http.get(`${this.config.url}/Subject/GetSubjectList`,this.config.httpOptions);  
  }

  getSubjectInfo(_id:string){  
    return this.http.get(`${this.config.url}/Subject/GetSubjectInfo?id=${_id}`,this.config.httpOptions);  
  }

  deleteSubject(_id:string){  
    return this.http.get(`${this.config.url}/Subject/DeleteSubject?id=${_id}`,this.config.httpOptions);  
  }



  modifySubject(_formData : TucSubject){  
    return this.http.post(`${this.config.url}/Subject/ModifySubjectInfo`,_formData,this.config.httpOptions);  
  
  }

  addNewSubject(_formData : TucSubject){  
    return this.http.post(`${this.config.url}/Subject/AddNewSubject`,_formData,this.config.httpOptions);  
  }


 /* 
 
 POST api/Subject/GetSubjectList	
No documentation available.

GET api/Subject/GetSubjectInfo?id={id}	
No documentation available.

POST api/Subject/ModifySubjectInfo	
No documentation available.

POST api/Subject/AddNewSubject	
No documentation available.

DELETE api/Subject/DeleteSubject?id={id}	
No documentation available.

POST api/Subject/ClassSubjectMap	
No documentation available.

DELETE api/Subject/ClassSubjectMapRemove?classId={classId}&subjectId={subjectId}
 
 
 
 */


}
