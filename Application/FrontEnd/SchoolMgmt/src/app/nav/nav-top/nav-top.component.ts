import { Component, OnInit } from '@angular/core'; 

@Component({
  selector: 'app-nav-top',
  templateUrl: './nav-top.component.html',
  styleUrls: ['./nav-top.component.css']
})
export class NavTopComponent implements OnInit {
  //@ViewChild('sidebar') sidebar: SidebarComponent;
  public isLoggedIn! : boolean;

 
  
  constructor( ) {

    if(localStorage.getItem('isLoggedIn') == "1" ) {
      this.isLoggedIn = true;  
    }   
    else {  
      this.isLoggedIn = false; 
    }
 


   }

  ngOnInit(): void {
  }
   
  }