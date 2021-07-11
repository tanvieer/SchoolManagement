import { TucResult } from './../../shared/models/tuc-result.model';
import { Component, OnInit } from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import { OtherService } from 'src/app/shared/other.service';
import { UsersService } from 'src/app/shared/users.service';
import { TucTest } from 'src/app/shared/models/tuc-test.model';
import { TucSubject } from 'src/app/shared/models/tuc-subject.model';

@Component({
  selector: 'app-result-list',
  templateUrl: './result-list.component.html',
  styleUrls: ['./result-list.component.css']
})
export class ResultListComponent implements OnInit {

  public resultList: TucResult[] = [];
  public testList: TucTest[] = [];
  public subjectList: TucSubject[] = [];
  public selectedSubject : string = '';
  public selectedTest : string = '';
  
  constructor(public serviceUsers: UsersService,
    public serviceOthers: OtherService,
    private toastr: ToastrService) { }

  ngOnInit(): void {
    this.loadSubjectData();
  }



  loadSubjectData() {
    this.subjectList = [];
    this.serviceOthers.getSubjectListDDL()
      .subscribe((data: any) => {
        if (data.Status == "SUCCESS") {
          this.parseSubjectData(data.Result);
        }
        else {
          this.toastr.error(data.Message, 'Subject List');
        }
      });
  }

  
  parseSubjectData(jsonData: any) {
    //considering you get your data in json arrays  
    this.subjectList = [];
    let collectionSize = jsonData.length;
    if ( this.selectedSubject == '')
       this.selectedSubject = jsonData[0].SubjectId;

    this.loadTestData(this.selectedSubject);
    for (let i = 0; i < collectionSize; i++) {
      const data = new TucSubject();
      data.index = i + 1;
      data.ClassId = jsonData[i].ClassId;
      data.ClassName = jsonData[i].ClassName;
      data.SubjectId = jsonData[i].SubjectId;
      data.SubjectName = jsonData[i].SubjectName;
      data.TeacherId = jsonData[i].TeacherId;
      data.TeacherName = jsonData[i].TeacherName;
      data.TeacherUserName = jsonData[i].TeacherUserName;
      data.Status = jsonData[i].Status;
      this.subjectList.push(data);
    }
  }


  loadTestData(_subjectId: string) {
    //    alert(_subjectId);
    this.selectedSubject = _subjectId;
    this.testList = [];
    this.serviceOthers.getTestList(_subjectId)
      .subscribe((data: any) => {
        if (data.Status == "SUCCESS") {
          this.parseTestData(data.Result);
        }
        else {
          this.toastr.error(data.Message, 'Subject List');
        }
      });
  }



  parseTestData(jsonData: any) {
    console.log(jsonData);
    this.testList = [];

    if ( this.selectedTest == '')
       this.selectedTest = jsonData[0].TestId;

    this.loadResultData(this.selectedTest);
    let collectionSize = jsonData.length;
    for (let i = 0; i < collectionSize; i++) {
      const data = new TucTest();
      data.Index = i + 1;
      data.TestId = jsonData[i].TestId;
      data.TestName = jsonData[i].TestName;
      data.TestDate = jsonData[i].TestDateStr;
      data.SubjecName = jsonData[i].SubjecName;
      data.Status = jsonData[i].Status;
      this.testList.push(data);
    }
  }





  loadResultData (_id:string) {
    this.selectedTest = _id;
    this.resultList = [];
    this.serviceOthers.getResultListByTestId(_id)
    .subscribe((data: any) => {  
      if(data.Status == "SUCCESS"){
        this.parseResultData(data.Result);
      }
      else {
        this.toastr.error(data.Message, 'Result List');
      }  
    }); 
  }

  parseResultData(jsonData: any) {
    //considering you get your data in json arrays  
    this.resultList  = [];
    let collectionSize = jsonData.length;
    for (let i = 0; i < collectionSize; i++) {
      const data = new TucResult();
      data.Index = i+1;
      data.ClassId = jsonData[i].ClassId; 
      data.FirstName = jsonData[i].FirstName; 
      data.SubjectId = jsonData[i].SubjectId; 
      data.LastName = jsonData[i].LastName; 
      data.FullName = jsonData[i].FullName; 
      data.ResultId  = jsonData[i].ResultId; 
      data.TestId = jsonData[i].TestId;  
      data.TestName = jsonData[i].TestName; 
      data.Username = jsonData[i].Username;  
      data.Grade = jsonData[i].Grade; 
      data.Status = jsonData[i].Status;  
      this.resultList.push(data);
    } 
    console.log("Result Data");
    console.log(this.resultList);
  }
  
  onArchive(id:string){
    if(confirm("Are you sure to archive this result?")) { 

      this.serviceOthers.archiveResult(id)
      .subscribe((data: any) => {  
        if(data.Status == "SUCCESS"){
          this.toastr.success(data.Message, 'Archive Result');
          this.loadResultData(this.selectedTest);
        }
        else {
          this.toastr.error(data.Message, 'Archive Result');
        } ;
      });
    }
 }


  onDelete(id:string){
    if(confirm("Are you sure to delete this result?")) { 

      this.serviceOthers.deleteResult(id)
      .subscribe((data: any) => {  
        if(data.Status == "SUCCESS"){
          this.toastr.success(data.Message, 'Delete Result');
          this.loadResultData(this.selectedTest);
        }
        else {
          this.toastr.error(data.Message, 'Delete Result');
        } ;
      });
    }
 }

}
