import { UserListComponent } from './admin/user-list/user-list.component';
import { AuthGuardGuard } from './auth-guard.guard';
import { UpdateUserComponent } from './admin/update-user/update-user.component';
import { TeacherListComponent } from './teachers/teacher-list/teacher-list.component';
import { TeachersComponent } from './teachers/teachers.component'; 
import { LoginComponent } from './login/login.component';
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Routes, RouterModule} from '@angular/router';
import { LogoutComponent } from './logout/logout.component';
import { CreateUserComponent } from './create-user/create-user.component';
import { PupilsComponent } from './pupils/pupils.component';
import { UpdateProfileComponent } from './profile/update-profile/update-profile.component'; 
import { ClassListComponent } from './class/class-list/class-list.component';
import { ClassCreateComponent } from './class/class-create/class-create.component';
import { ClassEditComponent } from './class/class-edit/class-edit.component';
import { SubjectCreateComponent } from './subject/subject-create/subject-create.component';
import { SubjectEditComponent } from './subject/subject-edit/subject-edit.component';
import { SubjectListComponent } from './subject/subject-list/subject-list.component';
import { ContactComponent } from './profile/contact/contact.component';
import { ResetPasswordComponent } from './admin/reset-password/reset-password.component';
import { ChangePasswordComponent } from './profile/change-password/change-password.component';
import { NavLeftComponent } from './nav/nav-left/nav-left.component';
import { NavTopComponent } from './nav/nav-top/nav-top.component';
import { TestCreateComponent } from './subject/test/test-create/test-create.component';
import { TestEditComponent } from './subject/test/test-edit/test-edit.component';
import { TestListComponent } from './subject/test/test-list/test-list.component';

const routes : Routes = [
  {path: 'login' , component: LoginComponent}, 
  {path: '' , component: LoginComponent}, 
  {path: 'teachers', component: TeachersComponent , canActivate : [AuthGuardGuard]},
  {path: 'pupils', component: PupilsComponent , canActivate : [AuthGuardGuard]},
  {path: 'teacher-list', component: TeacherListComponent, canActivate : [AuthGuardGuard]},
  {path: 'user-list', component: UserListComponent, canActivate : [AuthGuardGuard]},  
  {path: 'create-user', component: CreateUserComponent, canActivate : [AuthGuardGuard]}, 
  {path: 'update-profile', component: UpdateProfileComponent, canActivate : [AuthGuardGuard]},
  {path: 'change-password', component: ChangePasswordComponent, canActivate : [AuthGuardGuard]},
  {path: 'update-user/:id', component: UpdateUserComponent, canActivate : [AuthGuardGuard]},
  {path: 'reset-password/:id', component: ResetPasswordComponent, canActivate : [AuthGuardGuard]},
  
  

  {path: 'class-create', component: ClassCreateComponent, canActivate : [AuthGuardGuard]},
  {path: 'class-edit/:id', component: ClassEditComponent, canActivate : [AuthGuardGuard]},
  {path: 'class-list', component: ClassListComponent, canActivate : [AuthGuardGuard]},

  {path: 'contact', component: ContactComponent, canActivate : [AuthGuardGuard]},

  {path: 'subject-create', component: SubjectCreateComponent, canActivate : [AuthGuardGuard]},
  {path: 'subject-edit/:id', component: SubjectEditComponent, canActivate : [AuthGuardGuard]},
  {path: 'subject-list', component: SubjectListComponent, canActivate : [AuthGuardGuard]},

  {path: 'test-create', component: TestCreateComponent, canActivate : [AuthGuardGuard]},
  {path: 'test-edit/:id', component: TestEditComponent, canActivate : [AuthGuardGuard]},
  {path: 'test-list', component: TestListComponent, canActivate : [AuthGuardGuard]},

  {path: 'logout', component: LogoutComponent},
  {path: 'nav-top', component: NavTopComponent},
  {path: 'nav-left', component: NavLeftComponent}  
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
                                  PupilsComponent,
                                  UserListComponent, 
                                  UpdateProfileComponent,
                                  ClassListComponent,
                                  ClassCreateComponent,
                                  ClassEditComponent,

                                  ResetPasswordComponent,
                                  ChangePasswordComponent,

                                  SubjectCreateComponent,
                                  SubjectEditComponent,
                                  SubjectListComponent,
                                  ContactComponent,

                                   
                                  TestCreateComponent,
                                  TestEditComponent,
                                  TestListComponent,
                                 
                                  NavTopComponent,
                                  NavLeftComponent ]

