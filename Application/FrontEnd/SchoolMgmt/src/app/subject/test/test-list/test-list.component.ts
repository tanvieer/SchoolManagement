import { TucTest } from './../../../shared/models/tuc-test.model';
import { Component, OnInit } from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import { OtherService } from 'src/app/shared/other.service';
import { UsersService } from 'src/app/shared/users.service';
import { TucSubject } from 'src/app/shared/models/tuc-subject.model';

@Component({
  selector: 'app-test-list',
  templateUrl: './test-list.component.html',
  styleUrls: ['./test-list.component.css']
})
export class TestListComponent implements OnInit {

  public testList: TucTest[] = [];
  public subjectList: TucSubject[] = [];
  public selectedSubject! : string;
  constructor(public serviceUsers: UsersService,
    public serviceOthers: OtherService,
    private toastr: ToastrService) { }

  ngOnInit(): void {
    this.loadSubjectData();
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



  

  onArchive(id:string){
    if(confirm("Are you sure to archive this test?")) { 

      this.serviceOthers.archiveTest(id)
      .subscribe((data: any) => {  
        if(data.Status == "SUCCESS"){
          this.toastr.success(data.Message, 'Archive Test');
          this.loadTestData(this.selectedSubject);
        }
        else {
          this.toastr.error(data.Message, 'Archive Test');
        } ;
      });
    }
 }


  onDelete(id:string){
    if(confirm("Are you sure to delete this test?")) { 

      this.serviceOthers.deleteTest(id)
      .subscribe((data: any) => {  
        if(data.Status == "SUCCESS"){
          this.toastr.success(data.Message, 'Delete Test');
          this.loadTestData(this.selectedSubject);
        }
        else {
          this.toastr.error(data.Message, 'Delete Test');
        } ;
      });
    }
 }

}
