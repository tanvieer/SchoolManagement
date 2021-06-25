﻿using SchoolMngmnt.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SchoolMngmnt.Model
{
    public class JwtPacket : CommonModel
    {
        public string Token { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; } 
        public int RoleId { get; set; } 
        public string getIdKey { get; set; }
    }
}
