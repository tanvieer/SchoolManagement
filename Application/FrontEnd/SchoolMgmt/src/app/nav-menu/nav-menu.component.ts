import { JwtToken } from './../shared/login.model';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-nav-menu',
  templateUrl: './nav-menu.component.html',
  styleUrls: ['./nav-menu.component.css']
})
export class NavMenuComponent implements OnInit {

  constructor(private router: Router ) { }

  public Name! : string;
  public isLoggedIn! : boolean;
  public roleName! : string;

  ngOnInit(): void {
    if(localStorage.getItem('isLoggedIn') == "0" ) {
      this.isLoggedIn = false;
      this.router.navigate(['/login']); 
      this.Name = "Please Login";
    }  

    else {  
      this.isLoggedIn = true;
      this.Name = localStorage.getItem('Name')?? "0"; 
      this.roleName = localStorage.getItem('RoleName')?? "STUDENT"; 
    }





  } 
}
