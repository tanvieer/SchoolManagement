import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms'; 
import { AuthenticationService } from '../shared/authentication.service'; 
import { Router } from '@angular/router';


@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
   
  constructor(public service : AuthenticationService,  
              private router: Router ) { }


  ngOnInit(): void {
    this.resetForm();
    if(localStorage.getItem('isLoggedIn') == "1" ) {

      //this.router.navigate(['/contact']);

      if(localStorage.getItem('RoleName') == "ADMIN" ) { 
        this.router.navigate(['/user-list']);
      } 
      else if(localStorage.getItem('RoleName') == "TEACHER" ) { 
        this.router.navigate(['/pupils']);
      } 
      else if(localStorage.getItem('RoleName') == "STUDENT" ) { 
        this.router.navigate(['/subject-list-s']);
      }  
    } 
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
  
      //this.resetForm();
    };


}
