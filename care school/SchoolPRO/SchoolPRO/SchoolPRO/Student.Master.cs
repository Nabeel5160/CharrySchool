using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
namespace SchoolPRO
{
    public partial class Student : System.Web.UI.MasterPage
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["eid"] == null)
            {
                Response.Redirect("Default.aspx");
            }
            else
                lblnm.Text = Session["stname"].ToString();

            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select Count(nevent_id) as sum from tbl_Event where bisActive=1 and bisDeleted=0 and nsch_id='" + Session["nschoolid"] + "'";
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    txtEventNotify.Text = dr["sum"].ToString();
                    txtEventNotify2.Text = dr["sum"].ToString();
                }

                con.Close();
            }
            catch (Exception)
            {
                Response.Redirect("Error.aspx");
            }
        }
    }
}