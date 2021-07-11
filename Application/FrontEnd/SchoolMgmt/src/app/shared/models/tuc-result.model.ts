import { Injectable } from '@angular/core';
export class TucResult {
    Index:number = 1;
    ResultId:string = '';
    TestId:string = '';
    Grade:number = 0;
    Status:string = 'ACTIVE';
    StudentId:string = '';
    Username:string = '';
    FirstName:string = '';
    LastName:string = '';
    FullName:string = this.FirstName + " " + this.LastName;
}
