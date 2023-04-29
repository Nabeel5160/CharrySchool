using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class StudentViewDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnviewatndnc_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                Session["id"] = gvr.Cells[1].Text;
                //Session["courscode"] = gvr.Cells[2].Text;
                mvt.ActiveViewIndex = 1;

            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
            finally
            {

            }
        }

        protected void btnuedit_Click(object sender, EventArgs e)
        {
            mvt.ActiveViewIndex = 0;
        }
    }
}