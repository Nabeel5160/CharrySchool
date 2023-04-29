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
    public partial class Parent : System.Web.UI.MasterPage
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["_level"].ToString() == "3")
            {

            }
            else
                Response.Redirect("Default.aspx");

            if (Session["name"] == null)
            {
                Response.Redirect("Default.aspx");
            }
            else
            lblnm.Text = Session["name"].ToString();

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
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select Count(*) as sum from tbl_Message where nU_rcv_id='" + Session["uid"] + "' and  bisRead=0 and bisDeleted=0";
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    dr.Read();
                    txtMsgCount.Text = dr["sum"].ToString();
                    txtMsgCount1.Text = dr["sum"].ToString();
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