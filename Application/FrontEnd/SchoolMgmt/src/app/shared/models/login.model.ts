export class Login {
    Username! : string;
    Password! : string;
}

export class ChangePassword {
  Username! : string;
  OldPassword! : string;
  NewPassword! : string;
}

 
export class JwtToken {
    Token!: string; 
    Email!: string;
    RoleId!: string;
    getIdKey!: string;
    Session!: string;
    SessionExpireTime!: string;
    RoleName!: string;
    Status!: string;
    make_by!: string;
    Maker_Time!: string;
    Name!: string;
  }
 

  export class User { 
    isLoggedIn!: string;
    Name!: string; 
    Email!: string;    
    RoleName!: string; 
    Token!: string;
  }
  
  export class Role {
    RoleId!: number;
    RoleName!: string;
    RoleDes!: string;
  }
 