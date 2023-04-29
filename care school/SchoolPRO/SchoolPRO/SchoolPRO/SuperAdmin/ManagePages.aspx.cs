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
    public partial class ManagePages : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void btnedit_Click(object sender, EventArgs e)
        {
            try
            {
                GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
                Session["pid"] = gvr.Cells[1].Text;

                //txtcupdate.Text = gvr.Cells[2].Text;
                txtuppagecode.Enabled = false;
                Label lbl = (Label)gvr.FindControl("lblcname");
                txtuppagename.Text = lbl.Text;
                txtuppagecode.Text = gvr.Cells[3].Text;
                MultiView1.ActiveViewIndex = 2;
            }
            catch (Exception ex)
            {
                Response.Redirect("~/Error.aspx");

            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }

        protected void btndel_Click(object sender, EventArgs e)
        {
            try
            {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["pid"] = gvr.Cells[1].Text;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "Delete from tbl_Page where nPid='" + Session["pid"] + "'";
            
            cmd.ExecuteNonQuery();

            con.Close();
            Response.Redirect("ManagePages.aspx");
            }
            catch (Exception ex)
            {
                Response.Redirect("~/Error.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }

        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 1;
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select * from tbl_Page where nPcode='" + txtpagecode.Text + "' and strPname='" + txtpagename.Text + "'";
            dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Page Code already exist.');", true);
            }
            else
            {
                con.Close();
                dr.Dispose();
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "insert into tbl_Page(strPname,nPcode) values(@cname,@nos)";

                cmd.Parameters.AddWithValue("@cname", txtpagename.Text);
                cmd.Parameters.AddWithValue("@nos", txtpagecode.Text);
                cmd.ExecuteNonQuery();
                con.Close();

                Response.Redirect("ManagePages.aspx");
                //MultiView1.ActiveViewIndex = 0;
            }
            }
            catch (Exception ex)
            {
                Response.Redirect("~/Error.aspx");
            }
            finally
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }

        protected void btnupdatepage_Click(object sender, EventArgs e)
        {
            try{


            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_Page set strPname=@cname where nPid='" + Session["pid"] + "'";
            cmd.Parameters.AddWithValue("@cname", txtuppagename.Text);

            cmd.ExecuteNonQuery();

            con.Close();
            Response.Redirect("ManagePages.aspx");
            }
            catch (Exception ex)
            {
                Response.Redirect("~/Error.aspx");
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