import { DatePipe } from '@angular/common';
import { TucTest } from './../../../shared/models/tuc-test.model';
 
import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { OtherService } from 'src/app/shared/other.service';
import { TucSubject } from 'src/app/shared/models/tuc-subject.model';

@Component({
  selector: 'app-test-create',
  templateUrl: './test-create.component.html',
  styleUrls: ['./test-create.component.css']
})
export class TestCreateComponent implements OnInit {

  private testObject : TucTest = new TucTest();
  public subjectList: TucSubject[] = [];
  
  constructor(public service: OtherService, 
    public datepipe: DatePipe,
    private toastr: ToastrService) {
      
  }

  ngOnInit(): void {
    this.resetForm();
    this.loadSubjectData();

   console.log(this.service.formData_Test);
  }

  onSubmit(form: NgForm) {
    this.insertRecord(form);
  }
  insertRecord(form: NgForm) {

    this.testObject = form.value;

    this.testObject.TestDate = this.datepipe.transform(this.testObject.TestDate, 'ddMMMyy');
    
    //console.log(this.testObject);
   
    this.service.addNewTest(this.testObject)
       .subscribe((res: any) => {
         console.log(res);
         if (res.Status == "SUCCESS")
           this.toastr.success(res.Message, 'Create Test');
         else this.toastr.error(res.Message, 'Create Test');
         this.resetForm();
       });
  }


  resetForm(form?: NgForm) {

    if (form != null)
      form.resetForm();

    //let latest_date =this.datePipe.transform(new Date(), 'yyyy-MM-dd');
    this.service.formData_Test = {
      Index: 0,
      TestId: '',
      TestName: '',
      SubjectId: '',
      TestDate: this.datepipe.transform(new Date(), 'yyyy-MM-dd'),
      SubjecName: '',
      Status: 'R'
    }
  }

  loadSubjectData () {
    this.subjectList = [];
    this.service.getSubjectListDDL()
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
    //considering you get your data in json arrays  
    this.subjectList  = [];
    let collectionSize = jsonData.length;
    for (let i = 0; i < collectionSize; i++) {
      const data = new TucSubject();
      data.index = i+1;
      data.ClassId = jsonData[i].ClassId; 
      data.ClassName = jsonData[i].ClassName; 
      data.SubjectId = jsonData[i].SubjectId; 
      data.SubjectName = jsonData[i].SubjectName; 
      data.TeacherId = jsonData[i].TeacherId; 
      data.TeacherName  = jsonData[i].TeacherName; 
      data.TeacherUserName = jsonData[i].TeacherUserName;  
      data.Status = jsonData[i].Status;  
      this.subjectList.push(data);
    } 
  }

}
