import { HttpHeaders } from '@angular/common/http';

export class Config {
    url: string = 'https://localhost:44358/api';
    httpOptions: any = {
        headers: new HttpHeaders({
           'Content-Type': 'application/json',
           'Authorization': localStorage.getItem('Token') ?? "",
           'MakeBy': localStorage.getItem('UserName') ?? ""
        })
    }
}