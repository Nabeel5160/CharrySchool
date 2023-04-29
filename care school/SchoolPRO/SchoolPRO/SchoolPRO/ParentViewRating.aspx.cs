using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class ParentViewRating : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnrate_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                Session["id"] = gvr.Cells[1].Text;
                mvt.ActiveViewIndex = 1;

            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            
            }
        }

        protected void btnuedit_Click(object sender, EventArgs e)
        {
            mvt.ActiveViewIndex = 0;
        }
    }
}