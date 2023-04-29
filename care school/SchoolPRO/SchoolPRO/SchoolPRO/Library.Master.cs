using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class Library : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_level"] != null)
            {
                if (Session["_level"].ToString() == "10")
                {

                }
                else
                    Response.Redirect("Default.aspx");
            }
            else
                Response.Redirect("Default.aspx");

            if (Session["name"] == null)
            {
                Response.Redirect("Default.aspx");
            }
            else
                lblnm.Text = Session["name"].ToString();
        }
    }
}