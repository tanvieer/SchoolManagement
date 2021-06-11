using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DentalBackend.Models;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace DentalBackend.Controllers
{
    [Produces("application/json")]
    [Route("api/Messages")]
    public class MessagesController : Controller
    {

        static List<Message> messages = new List<Message>
        {
                new Message
                {
                        Owner="John",
                        Text="hell"
                },
                new Message
                {
                    Owner="Tim",
                    Text="Hi"
                }
        };


        [EnableCors("Cors")]
        public IEnumerable<Message> Get()
        {
            return messages;
        }
        [EnableCors("Cors")]
        [HttpPost]
        public void Post(Message message) 
        {
            messages.Add(message);
        }

    }
}