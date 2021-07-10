import { UsersService } from './shared/users.service';
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';
import {HttpClientModule} from '@angular/common/http';

import { AppComponent } from './app.component'; 
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { ToastrModule } from 'ngx-toastr'; 
import { AppRoutingModule, routingComponents } from './app-routing.module';  
import { NavBottomComponent } from './nav/nav-bottom/nav-bottom.component';
import { NavRightComponent } from './nav/nav-right/nav-right.component'; 
import { DatePipe } from '@angular/common';
import { ResultCreateComponent } from './subject/result-create/result-create.component';
import { ResultListComponent } from './subject/result-list/result-list.component';
import { ResultEditComponent } from './subject/result-edit/result-edit.component';


@NgModule({
  declarations: [
    AppComponent,
    routingComponents,
    NavBottomComponent,
    NavRightComponent,
    ResultCreateComponent,
    ResultListComponent,
    ResultEditComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpClientModule,
    BrowserAnimationsModule,
    ToastrModule.forRoot(),
    AppRoutingModule
  ],
  providers: [UsersService,DatePipe],
  bootstrap: [AppComponent]
})
export class AppModule { }
