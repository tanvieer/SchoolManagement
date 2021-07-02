export class Login {
    Username! : string;
    Password! : string;
}

export class statusResultO {  

    Status!:string;     
    Message!:string;    
    Result!: JwtToken; 
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
 

  export class User { 
    isLoggedIn!: string;
    Name!: string; 
    Email!: string;    
    RoleName!: string; 
    Token!: string;
  }
 