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
    public partial class AdminViewMessage : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {
           try
            {
                if (Request.QueryString["ms"] != "0")
                {
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "Update tbl_Message set bisRead='True' where nMsg_id='" + Request.QueryString["ms"] + "'";
                    cmd.ExecuteNonQuery();


                    con.Close();
                }
                //else
                //    Response.Redirect("Error.aspx");
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "Select strSchName+'  '+strAddress as school from  tbl_School where nsch_id= '" + Session["nschoolid"] + "' and bisDeleted='False'";
                dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtSchool.Text = dr["school"].ToString();
                }
                else
                {

                }
                con.Close();
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
        protected void btnreply_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminReplyMessage.aspx");
        }
    }
}