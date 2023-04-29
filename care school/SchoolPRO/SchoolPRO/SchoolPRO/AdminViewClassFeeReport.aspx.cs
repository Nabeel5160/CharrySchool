using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class AdminViewClassFeeReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ddlclass_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlsc.Items.Clear();
            // dddlsec.Items.Add("--Select Class Section--");
            //dddlsecDS.DataBind();
            // dddlsec.DataSource = dddlsecDS.DataSourceMode;
            ddlsc.DataBind();
        }
    }
}