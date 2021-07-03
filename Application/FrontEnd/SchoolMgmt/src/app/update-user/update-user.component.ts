
import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { ActivatedRoute, Routes } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Role } from '../shared/models/login.model';
import { TucClass } from '../shared/models/tuc-class.model';
import { UsersService } from '../shared/users.service';

@Component({
  selector: 'app-update-user',
  templateUrl: './update-user.component.html',
  styleUrls: ['./update-user.component.css']
})
export class UpdateUserComponent implements OnInit {
  public roleList: Role[] = [];
  private _role!: Role;
  public classList: TucClass[] = []; 


  constructor(public service: UsersService,
    private toastr: ToastrService,
    private arouter: ActivatedRoute) { }

  ngOnInit(): void {
    //console.log(this.arouter.snapshot.params.id);
    this.resetForm();
    this.getUserInfo(this.arouter.snapshot.params.id);
  }

  parseData(jsonData: any) { 
    this.service.formData = {
      Id: jsonData.Id,
      index: 1,
      UserName: jsonData.UserName,
      Password: '',
      Email: jsonData.Email,
      FirstName: jsonData.FirstName,
      LastName: jsonData.LastName,
      PhoneNumber: jsonData.PhoneNumber,
      RoleId: jsonData.RoleId,
      ClassId: jsonData.ClassId,
      ClassName: jsonData.ClassName,
      FullName: jsonData.FullName,
      Session: '',
      SessionExpireTime: '',
      RoleName: jsonData.RoleName,
      Status: '',
      make_by: '',
      Maker_Time: ''
    }
   // console.log("After Parsing Data");
   // console.log(this.service.formData);
  }
  //this.refreshTeachers();



  getUserInfo(_userName: string) {
    this.service.getUserInfo(_userName)
      .subscribe((res: any) => {

        // this._statusResultO as statusResultO;
        //console.log(res);

        if (res.Status == "FAILED") {
          this.toastr.error(res.Message, 'Update User');
          this.resetForm();
        }
        else {
          this.parseData(res.Result);
        }
 

      });
  }


  initiateRoles() {
    this._role = new Role();
    this._role.RoleId = 1;
    this._role.RoleName = "ADMIN";
    this._role.RoleDes = "Responsiblity Admin";
    this.roleList.push(this._role);

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
    this.service.getClassList().subscribe((res : any)  =>{  
       if (res.Status == "SUCCESS"){
          this.parseClassData(res.Result);
       } 
       else {
         this.toastr.error(res.Message, 'User Update Error'); 
       } 
     });
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

    this.initiateRoles();
    this.initiateClass();
  }


  parseClassData(jsonData: any) { 
    console.log(jsonData);
    for (let i = 0; i < jsonData.length; i++) { 
      const data = new TucClass();
      data.ClassId = jsonData[i].ClassId; 
      data.ClassName = jsonData[i].ClassName; 
      this.classList.push(data);
    } 
    console.log("==========after loop========" + this.classList);


  }


  onSubmit(form : NgForm){ 
      //console.log(form.value);
      //console.log("===========Before Submit=======");
      this.service.updateUser(form.value,this.arouter.snapshot.params.id).subscribe((res : any)  =>{ 
        // this._statusResultO as statusResultO;
        // console.log(res.Message);
         if (res.Status == "SUCCESS"){
          this.toastr.success(res.Message, 'User Update Success');
          this.getUserInfo(this.arouter.snapshot.params.id);
         } 
         else {
           this.toastr.error(res.Message, 'User Update Error'); 
         }
         
       });
    }

}
