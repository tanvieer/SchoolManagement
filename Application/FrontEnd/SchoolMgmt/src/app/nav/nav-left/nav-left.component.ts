import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Menu } from '../menu.model';

@Component({
  selector: 'app-nav-left',
  templateUrl: './nav-left.component.html',
  styleUrls: ['./nav-left.component.css']
})
export class NavLeftComponent implements OnInit {

  constructor(private router: Router ) { }

  public Name! : string;
  public isLoggedIn! : boolean;
  public roleName! : string;
  public routerList : Menu[] = [
    {
      index : 1,
      isMainMenu: false,
      routerLink:'/create-user',
      routerName:'Create User'
    },{ 
    index : 2,
    isMainMenu: true,
    routerLink:'/user-list',
    routerName:'All Users'
    },{ 
      index : 3,
      isMainMenu: true,
      routerLink:'/teacher-list',
      routerName:'Teacher List'
    },{
    index : 4,
    isMainMenu: true,
    routerLink:'/pupils',
    routerName:'Pupil List'
  },{
    index : 5,
    isMainMenu: true,
    routerLink:'/class-list',
    routerName:'Class List'
  } 
  ,{
    index : 6,
    isMainMenu: true,
    routerLink:'/subject-list',
    routerName:'Subject List'
  } ,{
    index : 7,
    isMainMenu: true,
    routerLink:'/test-list',
    routerName:'Test List'
  } ,{
    index : 8,
    isMainMenu: true,
    routerLink:'/test-edit/1',
    routerName:'Test Edit'
  } ,{
    index : 9,
    isMainMenu: true,
    routerLink:'/test-create',
    routerName:'Test Create'
  } 
 
];

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