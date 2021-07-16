import { UsersService } from 'src/app/shared/users.service';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { Menu } from '../menu.model';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-nav-left',
  templateUrl: './nav-left.component.html',
  styleUrls: ['./nav-left.component.css']
})
export class NavLeftComponent implements OnInit {

  constructor(private router: Router,
              private service: UsersService ,
              private toastr: ToastrService  ) { }

  public Name! : string;
  public isLoggedIn! : boolean;
  public roleName! : string;
  public routerList : Menu[] = [];
  
  /*[
    {
      index : 1,
      isSubMenu: 0,
      routerLink:'/create-user',
      routerName:'Create User'
    },{ 
    index : 2,
    isSubMenu: 1,
    routerLink:'/user-list',
    routerName:'All Users'
    },{ 
      index : 3,
      isSubMenu: 1,
      routerLink:'/teacher-list',
      routerName:'Teacher List'
    },{
    index : 4,
    isSubMenu: 1,
    routerLink:'/pupils',
    routerName:'Pupil List'
  },{
    index : 5,
    isSubMenu: 1,
    routerLink:'/class-list',
    routerName:'Class List'
  } 
  ,{
    index : 6,
    isSubMenu: 1,
    routerLink:'/subject-list',
    routerName:'Subject List'
  } ,{
    index : 7,
    isSubMenu: 1,
    routerLink:'/test-list',
    routerName:'Test List'
  } ,{
    index : 8,
    isSubMenu: 1,
    routerLink:'/test-edit/1',
    routerName:'Test Edit'
  } ,{
    index : 9,
    isSubMenu: 1,
    routerLink:'/test-create',
    routerName:'Test Create'
  } ,{
    index : 10,
    isSubMenu: 1,
    routerLink:'/result-list',
    routerName:'Result List'
  } ,{
    index : 11,
    isSubMenu: 1,
    routerLink:'/result-edit/1',
    routerName:'Result Edit'
  } ,{
    index : 12,
    isSubMenu: 1,
    routerLink:'/result-create',
    routerName:'Result Create'
  } 
 
];*/

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
      this.loadRouterLinks();
    }
     
  } 
 

  loadRouterLinks() { 
    this.service.getRouterLinks()
      .subscribe((data: any) => {
        if (data.Status == "SUCCESS") {
          this.parseRouterLinks(data.Result);
        }
        else {
          this.toastr.error(data.Message, 'Subject List');
        }
      });
  }



  parseRouterLinks(jsonData: any) {
   // console.log(jsonData);
    this.routerList = [];
  
    let collectionSize = jsonData.length;
    for (let i = 0; i < collectionSize; i++) {
      const data = new Menu();
      data.index = i + 1;
      data.Id = jsonData[i].Id;
      data.RouterLink = jsonData[i].RouterLink;
      data.RouterName = jsonData[i].RouterName;
      data.RoleId = jsonData[i].RoleId;
      data.IsSubMenu = jsonData[i].IsSubMenu;
      this.routerList.push(data);
    }

  //  console.log(this.routerList);
  }













}
 