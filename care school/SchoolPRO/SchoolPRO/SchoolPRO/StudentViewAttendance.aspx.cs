using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class StudentViewAttendance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnview_Click(object sender, EventArgs e)
        {
            try
            {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["enum"] = gvr.Cells[1].Text;
            Response.Redirect("StudentViewAttendanceHistory.aspx");
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
            finally
            {

            }
        }
    }
}