using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class StudentViewAttendanceHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
            Response.Redirect("StudentViewAttendance.aspx");
        }

        protected void btngobck_Click(object sender, EventArgs e)
        {
            Response.Redirect("StudentViewAttendance.aspx");
        }

    }
}