import { OtherService } from './../../shared/other.service';
import { Component, OnInit } from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import { NgForm } from '@angular/forms';

@Component({
  selector: 'app-class-create',
  templateUrl: './class-create.component.html',
  styleUrls: ['./class-create.component.css']
})
export class ClassCreateComponent implements OnInit {

  constructor(public service: OtherService,
              private toastr: ToastrService) { }

  ngOnInit(): void {
    this.resetForm();
  }



  onSubmit(form: NgForm) { 
    this.insertRecord(form);
  }

  insertRecord(form: NgForm) {
    this.service.addNewClass(form.value)
      .subscribe((res: any) => { 
        if (res.Status == "SUCCESS")
          this.toastr.success(res.Message, 'Create Class');
        else this.toastr.error(res.Message, 'Create Class');
        this.resetForm();
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
