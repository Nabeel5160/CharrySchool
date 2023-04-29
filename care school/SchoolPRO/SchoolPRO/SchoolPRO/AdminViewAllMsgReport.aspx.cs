using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class AdminViewAllMsgReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnview_full_Click(object sender, EventArgs e)
        {
            mvstlist.ActiveViewIndex = 1;
        }

        protected void btngoback_Click(object sender, EventArgs e)
        {
            mvstlist.ActiveViewIndex = 0;
        }
    }
}