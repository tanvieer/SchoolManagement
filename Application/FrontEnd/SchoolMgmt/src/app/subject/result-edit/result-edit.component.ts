import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { TucResult } from 'src/app/shared/models/tuc-result.model';
import { OtherService } from 'src/app/shared/other.service';
import { UsersService } from 'src/app/shared/users.service';

@Component({
  selector: 'app-result-edit',
  templateUrl: './result-edit.component.html',
  styleUrls: ['./result-edit.component.css']
})
export class ResultEditComponent implements OnInit {

  public resultModel: TucResult = new TucResult(); 
  private _selectedTest!: string; 
 

  private _selectedResultId!: string;
  constructor(
    public service: UsersService,
    public serviceOthers: OtherService,
    private arouter: ActivatedRoute,
    private router: Router,
    private toastr: ToastrService) { }

  ngOnInit(): void {
    this._selectedResultId = this.arouter.snapshot.params.id; 
    this.getResultInfo(this._selectedResultId);
  }



  getResultInfo(_resultId: string) {
    console.log("Before getResultInfo");
    this.serviceOthers.getResultInfo(_resultId)
      .subscribe((res: any) => { 
        if (res.Status == "FAILED") {
          this.toastr.error(res.Message, 'Result Fetch');
          this.resetForm();
        }
        else { 
          console.log("Before getTestInfo 2");
          this.parseResultData(res.Result); 
        } 
      });
  }
 

  parseResultData(jsonData: any){ 
    console.log("Calling parseResultData");
    this.serviceOthers.formData_Result = {
      Index : 1,
      ResultId : jsonData.ResultId,
      TestId: jsonData.TestId,
      TestName: jsonData.TestName,
      Grade: jsonData.Grade,
      Status: jsonData.Status,
      StudentId: jsonData.StudentId,
      SubjectId: jsonData.SubjectId,
      ClassId: jsonData.ClassId,
      Username : jsonData.Username,
      FirstName : jsonData.FirstName,
      LastName : jsonData.LastName,  
      FullName : jsonData.FirstName + ' ' +  jsonData.LastName
    } 
    console.log(this.serviceOthers.formData_Result);

    this._selectedTest = this.serviceOthers.formData_Result.TestId;

  }
   

  
  onSubmit(form: NgForm) { 
    console.log("Calling onSubmit"); 
    console.log(form.value); 
     this.insertRecord(form);
   }
 
   insertRecord(form: NgForm) {
    this.resultModel = new TucResult();
    this.resultModel = form.value;
    this.resultModel.ResultId = this._selectedResultId;
    //this.resultModel.ClassId = this.selectedClassId;
   // this.resultModel.TestId = this.selectedTest;
    console.log("before api call");
    console.log(this.resultModel);
    console.log("=============");


     this.serviceOthers.editResult(this.resultModel)
       .subscribe((res: any) => {  
         console.log(res);
         if (res.Status == "SUCCESS"){
          this.toastr.success(res.Message, 'Create Result');
          this.router.navigate(['/result-list']);
         // this.resetForm();
         } 
         else this.toastr.error(res.Message, 'Create Result');
         
       });
   }
 
 
  resetForm(form?: NgForm) {
    console.log("Calling resetForm"); 
    if (form != null)
      form.resetForm();

    this.serviceOthers.formData_Result = {
      Index : 1,
      ResultId : '',
      TestId: '',
      TestName: '',
      Grade: 0,
      Status: 'ACTIVE',
      StudentId: '',
      SubjectId: '',
      ClassId: '',
      Username : '',
      FirstName : '',
      LastName : '',
      FullName : '' 
    }
  }
 
 

}
