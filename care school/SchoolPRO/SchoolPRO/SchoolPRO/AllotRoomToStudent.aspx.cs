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
    public partial class AllotRoomToStudent : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
            try
            {
            mvdep.ActiveViewIndex = 1;
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
        protected void ddhstl_SelectedIndexChanged(object sender, EventArgs e)
        {
         try
            {
            ddcl.Items.Clear();
            ddcl.Items.Add(new ListItem("--Select Block--", "0"));
            ddcl.DataBind();
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
        protected void ddcl_SelectedIndexChanged(object sender, EventArgs e)
        {
        try
            {
            ddlflor.Items.Clear();
            ddlflor.Items.Add(new ListItem("--Select Floor--", "0"));
            ddlflor.DataBind();
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
        protected void btnaddclass_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddhstl.SelectedIndex == 0 && ddcl.SelectedIndex == 0 && ddlflor.SelectedIndex == 0 && ddstd.SelectedIndex==0 && ddlrom.SelectedIndex==0 && ddbed.SelectedIndex==0)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Select The Dropdownlist.');", true);
                }
                else
                {
                    con.Open();
                    cmd.Connection = con;
                    cmd.Parameters.Clear();
                    cmd.CommandType = CommandType.Text;
                    Int64 Dropstd = Convert.ToInt64(ddstd.SelectedValue);
                    Int64 Drophstal = Convert.ToInt64(ddhstl.SelectedValue);
                    Int64 Dropblok = Convert.ToInt64(ddcl.SelectedValue);
                    Int64 Dropflor = Convert.ToInt64(ddlflor.SelectedValue);
                    Int64 Droprom = Convert.ToInt64(ddlrom.SelectedValue);
                    Int64 Dropbed = Convert.ToInt64(ddbed.SelectedValue);
                    cmd.CommandText = "insert into tbl_ManageHostalBedAllotStudent(nBed_id,nHos_id,nHflor_id,nHBlock_id,nHrom_id,nRegHos_id,dtAddDate,bisDeleted) values(@dbed,@dhst,@dflor,@dblk,@drom,@dstd,@date,@fbit)";
                    cmd.Parameters.AddWithValue("@dstd", Dropstd);
                    cmd.Parameters.AddWithValue("@dhst", Drophstal);
                    cmd.Parameters.AddWithValue("@dblk", Dropblok);
                    cmd.Parameters.AddWithValue("@dflor", Dropflor);
                    cmd.Parameters.AddWithValue("@drom", Droprom);
                    cmd.Parameters.AddWithValue("@dbed", Dropbed);
                    cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                    cmd.Parameters.AddWithValue("@date", DATE_FORMAT.format());
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
                ddbed.SelectedIndex = 0;
                ddstd.SelectedIndex = 0;
                ddcl.SelectedIndex = 0;
                ddhstl.SelectedIndex = 0;
                ddlflor.SelectedIndex = 0;
                ddlrom.SelectedIndex = 0;
            }
        }

        protected void ddlflor_SelectedIndexChanged(object sender, EventArgs e)
        {
          try
            {
            ddlrom.Items.Clear();
            ddlrom.Items.Add(new ListItem("--Select Room--", "0"));
            ddlrom.DataBind();
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

        protected void ddlrom_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
            ddbed.Items.Clear();
            ddbed.Items.Add(new ListItem("--Select Bed--", "0"));
            ddbed.DataBind();
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

        protected void ddbed_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.Parameters.Clear();
                cmd.CommandType = CommandType.Text;
                Int64 Dropstd = Convert.ToInt64(ddstd.SelectedValue);
                Int64 Drophstal = Convert.ToInt64(ddhstl.SelectedValue);
                Int64 Dropblok = Convert.ToInt64(ddcl.SelectedValue);
                Int64 Dropflor = Convert.ToInt64(ddlflor.SelectedValue);
                Int64 Droprom = Convert.ToInt64(ddlrom.SelectedValue);
                Int64 Dropbed = Convert.ToInt64(ddbed.SelectedValue);
                cmd.CommandText = "select nHos_id from tbl_ManageHostalBedAllotStudent where nHos_id=@dhst and nHBlock_id=@dblk and nHrom_id=@drom and nHflor_id=@dflor and bisDeleted=@fbit and nBed_id=@dbed";
                cmd.Parameters.AddWithValue("@dstd", Dropstd);
                cmd.Parameters.AddWithValue("@dhst", Drophstal);
                cmd.Parameters.AddWithValue("@dblk", Dropblok);
                cmd.Parameters.AddWithValue("@dflor", Dropflor);
                cmd.Parameters.AddWithValue("@drom", Droprom);
                cmd.Parameters.AddWithValue("@dbed", Dropbed);
                cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    //Int64 resuelt =Convert.ToInt64(dr["nHos_id"].ToString());
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Bed Are Assign Already');", true);
                    ddbed.SelectedIndex = 0;
                    ddstd.SelectedIndex = 0;
                    ddcl.SelectedIndex = 0;
                    ddhstl.SelectedIndex = 0;
                    ddlflor.SelectedIndex = 0;
                    ddlrom.SelectedIndex = 0;
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

        protected void ddstd_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.Parameters.Clear();
                cmd.CommandType = CommandType.Text;
                Int64 Dropstd = Convert.ToInt64(ddstd.SelectedValue);
                cmd.CommandText = "select nRegHos_id from tbl_ManageHostalBedAllotStudent where nRegHos_id=@dstd and bisDeleted=@fbit";
                cmd.Parameters.AddWithValue("@dstd", Dropstd);
                cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    //Int64 resuelt =Convert.ToInt64(dr["nHos_id"].ToString());
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Student Has Already Bed');", true);
                    ddstd.SelectedIndex = 0;
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