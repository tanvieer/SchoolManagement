import { OtherService } from 'src/app/shared/other.service';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { TucSubject } from 'src/app/shared/models/tuc-subject.model';
import { TucTest } from 'src/app/shared/models/tuc-test.model';

@Component({
  selector: 'app-import-grades',
  templateUrl: './import-grades.component.html',
  styleUrls: ['./import-grades.component.css']
})
export class ImportGradesComponent implements OnInit {

  myForm = new FormGroup({
    name: new FormControl('', [Validators.required, Validators.minLength(3)]),
    file: new FormControl('', [Validators.required]),
    fileSource: new FormControl('', [Validators.required])
  });

  public testList: TucTest[] = [];
  public subjectList: TucSubject[] = [];
  public selectedSubject! : string;
  public selectedTest!: string;

  public isEnabledDownload : boolean = false;
  private fileName !: string;

  constructor(private service: OtherService,
    private toastr: ToastrService) { }
  ngOnInit(): void {
    this.loadSubjectData(); 
  }

  onTestChange(_id: string) {
    this.selectedTest = _id;
     
    for(let i = 0; i < this.testList.length; i++){ 

      if(this.testList[i].TestId == this.selectedTest){
        this.fileName = 'Test_'+this.testList[i].TestName;
        break;
      }
    } 
    this.isEnabledDownload = true;
  }

 onSubjectChange(_id: string) {
    this.selectedSubject = _id;
    this.loadTestData(this.selectedSubject); 
    this.selectedTest = '';
  }

  loadSubjectData() {
    this.subjectList = [];
    this.service.getSubjectListDDL()
      .subscribe((data: any) => {
        if (data.Status == "SUCCESS") {
          this.parseSubjectData(data.Result);
        }
        else {
          this.toastr.error(data.Message, 'Subject List');
        }
      });
  }
  parseSubjectData(jsonData: any) {
    //considering you get your data in json arrays  
    this.subjectList = [];
    let collectionSize = jsonData.length;
    this.selectedSubject = jsonData[0].SubjectId;
    this.loadTestData(this.selectedSubject);
    for (let i = 0; i < collectionSize; i++) {
      const data = new TucSubject();
      data.index = i + 1;
      data.ClassId = jsonData[i].ClassId;
      data.ClassName = jsonData[i].ClassName;
      data.SubjectId = jsonData[i].SubjectId;
      data.SubjectName = jsonData[i].SubjectName;
      data.TeacherId = jsonData[i].TeacherId;
      data.TeacherName = jsonData[i].TeacherName;
      data.TeacherUserName = jsonData[i].TeacherUserName;
      data.Status = jsonData[i].Status;
      this.subjectList.push(data);
    }
  }

  loadTestData(_subjectId: string) {
    this.selectedSubject = _subjectId;
    this.testList = [];
    this.service.getTestList(_subjectId)
      .subscribe((data: any) => {
        if (data.Status == "SUCCESS") {
          this.parseTestData(data.Result);
        }
        else {
          this.toastr.error(data.Message, 'Subject List');
        }
      });
  }


  parseTestData(jsonData: any) { 
    this.testList = [];
    let collectionSize = jsonData.length;
    for (let i = 0; i < collectionSize; i++) {
      const data = new TucTest();
      data.Index = i + 1;
      data.TestId = jsonData[i].TestId;
      data.TestName = jsonData[i].TestName;
      data.TestDate = jsonData[i].TestDateStr;
      data.SubjecName = jsonData[i].SubjecName;
      data.Status = jsonData[i].Status;
      this.testList.push(data);
    }
    this.selectedTest = jsonData[0].TestId;
    //this.fileName = 'Test_'+this.selectedTest;
 
    this.fileName = 'Test_'+jsonData[0].TestName;

  }




  get f() {
    return this.myForm.controls;
  }

  onFileChange(event: any) {

    if (event.target.files.length > 0) {
      const file = event.target.files[0];
      this.myForm.patchValue({
        fileSource: file
      });
    }
  }


  
  
  showErrorMsg(jsonData: any) {
    //considering you get your data in json arrays   
    let collectionSize = jsonData.length;  
    for (let i = 0; i < collectionSize; i++) {
       
      if (jsonData[i].HasErr == "1"){
        this.toastr.error(jsonData[i].ErrMsg, 'Grade Upload');
      }else{
        this.toastr.success(jsonData[i].ErrMsg, 'Grade Upload');
      } 
    }
  }


  submit() {
    const formData = new FormData();
    formData.append('file', this.myForm.get('fileSource')?.value); 
    this.service.postFile(formData).subscribe((data: any) => {   
      console.log(data.Result); 
      if (data.Status == "SUCCESS") { 
        this.showErrorMsg(data.Result);
      }
      else {
        this.toastr.error(data.Message, 'Grade Upload');
      }
    }
    
    
    )
  }

  downloadFile() { 

   if (this.selectedTest == undefined || this.selectedTest == ''){
    this.toastr.error('Please select a test', 'Download Template');
    return;
   }


    this.service.downloadFile(this.selectedTest)
    .subscribe(x => {
      // It is necessary to create a new blob object with mime-type explicitly set
      // otherwise only Chrome works like it should
      let fileName = this.fileName + '_Template.csv';
      var newBlob = new Blob([x], { type: "text/csv" });
      
      // IE doesn't allow using a blob object directly as link href
      // instead it is necessary to use msSaveOrOpenBlob
      if (window.navigator && window.navigator.msSaveOrOpenBlob) {
          window.navigator.msSaveOrOpenBlob(newBlob, fileName);
          return;
      }
      
      // For other browsers: 
      // Create a link pointing to the ObjectURL containing the blob.
      const data = window.URL.createObjectURL(newBlob);
      
      var link = document.createElement('a');
      link.href = data;
      link.download = fileName;
      // this is necessary as link.click() does not work on the latest firefox
      link.dispatchEvent(new MouseEvent('click', { bubbles: true, cancelable: true, view: window }));
      
      setTimeout(function () {
          // For Firefox it is necessary to delay revoking the ObjectURL
          window.URL.revokeObjectURL(data);
          link.remove();
      }, 100);
  });
    
    
    
    
    
    
    
    /*.subscribe((data: any) => {   
      console.log(data.Result); 
      if (data.Status == "SUCCESS") {  
      }
      else {
        this.toastr.error(data.Message, 'Download File');
      }
    } 
    )*/
  }


}




