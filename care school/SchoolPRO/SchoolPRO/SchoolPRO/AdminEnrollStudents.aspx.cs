using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class AdminEnrollStudents : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnreg_Click(object sender, EventArgs e)
        {
            mvreg.ActiveViewIndex = 1;
        }

        protected void btnreset_Click(object sender, EventArgs e)
        {
            mvreg.ActiveViewIndex = 0;
        }

        protected void btnsreg_Click(object sender, EventArgs e)
        {

        }
    }
}