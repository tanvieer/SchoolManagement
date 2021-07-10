 

export class JwtToken {
    Token!: string;
    FirstName!: string;
    LastName!: string;
    Email!: string;
    RoleId!: string;
    getIdKey!: string;
    Session!: string;
    SessionExpireTime!: string;
    RoleName!: string;
    Status!: string;
    make_by!: string;
    Maker_Time!: string;
  }

export class Teacher {  

    Id!:string; 
    index!: number;    
    UserName!:string;    
    Password!:string;     
    Email!:string;    
    FirstName!:string;    
    LastName!:string;    
    PhoneNumber!:string;   
    RoleId!: number;
    ClassId!: number;
    FullName!:string;
    Session!:string;    
    SessionExpireTime!:string;    
    RoleName!:string;    
    Status!:string;    
    make_by!:string;    
    Maker_Time!: string; 
    ClassName!: string; 
    AverageGrade!:string; 
}


 