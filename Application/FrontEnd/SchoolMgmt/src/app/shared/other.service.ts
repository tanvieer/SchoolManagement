import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Config } from '../config';
import { TucClass } from './models/tuc-class.model'; 
import { TucSubject } from './models/tuc-subject.model';
import { TucTest } from './models/tuc-test.model';

@Injectable({
  providedIn: 'root'
})
export class OtherService {

  formData_class!: TucClass;  
  formData_Subject!: TucSubject;  
  formData_Test!: TucTest;

  config = new Config();
  constructor(private http : HttpClient) {   
  }


  getClassList(){  
    return this.http.get(`${this.config.url}/Class/GetClassList`,this.config.httpOptions);  
  }

  getClassInfo(_id:number){  
    return this.http.get(`${this.config.url}/Class/GetClassInfo?id=${_id}`,this.config.httpOptions);  
  }

  deleteClass(_id:string){  
    return this.http.delete(`${this.config.url}/Class/DeleteClass?id=${_id}`,this.config.httpOptions);  
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

  getSubjectListDDL(){  
    return this.http.get(`${this.config.url}/Subject/GetSubjectListDDL`,this.config.httpOptions);  
  }

  getSubjectInfo(_id:string){  
    return this.http.get(`${this.config.url}/Subject/GetSubjectInfo?id=${_id}`,this.config.httpOptions);  
  }

  deleteSubject(_id:string){  
    return this.http.delete(`${this.config.url}/Subject/DeleteSubject?id=${_id}`,this.config.httpOptions);  
  }



  modifySubject(_formData : TucSubject, _subject_id: string){  
    _formData.SubjectId = _subject_id;
    return this.http.post(`${this.config.url}/Subject/ModifySubjectInfo`,_formData,this.config.httpOptions);  
  
  }

  addNewSubject(_formData : TucSubject){  
    return this.http.post(`${this.config.url}/Subject/AddNewSubject`,_formData,this.config.httpOptions);  
  }

  archiveSubject(_id : string){
    return this.http.delete(`${this.config.url}/Subject/ArchiveSubject?id=${_id}`,this.config.httpOptions);  
   }


  /************************************** */
 





  getTestList(_subjectId:string){  
    return this.http.get(`${this.config.url}/Test/GetTestList?subjectId=${_subjectId}`,this.config.httpOptions);  
  }

  getTestInfo(_id:string){  
    return this.http.get(`${this.config.url}/Test/GetTestInfo?testId=${_id}`,this.config.httpOptions);  
  }

  deleteTest(_id:string){  
    return this.http.delete(`${this.config.url}/Test/DeleteTest?id=${_id}`,this.config.httpOptions);  
  }



  modifyTest(_formData : TucTest){  
    return this.http.post(`${this.config.url}/Test/ModifyTestInfo`,_formData,this.config.httpOptions);  
  
  }

  addNewTest(_formData : TucTest){  
    return this.http.post(`${this.config.url}/Test/AddNewTest`,_formData,this.config.httpOptions);  
  }
   
  archiveClass(_id : string){
    return this.http.delete(`${this.config.url}/Class/ArchiveClass?id=${_id}`,this.config.httpOptions);  
  }

}
