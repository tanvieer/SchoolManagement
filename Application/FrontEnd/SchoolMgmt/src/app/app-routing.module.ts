import { ATGuardGuard } from './atguard.guard';
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
import { ResultCreateComponent } from './subject/result-create/result-create.component';
import { ResultEditComponent } from './subject/result-edit/result-edit.component';
import { ResultListComponent } from './subject/result-list/result-list.component';
import { SubjectResultSComponent } from './student/subject-result-s/subject-result-s.component';
import { TestSListComponent } from './student/test-s-list/test-s-list.component';
import { StudentGuardGuard } from './student-guard.guard';
import { TeacherGuardGuard } from './teacher-guard.guard';
import { AdminGuardGuard } from './admin-guard.guard';

const routes : Routes = [
  {path: 'login' , component: LoginComponent}, 
  {path: '' , component: LoginComponent}, 
  {path: 'teachers', component: TeachersComponent , canActivate : [AdminGuardGuard]},
  {path: 'pupils', component: PupilsComponent , canActivate : [ATGuardGuard]},
  {path: 'teacher-list', component: TeacherListComponent, canActivate : [AdminGuardGuard]},
  {path: 'user-list', component: UserListComponent, canActivate : [AdminGuardGuard]},  
  {path: 'create-user', component: CreateUserComponent, canActivate : [AdminGuardGuard]}, 
  {path: 'update-profile', component: UpdateProfileComponent, canActivate : [AuthGuardGuard]},
  {path: 'change-password', component: ChangePasswordComponent, canActivate : [AuthGuardGuard]},
  {path: 'update-user/:id', component: UpdateUserComponent, canActivate : [AdminGuardGuard]},
  {path: 'reset-password/:id', component: ResetPasswordComponent, canActivate : [AdminGuardGuard]},
  
  

  {path: 'class-create', component: ClassCreateComponent, canActivate : [AdminGuardGuard]},
  {path: 'class-edit/:id', component: ClassEditComponent, canActivate : [AdminGuardGuard]},
  {path: 'class-list', component: ClassListComponent, canActivate : [AdminGuardGuard]},

  {path: 'contact', component: ContactComponent, canActivate : [AuthGuardGuard]},

  {path: 'subject-create', component: SubjectCreateComponent, canActivate : [AdminGuardGuard]},
  {path: 'subject-edit/:id', component: SubjectEditComponent, canActivate : [AdminGuardGuard]},
  {path: 'subject-list', component: SubjectListComponent, canActivate : [AdminGuardGuard]},

  {path: 'test-create', component: TestCreateComponent, canActivate : [TeacherGuardGuard]},
  {path: 'test-edit/:id', component: TestEditComponent, canActivate : [TeacherGuardGuard]},
  {path: 'test-list', component: TestListComponent, canActivate : [TeacherGuardGuard]},

  {path: 'result-create', component: ResultCreateComponent, canActivate : [TeacherGuardGuard]},
  {path: 'result-edit/:id', component: ResultEditComponent, canActivate : [TeacherGuardGuard]},
  {path: 'result-list', component: ResultListComponent, canActivate : [TeacherGuardGuard]},

  {path: 'subject-list-s', component: SubjectResultSComponent, canActivate : [StudentGuardGuard]},
  {path: 'test-list-s/:id', component: TestSListComponent, canActivate : [StudentGuardGuard]},

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
 
                                  ResultCreateComponent,
                                  ResultListComponent,
                                  ResultEditComponent,
                                 
                                  
                                  SubjectResultSComponent,
                                  TestSListComponent,


                                  NavTopComponent,
                                  NavLeftComponent ]

