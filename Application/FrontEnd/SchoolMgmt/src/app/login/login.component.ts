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

      if(localStorage.getItem('RoleName') == "ADMIN" ) { 
        this.router.navigate(['/teachers']);
      } 
      else if(localStorage.getItem('RoleName') == "TEACHER" ) { 
        this.router.navigate(['/students']);
      } 
      else if(localStorage.getItem('RoleName') == "STUDENT" ) { 
        this.router.navigate(['/subjects']);
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
  
      this.resetForm();
    };


}
