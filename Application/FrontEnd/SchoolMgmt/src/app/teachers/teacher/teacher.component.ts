 
import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { ToastrService } from 'ngx-toastr'; 
import { TeacherService } from 'src/app/shared/teacher.service';


@Component({
  selector: 'app-teacher',
  templateUrl: './teacher.component.html',
  styleUrls: ['./teacher.component.css']
})
export class TeacherComponent implements OnInit {
 // private _statusResultO: statusResultO;

  constructor(public service : TeacherService, 
              private toastr : ToastrService ) { }

  ngOnInit(): void {
    this.resetForm();
  }

  resetForm(form? : NgForm){
    if(form != null)
      form.resetForm();
      this.service.formData = {
        Id: '',     
        UserName: '',    
        Password: '',    
        Email: '',    
        FirstName: '',    
        LastName: '',    
        PhoneNumber: '',    
        RoleId: '2',
        FullName:'',
        Session: '',    
        SessionExpireTime: '',    
        RoleName: '',    
        Status: '',    
        make_by: '',    
        Maker_Time: ''
      }       
  }

  onSubmit(form : NgForm){
 // await this.service.getTeacherList();
   this.insertRecord(form);
 }

 insertRecord(form: NgForm){ 
    this.service.postTeacher(form.value).subscribe((res : any)  =>{
      
     // this._statusResultO as statusResultO;
      console.log(res.Message);

      localStorage.setItem('currentUser', JSON.stringify(res));

      this.toastr.success(res.Message, 'Teacher Register');

      this.resetForm();
    });
 }




}
