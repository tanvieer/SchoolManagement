import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { UsersService } from 'src/app/shared/users.service';

@Component({
  selector: 'app-change-password',
  templateUrl: './change-password.component.html',
  styleUrls: ['./change-password.component.css']
})
export class ChangePasswordComponent implements OnInit {
  userName!: string;
  constructor(public service: UsersService,
    private router : Router,
    private toastr: ToastrService) {
    console.log(localStorage.getItem("UserName"));
    this.userName = localStorage.getItem("UserName") ?? "";
  }



  ngOnInit(): void {
    this.resetForm();
  }

  onSubmit(form: NgForm) {
    //console.log(form.value);
    //console.log("===========Before Submit=======");

    form.value.Username = this.userName;

    this.service.changePassword(form.value).subscribe((res: any) => {
      // this._statusResultO as statusResultO;
      // console.log(res.Message);
      if (res.Status == "SUCCESS") {
        this.toastr.success(res.Message, 'Change Password');
        this.router.navigate(['/logout']);
      }
      else {
        this.toastr.error(res.Message, 'Change Password');
      }

    });
  }

  resetForm(form?: NgForm) {

    if (form != null)
      form.resetForm();

    this.service.formData_ChangePass = {
      Username: this.userName,
      OldPassword: '',
      NewPassword: '',
      ConfirmPassword: ''
    }

  }

}
