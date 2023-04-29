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
    public partial class ManageHostalRoom : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void ddcl_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlflor.Items.Clear();
            ddlflor.Items.Add(new ListItem("--Select Floor--", "0"));
            ddlflor.DataBind();
        }
        protected void ddhstl_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddcl.Items.Clear();
            ddcl.Items.Add(new ListItem("--Select Block--", "0"));
            ddcl.DataBind();

        }
        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
            mvdep.ActiveViewIndex = 1;
        }

        protected void btnaddclass_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddhstl.SelectedIndex == 0 && ddcl.SelectedIndex == 0 && ddlflor.SelectedIndex == 0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Select The Dropdownlist.');", true);
                }
                else
                {
                        con.Open();
                        cmd.Connection = con;
                        cmd.Parameters.Clear();
                        cmd.CommandType = CommandType.Text;
                        Int64 blockid = Convert.ToInt64(ddcl.SelectedValue);
                        Int64 hostl = Convert.ToInt64(ddhstl.SelectedValue);
                        Int64 flor = Convert.ToInt64(ddlflor.SelectedValue);
                        cmd.CommandText = "insert into tbl_ManageHostalRoom(strRooms,nHos_id,nHflor_id,nsch_id,nu_id,nHBlock_id,dtAddDate,bisDeleted) values(@rom,@hst,@flor,@sch,@uid,@blk,@date,@fbit)";
                        cmd.Parameters.AddWithValue("@blk", blockid);
                        cmd.Parameters.AddWithValue("@rom", txtroom.Text);
                        cmd.Parameters.AddWithValue("@hst", hostl);
                        cmd.Parameters.AddWithValue("@flor", flor);
                        cmd.Parameters.AddWithValue("@sch", Session["nschoolid"].ToString());
                        cmd.Parameters.AddWithValue("@uid", Session["uid"].ToString());
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
                ddlflor.SelectedIndex = 0;
                ddhstl.SelectedIndex = 0;
                txtroom.Text = "";
            }
        }
    }
}