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
  public collectionSize : number = 0;

  constructor(public service: UsersService,
             private toastr : ToastrService ) { }

  ngOnInit(): void {
    this.service.getStudentList()
    .subscribe((data: any) => {  
      if(data.Status == "SUCCESS"){
        this.parseData(data.Result);
      }
      else {
        this.toastr.error(data.Message, 'Teacher List');
      } 
      
    });
  } 

  parseData(jsonData: any) {
    //considering you get your data in json arrays  
    this.collectionSize = jsonData.length;
    for (let i = 0; i < this.collectionSize; i++) {
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
      this.studentList.push(data);
    } 
    //this.refreshTeachers();
  }


  refreshTeachers() {
    this.students = this.studentList
      .map((data, i) => ({id: i + 1, ...data}))
      .slice((this.page - 1) * this.pageSize, (this.page - 1) * this.pageSize + this.pageSize);
  }

}
