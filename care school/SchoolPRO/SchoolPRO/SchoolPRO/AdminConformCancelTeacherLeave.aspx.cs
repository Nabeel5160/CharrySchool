using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.IO;
using System.Globalization;

namespace SchoolPRO
{
    public partial class AdminConformCancelTeacherLeave : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnaccept_Click(object sender, EventArgs e)
        {
            try
            {
                string ids = ((Button)sender).CommandArgument.ToString();
                con.Close();
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Clear();
                cmd.CommandText = "update tbl_Leave set bPanding='Accepted',strConformBy=@userid where nLeav_id=@lid ";
                cmd.Parameters.AddWithValue("@userid", Session["uid"].ToString());
                cmd.Parameters.AddWithValue("@lid", ids);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    gvadmin.DataBind();
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Accept Leave Request Successfully....!')", true);
                    con.Close();
                    cmd.Parameters.Clear();
                }
            }
        }

        protected void btnreject_Click(object sender, EventArgs e)
        {
            try
            {
                string ids = ((Button)sender).CommandArgument.ToString();
                con.Close();
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.Clear();
                cmd.CommandText = "update tbl_Leave set bPanding='Rejected',strConformBy=@userid where nLeav_id=@lid ";
                cmd.Parameters.AddWithValue("@userid", Session["uid"].ToString());
                cmd.Parameters.AddWithValue("@lid", ids);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Response.Redirect("Error.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    gvadmin.DataBind();
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Rejected Leave Request Successfully....!')", true);
                    con.Close();
                    cmd.Parameters.Clear();
                }
            }
        }

        protected void gvadmin_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Button btnaccept = (e.Row.FindControl("btnaccept") as Button);
                Button btnreject = (e.Row.FindControl("btnreject") as Button);
                if (e.Row.Cells[8].Text == "Accepted" || e.Row.Cells[8].Text == "Rejected")
                {
                    btnaccept.Enabled = false;
                    btnreject.Enabled = false;
                }
            }
        }
    }
}