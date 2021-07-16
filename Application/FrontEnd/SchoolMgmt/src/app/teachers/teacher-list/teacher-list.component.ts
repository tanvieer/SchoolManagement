import { Teacher } from '../../shared/models/teacher.model';
import { Component, OnInit } from '@angular/core';
import { UsersService } from 'src/app/shared/users.service';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-teacher-list',
  templateUrl: './teacher-list.component.html',
  styleUrls: ['./teacher-list.component.css']
})


export class TeacherListComponent implements OnInit {
  public teacherList: Teacher[] = [];
  public teachers: Teacher[] = [];
  public pageSize: number = 10;
  public page: number = 1;
  public collectionSize: number = 0;
  public isAdmin: boolean = false;

  constructor(public service: UsersService,
    private toastr: ToastrService) {
    // console.log(localStorage.getItem('RoleName') );
    if (localStorage.getItem('RoleName') == "ADMIN") {
      this.isAdmin = true;
    }
    else this.isAdmin = false;
  }

  ngOnInit(): void {
    this.refreshTeachers();
  }

  parseData(jsonData: any) {
    //considering you get your data in json arrays  
    this.teacherList = [];
    this.collectionSize = jsonData.length;
    for (let i = 0; i < this.collectionSize; i++) {
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
      this.teacherList.push(data);
    }
    //this.refreshTeachers();
  }


  refreshTeachers() {
    this.service.getTeacherList()
      .subscribe((data: any) => {
        if (data.Status == "SUCCESS") {
          this.parseData(data.Result);
        }
        else {
          this.toastr.error(data.Message, 'Teacher List');
        }

      });
  }


  deleteUser(userName : string){
    if(confirm("Are you sure to delete  '"+userName + "' !")) {
      console.log("Implement delete functionality here");

      this.service.deleteUser(userName)
      .subscribe((data: any) => {  
        if(data.Status == "SUCCESS"){
          this.toastr.success(data.Message, 'Delete Teacher');
          this.refreshTeachers();
        }
        else {
          this.toastr.error(data.Message, 'Delete Teacher');
        } ;
      });
    }
 }

}
