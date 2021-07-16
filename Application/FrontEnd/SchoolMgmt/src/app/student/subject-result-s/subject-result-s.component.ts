import { Component, OnInit } from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import { OtherService } from 'src/app/shared/other.service';
import { SSubject } from '../model/s-subject.model';

@Component({
  selector: 'app-subject-result-s',
  templateUrl: './subject-result-s.component.html',
  styleUrls: ['./subject-result-s.component.css']
})
export class SubjectResultSComponent implements OnInit { 
  
  public subjectList: SSubject[] = [];

  constructor(public serviceOthers: OtherService,
              private toastr : ToastrService) { }

  ngOnInit(): void {
    this.loadSubjectData();
  }



  loadSubjectData () {
    this.subjectList = [];
    this.serviceOthers.getSubjectsAndGrades()
    .subscribe((data: any) => {  
      if(data.Status == "SUCCESS"){
        this.parseSubjectData(data.Result);
      }
      else {
        this.toastr.error(data.Message, 'Subject List');
      }  
    });
  }



  parseSubjectData(jsonData: any) { 
    this.subjectList  = [];
    let collectionSize = jsonData.length;
    for (let i = 0; i < collectionSize; i++) {
      const data = new SSubject();
      data.index = i+1;
      data.FullName = jsonData[i].FullName; 
      data.StudentId = jsonData[i].StudentId; 
      data.SubjectId = jsonData[i].SubjectId; 
      data.SubjectName = jsonData[i].SubjectName; 
      data.Username = jsonData[i].Username; 
      data.AverageGrade  = jsonData[i].AverageGrade;  
      data.TestCount = jsonData[i].TestCount; 
      this.subjectList.push(data);
    } 
    console.log(this.subjectList );
  }
  

}
