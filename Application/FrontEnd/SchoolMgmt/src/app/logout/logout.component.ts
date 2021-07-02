import { Component, OnInit } from '@angular/core'; 
import { AuthenticationService } from '../shared/authentication.service';

@Component({
  selector: 'app-logout',
  templateUrl: './logout.component.html',
  styleUrls: ['./logout.component.css']
})
export class LogoutComponent implements OnInit {

  constructor(public service : AuthenticationService ) { }

  ngOnInit(): void {
      this.service.logout(); 
  }

}
