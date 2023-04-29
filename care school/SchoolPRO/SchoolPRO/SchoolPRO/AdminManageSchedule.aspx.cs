using System;
using System.Collections.Generic;
using System.Linq;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SchoolPRO
{
    public partial class AdminManageSchedule : System.Web.UI.Page
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
                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "select * from tbl_Schedule where nshd_id='" + gvr.Cells[1].Text + "' and nsch_id='"+Session["nschoolid"]+"'";

                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    Session["shduleid"] = dr["nshd_id"].ToString();
                    txtaddshdlname.Text = dr["strtimetable"].ToString();
                    txtaddshdlstdate.Text = dr["strStartDate"].ToString();
                    txtaddshdleddate.Text = dr["strEndDate"].ToString();
                    if (dr["bisActive"].ToString() == "True")
                    {
                        chkboxactive.Checked = true;
                    }
                    else
                        chkboxactive.Checked = false;
                    txtaddshdlname.Enabled = false;

                }

                con.Close();
                mvsdl.ActiveViewIndex = 1;
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

        protected void btnEidtclass_Click(object sender, EventArgs e)
        {
            Boolean updateflag = true;
            try
            {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "select * from tbl_Schedule where bisDeleted='False' and nshd_id<>'" + Session["shduleid"] + "' and nsch_id='" + Session["nschoolid"] + "'";

            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                
                
                if (dr["bisActive"].ToString() == "True")
                {
                    //chkboxactive.Checked = true;
                    updateflag = false;

                }
             

            }

            con.Close();

            if (updateflag)
            {

                con.Open();
                cmd.Connection = con;
                cmd.CommandType = CommandType.Text;
                cmd.CommandText = "update tbl_Schedule set strStartDate='" + txtaddshdlstdate.Text + "' , strEndDate='" + txtaddshdleddate.Text + "' ,bisActive=@active where nshd_id='" + Session["shduleid"] + "' and nsch_id='" + Session["nschoolid"] + "'";
                if (chkboxactive.Checked)
                    cmd.Parameters.AddWithValue("@active", true);
                else
                    cmd.Parameters.AddWithValue("@active", false);
                //  cmd.Parameters.AddWithValue("@enos", txtenos.Text);
                cmd.ExecuteNonQuery();
                con.Close();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Alert", "alert('First Deactive One Time Schedule');", true);
                mvsdl.ActiveViewIndex = 0;
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


            if(updateflag)
            Response.Redirect("AdminManageSchedule.aspx");
        }

        protected void btngotoadd_Click(object sender, EventArgs e)
        {
            mvsdl.ActiveViewIndex= 1;
        }
    }
}