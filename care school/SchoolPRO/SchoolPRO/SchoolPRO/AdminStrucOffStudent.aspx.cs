using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class AdminStrucOffStudent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtsrch.Focus();
        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void btncnfrm_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                string struc = gvr.Cells[1].Text;
                TextBox rezn = (TextBox)gvr.FindControl("txtrzn");
                rezn.Focus();
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "insert into tbl_StrucOff(nsch_id,ne_id,nu_id,strReason,dtAddDate,bisDeleted) values ('" + Session["nschoolid"] + "','" + struc + "','" + Session["uid"] + "',@rzn,CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
                cmd.Parameters.AddWithValue("@rzn", rezn.Text);
                cmd.ExecuteNonQuery();
                con.Close();

                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "update tbl_Enrollment set bisDeleted='True', dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where ne_id='" + struc + "'";
                cmd.ExecuteNonQuery();
                con.Close();
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Struck off Successfully.');", true);
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }
    }
}