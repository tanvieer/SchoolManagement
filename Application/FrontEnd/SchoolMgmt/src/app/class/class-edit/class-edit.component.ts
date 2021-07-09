import { OtherService } from './../../shared/other.service';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { NgForm } from '@angular/forms'; 

@Component({
  selector: 'app-class-edit',
  templateUrl: './class-edit.component.html',
  styleUrls: ['./class-edit.component.css']
})
export class ClassEditComponent implements OnInit {

  public collectionSize : number = 0;
  constructor(public service: OtherService,
    private toastr: ToastrService,
    private arouter: ActivatedRoute,
    private router: Router) {   
      this.getClassInfo(this.arouter.snapshot.params.id);
    }

  
    ngOnInit(): void {
      console.log("1");
    }
  
  
    getClassInfo(_classId: number) {
      this.service.getClassInfo(_classId)
        .subscribe((res: any) => { 
          if (res.Status == "FAILED") {
            this.toastr.error(res.Message, 'Class Edit');
            this.resetForm();
          }
          else { 
            this.parseData(res.Result); 
          } 
        });
    }
  

    parseData(jsonData: any) {  
      this.service.formData_class = { 
        Index: 1, 
        ClassId: jsonData.ClassId,
        ClassName: jsonData.ClassName 
      } 
    }
  
    onSubmit(form: NgForm) { 
      this.insertRecord(form); 
    }
  
    insertRecord(form: NgForm) { 
      this.service.modifyClass(form.value)
        .subscribe((res: any) => { 
          if (res.Status == "SUCCESS"){
            this.toastr.success(res.Message, 'Edit Class');
            this.router.navigate(['/class-list']);
          } 
          else this.toastr.error(res.Message, 'Edit Class'); 
        });
    }
 
    
    resetForm(form?: NgForm) {
  
      if (form != null)
        form.resetForm(); 
  
        this.service.formData_class = {
          Index: 0,
          ClassId: '',
          ClassName: '' 
      }
    } 
}
