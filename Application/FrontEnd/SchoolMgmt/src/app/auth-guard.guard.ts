import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, RouterStateSnapshot, UrlTree } from '@angular/router';

@Injectable({
  providedIn: 'root'
})
export class AuthGuardGuard implements CanActivate {
  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot): boolean {

      if(localStorage.getItem('isLoggedIn') == "0" ) { 
        return false;
      }   
      else {   
        return true;
      }
 
  }

  isAdmin(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot): boolean {

      if(localStorage.getItem('isLoggedIn') == "0" ) { 
        return false;
      }   
      else {    
        if(localStorage.getItem('RoleName') == "ADMIN" )
         return true;
        else return false;
      }
  
  }
  
}
