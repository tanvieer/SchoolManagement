import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { UsersService } from '../shared/users.service';

@Component({
  selector: 'app-update-user',
  templateUrl: './update-user.component.html',
  styleUrls: ['./update-user.component.css']
})
export class UpdateUserComponent implements OnInit {

  constructor(public service  : UsersService, 
              private toastr  : ToastrService,
              private arouter : ActivatedRoute)
              { }

  ngOnInit(): void {
    console.log(this.arouter.snapshot.params.id);
  }

}
