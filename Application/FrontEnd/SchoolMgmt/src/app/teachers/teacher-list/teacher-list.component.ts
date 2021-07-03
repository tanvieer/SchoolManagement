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
  public collectionSize : number = 0;

  constructor(public service: UsersService,
             private toastr : ToastrService ) { }

  ngOnInit(): void {
    this.service.getTeacherList()
    .subscribe((data: any) => {  
      if(data.Status == "SUCCESS"){
        this.parseData(data.Result);
      }
      else {
        this.toastr.success(data.Message, 'Teacher List');
      } 
      
    });
  } 

  parseData(jsonData: any) {
    //considering you get your data in json arrays  
    this.collectionSize = jsonData.length;
    for (let i = 0; i < this.collectionSize; i++) {
      const data = new Teacher();
      data.index = i;
      data.FullName = jsonData[i].FullName; 
      data.FirstName = jsonData[i].FirstName; 
      data.LastName = jsonData[i].LastName; 
      data.UserName = jsonData[i].UserName; 
      data.RoleName = jsonData[i].RoleName; 
      data.Email = jsonData[i].Email; 
      data.Id = jsonData[i].Id; 
      data.PhoneNumber = jsonData[i].PhoneNumber; 
      data.RoleId = jsonData[i].RoleId;  
      this.teacherList.push(data);
    } 
    //this.refreshTeachers();
  }


  refreshTeachers() {
    this.teachers = this.teacherList
      .map((data, i) => ({id: i + 1, ...data}))
      .slice((this.page - 1) * this.pageSize, (this.page - 1) * this.pageSize + this.pageSize);
  }

}
