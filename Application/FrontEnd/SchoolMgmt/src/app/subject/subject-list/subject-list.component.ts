import { TucSubject } from './../../shared/models/tuc-subject.model';
import { Component, OnInit } from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import { Teacher } from 'src/app/shared/models/teacher.model';
import { OtherService } from 'src/app/shared/other.service';
import { UsersService } from 'src/app/shared/users.service';

@Component({
  selector: 'app-subject-list',
  templateUrl: './subject-list.component.html',
  styleUrls: ['./subject-list.component.css']
})
export class SubjectListComponent implements OnInit {
  
  public teacherList: Teacher[] = [];
  public subjectList: TucSubject[] = [];


  constructor(public serviceUsers: UsersService,
              public serviceOthers: OtherService,
              private toastr : ToastrService) {

     // this.loadTeachers();
     }

  ngOnInit(): void { 
    this.loadSubjectData();
  }


  loadSubjectData () {
    this.subjectList = [];
    this.serviceOthers.getSubjectList()
    .subscribe((data: any) => {  
      if(data.Status == "SUCCESS"){
        this.parseSubjectData(data.Result);
      }
      else {
        this.toastr.error(data.Message, 'Subject List');
      }  
    });
  }





  // loadTeachers(){
  //   this.serviceUsers.getTeacherList()
  //   .subscribe((data: any) => {  
  //     if(data.Status == "SUCCESS"){
  //       this.parseTeacherData(data.Result);
  //     }
  //     else {
  //       this.toastr.error(data.Message, 'Teacher List');
  //     } 
      
  //   });
  // }

  
  parseTeacherData(jsonData: any) {
    //considering you get your data in json arrays  
    this.teacherList  = [];
    let collectionSize = jsonData.length;
    for (let i = 0; i < collectionSize; i++) {
      const data = new Teacher();
      data.index = i+1;
      data.FullName = jsonData[i].FullName; 
      data.FirstName = jsonData[i].FirstName; 
      data.LastName = jsonData[i].LastName; 
      data.UserName = jsonData[i].UserName; 
      data.RoleName = jsonData[i].RoleName; 
      data.ClassId  = jsonData[i].ClassId; 
      data.ClassName = jsonData[i].ClassName; 
      data.Email = jsonData[i].Email; 
      data.Id = jsonData[i].Id; 
      data.PhoneNumber = jsonData[i].PhoneNumber; 
      data.RoleId = jsonData[i].RoleId;  
      this.teacherList.push(data);
    } 
  }


  
  parseSubjectData(jsonData: any) {
    //considering you get your data in json arrays  
    this.subjectList  = [];
    let collectionSize = jsonData.length;
    for (let i = 0; i < collectionSize; i++) {
      const data = new TucSubject();
      data.index = i+1;
      data.ClassId = jsonData[i].ClassId; 
      data.ClassName = jsonData[i].ClassName; 
      data.SubjectId = jsonData[i].SubjectId; 
      data.SubjectName = jsonData[i].SubjectName; 
      data.TeacherId = jsonData[i].TeacherId; 
      data.TeacherName  = jsonData[i].TeacherName; 
      data.TeacherUserName = jsonData[i].TeacherUserName;  
      data.Status = jsonData[i].Status;  
      this.subjectList.push(data);
    } 
  }
  

  onArchive(id:string){
    if(confirm("Are you sure to archive this subject?")) { 

      this.serviceOthers.archiveSubject(id)
      .subscribe((data: any) => {  
        if(data.Status == "SUCCESS"){
          this.toastr.success(data.Message, 'Archive Subject');
          this.loadSubjectData();
        }
        else {
          this.toastr.error(data.Message, 'Archive Subject');
        } ;
      });
    }
 }


  onDelete(id:string){
    if(confirm("Are you sure to delete this subject?")) { 

      this.serviceOthers.deleteSubject(id)
      .subscribe((data: any) => {  
        if(data.Status == "SUCCESS"){
          this.toastr.success(data.Message, 'Delete Subject');
          this.loadSubjectData();
        }
        else {
          this.toastr.error(data.Message, 'Delete Subject');
        } ;
      });
    }
 }
 

}
