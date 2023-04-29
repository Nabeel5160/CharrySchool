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
    public partial class HostalFloor : System.Web.UI.Page
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
                if (ddcl.SelectedIndex == 0 && ddhstl.SelectedIndex == 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Select Value.');", true);
                }
                else
                {
                    con.Close();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    Int64 blockid = Convert.ToInt64(ddcl.SelectedValue);
                    Int64 hostl = Convert.ToInt64(ddhstl.SelectedValue);
                    cmd.CommandText = "insert into tbl_ManageHostalFloor(nHos_id,strFlor,nsch_id,nu_id,nHBlock_id,dtAddDate,bisDeleted) values(@hst,@dcode,@sch,@blk,@blk,@date,@fbit)";
                    cmd.Parameters.AddWithValue("@dcode", txtflor.Text);
                    cmd.Parameters.AddWithValue("@sch", Session["nschoolid"].ToString());
                    cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                    cmd.Parameters.AddWithValue("@date", DATE_FORMAT.format());
                    cmd.Parameters.AddWithValue("@blk", blockid);
                    cmd.Parameters.AddWithValue("@hst", hostl);
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
                txtflor.Text = "";
                ddcl.SelectedIndex = 0;
                ddhstl.SelectedIndex = 0;
            }
        }

        protected void ddhstl_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddcl.Items.Clear();
            ddcl.Items.Add("--Select Block--");
            ddcl.DataBind();
        }
    }
}