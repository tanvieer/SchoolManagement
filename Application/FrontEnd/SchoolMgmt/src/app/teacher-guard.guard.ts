import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, RouterStateSnapshot, UrlTree } from '@angular/router';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class TeacherGuardGuard implements CanActivate {
  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot): boolean {

      if(localStorage.getItem('isLoggedIn') == "0" ) { 
        return false;
      }   
      else {    
        if(localStorage.getItem('RoleName') == "TEACHER")
         return true;
        else return false;
      }
  
  }
  
}
