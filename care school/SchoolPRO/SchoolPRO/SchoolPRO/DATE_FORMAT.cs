using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SchoolPRO
{
    public class DATE_FORMAT
    {
        public static string format() 
        {
            return DateTime.Now.Date.ToString("dd-MM-yyyy");
        }
        public static string time()
        {
            return DateTime.Now.Date.ToString("HH:mm:ss");
        }
    }
}