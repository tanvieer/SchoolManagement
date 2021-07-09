import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Teacher } from 'src/app/shared/models/teacher.model';
import { TucClass } from 'src/app/shared/models/tuc-class.model';
import { OtherService } from 'src/app/shared/other.service';
import { UsersService } from 'src/app/shared/users.service';

@Component({
  selector: 'app-subject-edit',
  templateUrl: './subject-edit.component.html',
  styleUrls: ['./subject-edit.component.css']
})
export class SubjectEditComponent implements OnInit {
  
  public teacherList: Teacher[] = [];
  public classList: TucClass[] = [];  
  private subject_id!: string ;

  constructor(public serviceUsers: UsersService,
    public serviceOthers: OtherService,
    private toastr : ToastrService,
    private arouter: ActivatedRoute,
    private router: Router) { }

    ngOnInit(): void {
      this.resetForm();
      this.loadClass();
      this.loadTeachers();
      this.subject_id = this.arouter.snapshot.params.id;
      this.getSubjectInfo(this.subject_id);
    }


    loadClass() {
      this.classList = [];
      this.serviceOthers.getClassList()
      .subscribe((data: any) => {  
        if(data.Status == "SUCCESS"){
          this.parseClassData(data.Result);
        }
        else {
          this.toastr.error(data.Message, 'Class List');
        }  
      });
    }
  
    loadTeachers(){
      this.serviceUsers.getTeacherList()
      .subscribe((data: any) => {  
        if(data.Status == "SUCCESS"){
          this.parseTeacherData(data.Result);
        }
        else {
          this.toastr.error(data.Message, 'Teacher List');
        } 
        
      });
    }
  
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
      this.updateRecord(form);
    }
  
    updateRecord(form: NgForm) {
      this.serviceOthers.modifySubject(form.value,this.subject_id)
      .subscribe((res: any) => { 
        if (res.Status == "SUCCESS"){
          this.toastr.success(res.Message, 'Edit Subject');
          this.router.navigate(['/subject-list']);
        } 
        else this.toastr.error(res.Message, 'Edit Subject'); 
      });
    }
  
  
    resetForm(form?: NgForm) {
  
      if (form != null)
        form.resetForm();
  
      this.serviceOthers.formData_Subject = {
        index : 0,
        SubjectId : '',
        SubjectName: '',
        TeacherId!: '',
        TeacherUserName: '',
        TeacherName: '',
        ClassId: '',
        ClassName: '',
        Status: ''
      }
    }
  
  
    getSubjectInfo(_subjectId: string) {
      this.serviceOthers.getSubjectInfo(_subjectId)
        .subscribe((res: any) => { 
          if (res.Status == "FAILED") {
            this.toastr.error(res.Message, 'Class Edit');
            this.resetForm();
          }
          else { 
            this.parseSubjectData(res.Result); 
          } 
        });
    }

    parseSubjectData(jsonData: any) {  
      this.serviceOthers.formData_Subject = { 
        index: 1, 
        SubjectId: jsonData.SubjectId,
        SubjectName: jsonData.SubjectName ,
        TeacherId: jsonData.TeacherId ,
        TeacherUserName: jsonData.TeacherUserName ,
        TeacherName: jsonData.TeacherName ,
        ClassId: jsonData.ClassId ,
        ClassName: jsonData.ClassName,
        Status : jsonData.Status
      } 
     // console.log(this.serviceOthers.formData_Subject);
    }
 
  }