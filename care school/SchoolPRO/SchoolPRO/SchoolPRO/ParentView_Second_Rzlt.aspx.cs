﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class ParentView_Second_Rzlt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnview_Click(object sender, EventArgs e)
        {
            try
            {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            //Session["eid"] = gvr.Cells[0].Text;
            //mvmarks.ActiveViewIndex = 1;
            if (gvr.Cells[1].Text != "&nbsp;")
            {
                Session["eid"] = gvr.Cells[1].Text;
                mvmarks.ActiveViewIndex = 1;
            }
            else
                ScriptManager.RegisterStartupScript(this, GetType(), "Invalid", "alert('This student is not Verifed, Contact School Administration')", true);
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
            
        }

        protected void gottoback_Click(object sender, EventArgs e)
        {
            mvmarks.ActiveViewIndex = 0;
        }
    }
}