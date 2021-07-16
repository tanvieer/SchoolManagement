import { OtherService } from 'src/app/shared/other.service';
import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl, Validators } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';

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

  constructor(private service: OtherService,
    private toastr: ToastrService) { }
  ngOnInit(): void {

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

}




