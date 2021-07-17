import { UsersService } from 'src/app/shared/users.service';
import { Teacher } from 'src/app/shared/models/teacher.model';
import { TucClass } from './../../shared/models/tuc-class.model';

import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { TucResult } from 'src/app/shared/models/tuc-result.model';
import { TucSubject } from 'src/app/shared/models/tuc-subject.model';
import { TucTest } from 'src/app/shared/models/tuc-test.model';
import { OtherService } from 'src/app/shared/other.service';

@Component({
  selector: 'app-result-create',
  templateUrl: './result-create.component.html',
  styleUrls: ['./result-create.component.css']
})
export class ResultCreateComponent implements OnInit {

  public resultModel: TucResult = new TucResult();
  public testList: TucTest[] = [];
  public classList: TucClass[] = [];
  public studentList: Teacher[] = [];
  public subjectList: TucSubject[] = [];
  public selectedSubject!: string;
  public selectedTest!: string; 
  public selectedClassId!: string; 
  constructor(
    public service: UsersService,
    public serviceOthers: OtherService,
    private toastr: ToastrService) { }

  ngOnInit(): void {
    this.loadSubjectData(); 
  }

  onSubjectChange(_id: string) {
    this.selectedSubject = _id;
    this.loadTestData(this.selectedSubject);
    this.loadClass(this.selectedSubject);
  }
  onTestChange(_id: string) {
    this.selectedTest = _id;
  }
  onClassChange(_id: string) {
    this.selectedClassId = _id;
    this.loadStudentData(this.selectedClassId); //getStudentListByClssId
  }

  loadStudentData(id : string): void {
    this.service.getStudentListByClssId(id)
      .subscribe((data: any) => {
        if (data.Status == "SUCCESS") {
          this.parseData(data.Result);
        }
        else {
          this.toastr.error(data.Message, 'Student List');
        }

      });
  }


  
  parseData(jsonData: any) {
    //considering you get your data in json arrays  
    this.studentList = [];
    let collectionSize = jsonData.length;
    for (let i = 0; i < collectionSize; i++) {
      const data = new Teacher();
      data.index = i + 1;
      data.FullName = jsonData[i].FullName;
      data.FirstName = jsonData[i].FirstName;
      data.LastName = jsonData[i].LastName;
      data.UserName = jsonData[i].UserName;
      data.RoleName = jsonData[i].RoleName;
      data.ClassId = jsonData[i].ClassId;
      data.ClassName = jsonData[i].ClassName;
      data.Email = jsonData[i].Email;
      data.Id = jsonData[i].Id;
      data.PhoneNumber = jsonData[i].PhoneNumber;
      data.RoleId = jsonData[i].RoleId;
      data.AverageGrade = jsonData[i].AverageGrade;
      this.studentList.push(data);
    }
    //this.refreshTeachers();
  }


  loadTestData(_subjectId: string) {
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

 //getClassListBySubject

  parseTestData(jsonData: any) {
    console.log(jsonData);
    this.testList = [];
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


  parseSubjectData(jsonData: any) {
    //considering you get your data in json arrays  
    this.subjectList = [];
    let collectionSize = jsonData.length;
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

  loadClass(subjectId : string) {
    this.classList = [];
    this.serviceOthers.getClassListBySubject(subjectId)
    .subscribe((data: any) => {  
      if(data.Status == "SUCCESS"){
        this.parseClassData(data.Result);
      }
      else {
        this.toastr.error(data.Message, 'Class List');
      }  
    });
  }
  parseClassData(jsonData: any) {  
    let collectionSize = jsonData.length;
    for (let i = 0; i < collectionSize; i++) {
      const data = new TucClass();
      data.Index = i+1; 
      data.ClassId  = jsonData[i].ClassId; 
      data.ClassName = jsonData[i].ClassName;       
      this.classList.push(data);
    }  
  }

  
  onSubmit(form: NgForm) { 
    // console.log(form.value);
     this.insertRecord(form);
   }
 
   insertRecord(form: NgForm) {
    this.resultModel = new TucResult();
    this.resultModel = form.value;
    //this.resultModel.ClassId = this.selectedClassId;
   // this.resultModel.TestId = this.selectedTest;
    console.log("before api call");
    console.log(this.resultModel);
    console.log("=============");


     this.serviceOthers.addNewResult(this.resultModel)
       .subscribe((res: any) => {  
         console.log(res);
         if (res.Status == "SUCCESS"){
          this.toastr.success(res.Message, 'Create Result');
          this.resetForm();
         } 
         else this.toastr.error(res.Message, 'Create Result');
         
       });
   }
 
 
  resetForm(form?: NgForm) {

    if (form != null)
      form.resetForm();

    this.serviceOthers.formData_Result = {
      Index : 1,
      ResultId : '',
      TestId: '',
      TestName: '',
      Grade: 0,
      Status: 'ACTIVE',
      StudentId: '',
      SubjectId: '',
      ClassId: '',
      Username : '',
      FirstName : '',
      LastName : '',
      FullName : '' 
    }
  }


  onArchive(id: string) {
    if (confirm("Are you sure to archive this test?")) {

      this.serviceOthers.archiveResult(id)
        .subscribe((data: any) => {
          if (data.Status == "SUCCESS") {
            this.toastr.success(data.Message, 'Archive Result');
            this.loadTestData(this.selectedSubject);
          }
          else {
            this.toastr.error(data.Message, 'Archive Result');
          };
        });
    }
  }


  onDelete(id: string) {
    if (confirm("Are you sure to delete this result?")) {

      this.serviceOthers.deleteResult(id)
        .subscribe((data: any) => {
          if (data.Status == "SUCCESS") {
            this.toastr.success(data.Message, 'Delete Result');
            this.loadTestData(this.selectedSubject);
          }
          else {
            this.toastr.error(data.Message, 'Delete Result');
          };
        });
    }
  }

}
