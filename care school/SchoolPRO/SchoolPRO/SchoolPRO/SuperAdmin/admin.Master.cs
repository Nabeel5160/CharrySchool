using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO.SuperAdmin
{
    public partial class admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["name"] == null)
                {
                    Response.Redirect("~/Default.aspx");
                }
                else
                {

                    lblnm.Text = Session["name"].ToString();
                    lblnm1.Text = Session["name"].ToString();
                    lblnum2.Text = Session["name"].ToString();
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/Default.aspx");
            }
        }
    }
}