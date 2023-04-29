using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class ParentsRegistrationNumber : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           // if()
            regno.Text =Session["rgno"].ToString();
            //Session["rgno"] = null;
        }
    }
}