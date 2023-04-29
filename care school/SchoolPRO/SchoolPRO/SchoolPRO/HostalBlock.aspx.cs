using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class HostalBlock : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
            mvdep.ActiveViewIndex = 1;
        }
        protected void btnaddclass_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddcl.SelectedIndex == 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Select The Dropdownlist.');", true);
                }
                else
                {
                    con.Close();
                    con.Open();
                    cmd.Connection = con;
                    Int64 iddd = Convert.ToInt64(ddcl.SelectedValue);
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "insert into tbl_ManageHostalBlock(strBlock,nsch_id,nu_id,nHos_id,dtAddDate,bisDeleted) values(@dcode,@sch,@uid,@ddls,@date,@fbit)";
                    cmd.Parameters.AddWithValue("@dcode", txtblk.Text);
                    cmd.Parameters.AddWithValue("@sch", Session["nschoolid"].ToString());
                    cmd.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                    cmd.Parameters.AddWithValue("@ddls", iddd);
                    cmd.Parameters.AddWithValue("@date", DATE_FORMAT.format());
                    cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                    cmd.ExecuteNonQuery();
                    mvdep.ActiveViewIndex = 0;
                    gvdep.DataBind();
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
                ddcl.SelectedIndex = 0;
                txtblk.Text = "";
            }
        }
    }
}