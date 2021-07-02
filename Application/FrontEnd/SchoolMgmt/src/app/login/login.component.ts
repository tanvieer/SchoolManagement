import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';  
import { AuthenticationService } from '../shared/authentication.service';


@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  constructor(public service : AuthenticationService, 
    private toastr : ToastrService ) { }


  ngOnInit(): void {
    this.resetForm();
  }

  resetForm(form? : NgForm){
    if(form != null)
      form.resetForm();
      this.service.formData = { 
        Username: '',    
        Password: '' 
      }       
  }





  onSubmit(form : NgForm){
    // await this.service.getTeacherList();
      this.insertRecord(form);
    }
   
    insertRecord(form: NgForm){ 
        
      //console.log();
      this.service.login(form.value);
  
      this.resetForm();
    };


}
