using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SchoolMngmnt.Model.SysModel
{
    public class StatusResult<T>
    {
        public StatusResult()
        {
            Status = "FAILED";
        }
        public string Status;
        public string Message;
        public T Result;
    }
}
