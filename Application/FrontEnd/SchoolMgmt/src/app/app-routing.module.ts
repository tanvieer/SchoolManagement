import { TeacherListComponent } from './teachers/teacher-list/teacher-list.component';
import { TeachersComponent } from './teachers/teachers.component';
import { TeacherComponent } from './teachers/teacher/teacher.component';
import { LoginComponent } from './login/login.component';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {Routes, RouterModule} from '@angular/router';
import { LogoutComponent } from './logout/logout.component';
import { CreateUserComponent } from './create-user/create-user.component';

const routes : Routes = [
  {path: 'login' , component: LoginComponent},
  {path: 'teacher', component: TeacherComponent},
  {path: 'teachers', component: TeachersComponent},
  {path: 'teacher-list', component: TeacherListComponent},
  {path: 'create-user', component: CreateUserComponent},
  {path: 'logout', component: LogoutComponent}
];


@NgModule({
  declarations: [],
  imports: [
    CommonModule,
    RouterModule.forRoot(routes)
  ],
  exports: [RouterModule]
})
export class AppRoutingModule { }
export const routingComponents = [LoginComponent, 
                                  TeacherComponent,
                                  TeachersComponent,
                                  TeacherListComponent,
                                  LogoutComponent,
                                  TeachersComponent,
                                  CreateUserComponent ]

