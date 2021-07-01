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
   this.insertRecord(form);
 }

 insertRecord(form: NgForm){
    this.service.postTeacher(form.value).subscribe(res =>{
      this.toastr.success('Inserted Successfully', 'Teacher Register');
      this.resetForm();
    });
 }




}
