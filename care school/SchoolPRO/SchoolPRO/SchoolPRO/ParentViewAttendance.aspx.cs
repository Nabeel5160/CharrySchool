using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class ParentViewAttendance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnview_Click(object sender, EventArgs e)
        {
            try
            {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            if (gvr.Cells[1].Text != "&nbsp;")
            {
                Session["enum"] = gvr.Cells[1].Text;
                Session["rol"] = gvr.Cells[2].Text;
                Response.Redirect("ParentViewAttendanceHistory.aspx");
            }
            else
                ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "alert('This student is not Verifed, Contact School Administration')", true);
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
            
        }
    }
}