import { Component, OnInit } from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import { Teacher } from '../shared/models/teacher.model';
import { UsersService } from '../shared/users.service';

@Component({
  selector: 'app-pupils',
  templateUrl: './pupils.component.html',
  styleUrls: ['./pupils.component.css']
})
export class PupilsComponent implements OnInit {

  public studentList: Teacher[] = [];
  public students: Teacher[] = [];
  public pageSize: number = 10;
  public page: number = 1;
  public collectionSize: number = 0;
  public isAdmin: boolean = false;

  constructor(public service: UsersService,
    private toastr: ToastrService) {
    //console.log(localStorage.getItem('RoleName'));
    if (localStorage.getItem('RoleName') == "ADMIN") {
      this.isAdmin = true;
    }
    else this.isAdmin = false;
  }

  ngOnInit(): void { 
    this.refreshStudents();
  }

  parseData(jsonData: any) {
    //considering you get your data in json arrays  
    this.studentList = [];
    console.log(jsonData);
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
      data.AverageGrade = jsonData[i].AverageGrade;
      this.studentList.push(data);
    } 
  }


  refreshStudents() {
    this.service.getStudentList()
      .subscribe((data: any) => {
        console.log(data);
        if (data.Status == "SUCCESS") {
          this.parseData(data.Result);
        }
        else {
          this.toastr.error(data.Message, 'Student List');
        }

      });
  }


  deleteUser(userName : string){
    if (this.isAdmin == false) {
      return;
    }

    if(confirm("Are you sure to delete  '"+userName + "' !")) { 

      this.service.deleteUser(userName)
      .subscribe((data: any) => {  
        if(data.Status == "SUCCESS"){
          this.toastr.success(data.Message, 'Delete Student');
          this.refreshStudents();
        }
        else {
          this.toastr.error(data.Message, 'Delete Student');
        } ;
      });
    }
 }

}
