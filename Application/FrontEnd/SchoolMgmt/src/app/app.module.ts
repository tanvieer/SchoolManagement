import { UsersService } from './shared/users.service';
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';
import {HttpClientModule} from '@angular/common/http';

import { AppComponent } from './app.component'; 
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { ToastrModule } from 'ngx-toastr'; 
import { AppRoutingModule, routingComponents } from './app-routing.module';
import { NavMenuComponent } from './nav-menu/nav-menu.component';
import { CreateUserComponent } from './create-user/create-user.component'; 


@NgModule({
  declarations: [
    AppComponent,
    routingComponents,
    NavMenuComponent  
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpClientModule,
    BrowserAnimationsModule,
    ToastrModule.forRoot(),
    AppRoutingModule
  ],
  providers: [UsersService],
  bootstrap: [AppComponent]
})
export class AppModule { }
