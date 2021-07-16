import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { OtherService } from 'src/app/shared/other.service';
import { STest } from '../model/s-test.model';

@Component({
  selector: 'app-test-s-list',
  templateUrl: './test-s-list.component.html',
  styleUrls: ['./test-s-list.component.css']
})
export class TestSListComponent implements OnInit {

  public testID! : string;
  public testList : STest[] = [];

  constructor(public service: OtherService,  
    private arouter: ActivatedRoute,
    private router: Router,
    private toastr: ToastrService) { }

  ngOnInit(): void {
    this.testID = this.arouter.snapshot.params.id;
    this.loadTestData(this.testID );
  }

 

  

  loadTestData (_id:string) {
    this.testList = [];
    this.service.getTestsOfSubject(_id)
    .subscribe((data: any) => {  
      if(data.Status == "SUCCESS"){
        this.parseTestData(data.Result);
      }
      else {
        this.toastr.error(data.Message, 'Test List');
      }  
    });
  }



  parseTestData(jsonData: any) { 
    this.testList  = [];
    let collectionSize = jsonData.length;
    for (let i = 0; i < collectionSize; i++) {
      const data = new STest();
      data.index = i+1;
      data.SubjectId = jsonData[i].SubjectId; 
      data.SubjectName = jsonData[i].SubjectName; 
      data.TestId = jsonData[i].TestId; 
      data.TestName = jsonData[i].TestName; 
      data.Grade = jsonData[i].Grade;  
      this.testList.push(data);
    } 
  }
  


}
