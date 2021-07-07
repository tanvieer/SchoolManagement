import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { Role } from '../shared/models/login.model';
import { TucClass } from '../shared/models/tuc-class.model';
import { UsersService } from '../shared/users.service';

@Component({
  selector: 'app-create-user',
  templateUrl: './create-user.component.html',
  styleUrls: ['./create-user.component.css']
})
export class CreateUserComponent implements OnInit {

  public roleList: Role[] = [];
  private _role!: Role;
  public classList: TucClass[] = [];
  private _class!: TucClass;

  constructor(public service: UsersService,
    private toastr: ToastrService) { 
      
    this.initiateRoles();
    this.initiateClass();

  }

  ngOnInit(): void {
    this.resetForm();

  }

  initiateRoles() {
    this._role = new Role();
    this._role.RoleId = 2;
    this._role.RoleName = "TEACHER";
    this._role.RoleDes = "Responsiblity Teacher";
    this.roleList.push(this._role);

    this._role = new Role();
    this._role.RoleId = 3;
    this._role.RoleName = "STUDENT";
    this._role.RoleDes = "Responsiblity Student";
    this.roleList.push(this._role);
  }

  initiateClass() {
    this._class = new TucClass();
    this._class.ClassId = '1';
    this._class.ClassName = "Class 1";
    this.classList.push(this._class);

    this._class = new TucClass();
    this._class.ClassId = '2';
    this._class.ClassName = "Class 2";
    this.classList.push(this._class);

    this._class = new TucClass();
    this._class.ClassId = '3';
    this._class.ClassName = "Class 3";
    this.classList.push(this._class);
  }


  resetForm(form?: NgForm) {

    if (form != null)
      form.resetForm();

    this.service.formData = {
      Id: '',
      index: 1,
      UserName: '',
      Password: '',
      Email: '',
      FirstName: '',
      LastName: '',
      PhoneNumber: '',
      RoleId: 2,
      ClassId: 1,
      ClassName: '',
      FullName: '',
      Session: '',
      SessionExpireTime: '',
      RoleName: '',
      Status: '',
      make_by: '',
      Maker_Time: ''
    }
  }

  onSubmit(form: NgForm) {
    // await this.service.getTeacherList();
    this.insertRecord(form);
  }

  insertRecord(form: NgForm) {
    this.service.postTeacher(form.value)
      .subscribe((res: any) => {
        // this._statusResultO as statusResultO;
        // console.log(res.Message);
        if (res.Status == "SUCCESS")
          this.toastr.success(res.Message, 'Teacher Register');
        else this.toastr.error(res.Message, 'Teacher Register');
        this.resetForm();
      });
  }


}
