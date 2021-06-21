using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SchoolMngmnt.Models.DbModel
{
    public class TucSubject : CommonModel
    {
        public string SubjectId { get; set; }
        public string SubjectName { get; set; }
        public string TeacherId { get; set; } 
    }
}