using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SchoolMngmnt.Models.DbModel
{
    public class TucTest
    {
        public string TestId { get; set; }
        public string TestName { get; set; }
        public string SubjectId { get; set; } 
        public DateTime TestDate { get; set; }
        public string SubjecName { get; set; }
    }
}