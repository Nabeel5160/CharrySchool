using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class AdminViewStudentDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnvful_Click(object sender, EventArgs e)
        {
            try
            {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["cid"] = gvr.Cells[1].Text;
            Session["secs"] = gvr.Cells[3].Text;
            Session["__scid"] = gvr.Cells[5].Text;
            
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
          
            Response.Redirect("AdminViewClassStudents.aspx");
        }
    }

}