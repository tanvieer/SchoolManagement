import { AuthGuardGuard } from './auth-guard.guard';
import { UpdateUserComponent } from './update-user/update-user.component';
import { TeacherListComponent } from './teachers/teacher-list/teacher-list.component';
import { TeachersComponent } from './teachers/teachers.component'; 
import { LoginComponent } from './login/login.component';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {Routes, RouterModule} from '@angular/router';
import { LogoutComponent } from './logout/logout.component';
import { CreateUserComponent } from './create-user/create-user.component';
import { PupilsComponent } from './pupils/pupils.component';

const routes : Routes = [
  {path: 'login' , component: LoginComponent}, 
  {path: '' , component: LoginComponent}, 
  {path: 'teachers', component: TeachersComponent , canActivate : [AuthGuardGuard]},
  {path: 'pupils', component: PupilsComponent , canActivate : [AuthGuardGuard]},
  {path: 'teacher-list', component: TeacherListComponent, canActivate : [AuthGuardGuard]},
  {path: 'create-user', component: CreateUserComponent, canActivate : [AuthGuardGuard]},
  {path: 'update-user/:id', component: UpdateUserComponent, canActivate : [AuthGuardGuard]},
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
                                  TeachersComponent,
                                  TeacherListComponent,
                                  LogoutComponent,
                                  TeachersComponent,
                                  CreateUserComponent,
                                  UpdateUserComponent,
                                  PupilsComponent ]

