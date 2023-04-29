using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class AdminInbox : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btninbox_Click(object sender, EventArgs e)
        {
            mvtime.ActiveViewIndex = 0;
        }

        protected void btnsend_Click(object sender, EventArgs e)
        {
            mvtime.ActiveViewIndex = 1;
        }
    }
}