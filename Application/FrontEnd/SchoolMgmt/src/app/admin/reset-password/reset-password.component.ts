import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { UsersService } from 'src/app/shared/users.service';

@Component({
  selector: 'app-reset-password',
  templateUrl: './reset-password.component.html',
  styleUrls: ['./reset-password.component.css']
})
export class ResetPasswordComponent implements OnInit {
   
   
  userName! : string;
    
  constructor(public service: UsersService,
    private toastr: ToastrService,
    private arouter: ActivatedRoute,
    private router: Router) {      
      this.userName = this.arouter.snapshot.params.id;
     }

  ngOnInit(): void {
    this.resetForm();
  }

  onSubmit(form : NgForm){ 
    //console.log(form.value);
    //console.log("===========Before Submit=======");
    this.service.resetPasswordByAdmin(form.value).subscribe((res : any)  =>{ 
      // this._statusResultO as statusResultO;
      // console.log(res.Message);
       if (res.Status == "SUCCESS"){
        this.toastr.success(res.Message, 'Reset Password'); 
        this.router.navigate(['/teacher-list']);
       } 
       else {
         this.toastr.error(res.Message, 'Reset Password'); 
       }
       
     });
  }
  
  resetForm(form?: NgForm) {

    if (form != null)
      form.resetForm();

    this.service.formData_ResetPass = { 
      Username: this.userName,
      Password: ''   
    }
 
  }

}
