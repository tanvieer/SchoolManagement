using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SchoolMngmnt.Models.ViewModel
{
    public class StudentSubjectListViewModel
    {
        public string StudentId { get; set; }
        public string Username { get; set; }
        public string FullName { get; set; }
        public string SubjectName { get; set; }
        public string SubjectId { get; set; }
        public double AverageGrade { get; set; } 
        public int TestCount { get; set; } 
    }



    public class StudentTestListViewModel
    {
        public string TestId { get; set; }
        public string TestName { get; set; }
        public string SubjectId { get; set; }
        public string SubjectName { get; set; }
        public double Grade { get; set; } 
    }
      
}


 