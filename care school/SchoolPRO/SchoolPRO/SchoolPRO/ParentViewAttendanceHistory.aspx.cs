using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class ParentViewAttendanceHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtstnum.Text = Session["rol"].ToString();
        }

        protected void btngoall_Click(object sender, EventArgs e)
        {
            mvst_att.ActiveViewIndex = 1;
        }

        protected void btngoback_Click(object sender, EventArgs e)
        {
            mvst_att.ActiveViewIndex = 0;
        }

        protected void btnviewother_Click(object sender, EventArgs e)
        {
            Response.Redirect("ParentViewAttendance.aspx");
        }

        protected void btngobck_Click(object sender, EventArgs e)
        {
            Response.Redirect("ParentViewAttendance.aspx");
        }

        
    }
}