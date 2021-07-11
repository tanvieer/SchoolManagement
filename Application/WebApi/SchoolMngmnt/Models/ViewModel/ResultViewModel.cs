using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SchoolMngmnt.Models.ViewModel
{
    public class ResultViewModel
    {
        public string ResultId { get; set; }
        public string TestId { get; set; }
        public double Grade { get; set; }
        public string Status { get; set; }
        public string StudentId { get; set; }
        public string Username { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string FullName { get { return this.FirstName + " " + this.LastName; } }

        public string TestName { get;  set; }
    }
}