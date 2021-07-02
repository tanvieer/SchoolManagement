export class statusResultL {  

    Status!:string;     
    Message!:string;    
    Result!: Teacher[]; 
}
export class statusResultO {  

    Status!:string;     
    Message!:string;    
    Result!: Teacher; 
}


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
    UserName!:string;    
    Password!:string;    
    Email!:string;    
    FirstName!:string;    
    LastName!:string;    
    PhoneNumber!:string;    
    RoleId!:string;
    FullName!:string;
    Session!:string;    
    SessionExpireTime!:string;    
    RoleName!:string;    
    Status!:string;    
    make_by!:string;    
    Maker_Time!: string;
}


 