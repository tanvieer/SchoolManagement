import { DatePipe } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { TucSubject } from 'src/app/shared/models/tuc-subject.model';
import { TucTest } from 'src/app/shared/models/tuc-test.model';
import { OtherService } from 'src/app/shared/other.service';

@Component({
  selector: 'app-test-edit',
  templateUrl: './test-edit.component.html',
  styleUrls: ['./test-edit.component.css']
})
export class TestEditComponent implements OnInit {

  private testObject : TucTest = new TucTest();
  public subjectList: TucSubject[] = [];
  public testID! : string;

  constructor(public service: OtherService, 
    public datepipe: DatePipe,
    private arouter: ActivatedRoute,
    private toastr: ToastrService) {
      
  }

    ngOnInit(): void {
      this.resetForm();
      this.loadSubjectData();
      this.testID = this.arouter.snapshot.params.id;
      this.getTestInfo(this.testID);
    }

    getTestInfo(_testID: string) {
      this.service.getTestInfo(_testID)
        .subscribe((res: any) => { 
          if (res.Status == "FAILED") {
            this.toastr.error(res.Message, 'Class Edit');
            this.resetForm();
          }
          else { 
            this.parseTestData(res.Result); 
          } 
        });
    }

    parseTestData(jsonData: any) {

      this.service.formData_Test = { 
        Index: 1, 
        SubjectId: jsonData.SubjectId,
        TestId: jsonData.TestId ,
        TestName: jsonData.TestName ,
        TestDate: jsonData.TestDateStr ,
        SubjecName: jsonData.SubjecName ,
        Status: jsonData.Status  
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
   

    
  resetForm(form?: NgForm) {

    if (form != null)
      form.resetForm();

    //let latest_date =this.datePipe.transform(new Date(), 'yyyy-MM-dd');
    this.service.formData_Test = {
      Index: 0,
      TestId: '',
      TestName: '',
      SubjectId: '',
      TestDate: this.datepipe.transform(new Date(), 'mm-dd-yyyy'),
      SubjecName: '',
      Status: 'R'
    }
  }
  
  onSubmit(form: NgForm) {
    this.insertRecord(form);
  }
  insertRecord(form: NgForm) {

    this.testObject = form.value;

    this.testObject.TestDate = this.datepipe.transform(this.testObject.TestDate, 'ddMMMyy');
    this.testObject.TestId =  this.testID;
    
    console.log(this.testObject);
   
    this.service.modifyTest(this.testObject)
       .subscribe((res: any) => {
         console.log(res);
         if (res.Status == "SUCCESS")
           this.toastr.success(res.Message, 'Create Test');
         else this.toastr.error(res.Message, 'Create Test'); 
       });
  }

}
