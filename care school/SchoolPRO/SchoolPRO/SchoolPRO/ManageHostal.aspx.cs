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
    public partial class ManageHostal : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
            mvdep.ActiveViewIndex = 2;
            txtblk.Focus();
        }
        protected void btnaddclass_Click(object sender, EventArgs e)
        {
            try
            {
                con.Close();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "insert into tbl_ManageHostal(strHname,nsch_id,nu_id,dtAddDate,bisDeleted) values(@dep,@sch,@uid,@date,@fbit)";
                    cmd.Parameters.AddWithValue("@dep", txtblk.Text);
                    cmd.Parameters.AddWithValue("@sch", Session["nschoolid"].ToString());
                    cmd.Parameters.AddWithValue("@uid", Session["uid"].ToString());
                    cmd.Parameters.AddWithValue("@date", DATE_FORMAT.format());
                    cmd.Parameters.AddWithValue("@fbit", BIT_T_F.FalseBit());
                    cmd.ExecuteNonQuery();
                    mvdep.ActiveViewIndex = 0;
                    gvdep.DataBind();
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
                txtblk.Text = "";
            }
        }
        protected void btnedit_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                Session["cid"] = gvr.Cells[1].Text;
                txteblk.Text = gvr.Cells[2].Text;
                txteblk.Focus();
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
        protected void btnupdate_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "update tbl_ManageHostal set strHname=@edep,dtAddDate= CONVERT(VARCHAR(10), GETDATE(), 105 ) where nHos_id='" + Session["cid"] + "' and nsch_id='" + Session["nschoolid"] + "'";
                cmd.Parameters.AddWithValue("@edep", txteblk.Text);
                cmd.ExecuteNonQuery();
                con.Close();
                //txtcupdate.Text = "";
                mvdep.ActiveViewIndex = 0;
                gvdep.DataBind();
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