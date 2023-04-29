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
    public partial class AdminConformAdminLeave : System.Web.UI.Page
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
                cmd.CommandText = "select nG_id from tbl_Leave where bPanding='Panding' and nG_id=@userid and  nLeav_id=@lid ";
                cmd.Parameters.AddWithValue("@userid", Session["uid"].ToString());
                cmd.Parameters.AddWithValue("@lid", ids);
                dr = cmd.ExecuteReader();
                if(dr.Read())
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('You Have Not Permission To Accept Leave Requst....!')", true);
                }
                else
                {
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
                cmd.CommandText = "select nG_id from tbl_Leave where bPanding='Panding' and nG_id=@userid and  nLeav_id=@lid ";
                cmd.Parameters.AddWithValue("@userid", Session["uid"].ToString());
                cmd.Parameters.AddWithValue("@lid", ids);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('You Have Not Permission To Rejected Leave Requst....!')", true);
                }
                else
                {
                    con.Close();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.Text;
                    cmd.Parameters.Clear();
                    cmd.CommandText = "update tbl_Leave set bPanding='Rejected',strConformBy=@userid where nLeav_id=@lid ";
                    cmd.Parameters.AddWithValue("@lid", ids);
                    cmd.Parameters.AddWithValue("@userid", Session["uid"].ToString());
                    cmd.ExecuteNonQuery();
                    //Button btn = (Button)(sender);
                    //btn.Enabled = !Eval("TheFieldInYourDataSourceToCompare").ToString().Equals("NA");
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
                    if (e.Row.Cells[6].Text == "Accepted" || e.Row.Cells[6].Text == "Rejected")
                    {
                        btnaccept.Enabled = false;
                        btnreject.Enabled = false;
                    }
                //else if (e.Row.Cells[6].Text == "Rejected")
                //{
                //    btnreject.Enabled = false;
                //}
            }
        }
    }
}