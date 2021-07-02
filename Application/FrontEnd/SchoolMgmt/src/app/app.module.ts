import { TeacherService } from './shared/teacher.service';
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';
import {HttpClientModule} from '@angular/common/http';

import { AppComponent } from './app.component';
import { TeachersComponent } from './teachers/teachers.component';
import { TeacherComponent } from './teachers/teacher/teacher.component';
import { TeacherListComponent } from './teachers/teacher-list/teacher-list.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { ToastrModule } from 'ngx-toastr';
import { LoginComponent } from './login/login.component'; 


@NgModule({
  declarations: [
    AppComponent,
    TeachersComponent,
    TeacherComponent,
    TeacherListComponent,
    LoginComponent 
  ],
  imports: [
    BrowserModule,
    FormsModule,
    HttpClientModule,
    BrowserAnimationsModule,
    ToastrModule.forRoot()
  ],
  providers: [TeacherService],
  bootstrap: [AppComponent]
})
export class AppModule { }
