using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace SchoolPRO.SuperAdmin
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;


        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnChange_Click(object sender, EventArgs e)
        {
            try
            {
                Boolean oldflag = false;
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "Select strPassword from tbl_Users where nu_id=@uid and bisDeleted=@fbit";
                cmd.Parameters.AddWithValue("@fbit",BIT_T_F.FalseBit());

                cmd.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    if (dr["strPassword"].ToString() == txtoldpwd.Text)
                    {
                        oldflag = true;
                    }
                }
                con.Close();

                if (oldflag)
                {
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "Update   tbl_Users set strPassword=@pswrd where nu_id=@uid and bisDeleted=@fbit";
                    cmd.Parameters.AddWithValue("@pswrd", txtpwd.Text);

                    cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());

                    cmd.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                    if (cmd.ExecuteNonQuery() != -1)
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Password has been Changed successfully.');", true);
                    else
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Password Not changed.');", true);
                    con.Close();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Old Password Not Correct.');", true);

                    txtoldpwd.Focus();
                }
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

        protected void txtoldpwd_TextChanged(object sender, EventArgs e)
        {
            try
            {
                Boolean oldflag = false;
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "Select strPassword from tbl_Users where nu_id=@uid and bisDeleted=@fbit";
                cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());

                cmd.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    if (dr["strPassword"].ToString() == txtoldpwd.Text)
                    {
                        oldflag = true;
                    }
                }
                con.Close();

                if (oldflag)
                {

                }
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