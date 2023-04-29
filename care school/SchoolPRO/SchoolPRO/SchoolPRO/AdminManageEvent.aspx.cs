using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace SchoolPRO
{
    public partial class AdminManageEvent : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["SchoolPro"].ToString());
        SqlCommand cmd = new SqlCommand();
        SqlDataReader dr;
        protected void btnaddevent_Click(object sender, EventArgs e)
        {
         try
         {


            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "insert into tbl_Event(nsch_id,nu_id,strtitle,strDesc,dtStartDate,dtEndDate,bisActive,dtAddDate,bisDeleted) values('"+Session["nschoolid"]+"','"+Session["uid"]+"','"+txtaddeventtitle.Text+"','" + txtaddeventdesc.Text + "','" +txtstdate.Text + "','"+txteddate.Text+"','True',CONVERT(VARCHAR(10), GETDATE(), 105 ),'False')";
           
            cmd.ExecuteNonQuery();
            con.Close();
            
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Event has been registered successfully.'); window.location = 'AdminManageEvent.aspx';", true);
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
             //PopulateData();
        }

        protected void btnedit_Click(object sender, EventArgs e)
        {
            try

            {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["cid"] = gvr.Cells[1].Text;
            txtupventtitle.Text = gvr.Cells[2].Text;
            txtupeventdesc.Text = gvr.Cells[3].Text;
            txtupstdate.Text = gvr.Cells[4].Text;
            txtupeddate.Text= gvr.Cells[5].Text;
            
            MultiView1.ActiveViewIndex = 1;
            //if (((CheckBox)gvr.Cells[6].Controls[0]).Checked)
            //{
            //    chkboxactive.Checked = true;
            //}
            //else
                chkboxactive.Checked = false;

            txtupventtitle.Focus();
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

        protected void btndel_Click(object sender, EventArgs e)
        {
            try
            {
            GridViewRow gvr = (GridViewRow)((Button)sender).NamingContainer;
            Session["cid"] = gvr.Cells[1].Text;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_Event set bisDeleted='True',dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nevent_id='" + Session["cid"] + "' and nsch_id='" + Session["nschoolid"] + "'";
            cmd.ExecuteNonQuery();
            con.Close();
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", " window.location = 'AdminManageEvent.aspx';", true);
           
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

        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
            MultiView1.ActiveViewIndex = 2;
            txtaddeventtitle.Focus();
        }

        protected void btnupevent_Click(object sender, EventArgs e)
        {
           try
           {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            string chk = "";
            if (chkboxactive.Checked)
            {
                chk = "True";
            }
            else
                chk = "False";
            cmd.CommandText = "update tbl_Event set strtitle='" + txtupventtitle.Text + "',strDesc='" + txtupeventdesc.Text + "',dtStartDate= '" + txtupstdate.Text + "',dtEndDate='" + txtupeddate.Text + "',bisActive='" + chk + "' where nevent_id='" + Session["cid"] + "' and nsch_id='" + Session["nschoolid"] + "'";
            
            cmd.ExecuteNonQuery();
            con.Close();
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", " window.location = 'AdminManageEvent.aspx';", true);

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

        protected void txtupeddate_TextChanged(object sender, EventArgs e)
        {
            try
            {
            DateTime stdt = Convert.ToDateTime(txtupstdate.Text);
            DateTime eddt = Convert.ToDateTime(txtupeddate.Text);

            if (eddt.Date >= stdt.Date)
            {
            }
            else
            {
                txtupeddate.Text = "";
                txtupeddate.Focus();
            }
            

            }
            catch (Exception ex)
            {
               // Response.Redirect("Error.aspx");
            }
            finally
            {
              
            }
        }

        protected void txteddate_TextChanged(object sender, EventArgs e)
        {
            try
            {
            DateTime stdt = Convert.ToDateTime(txtstdate.Text);
            DateTime eddt = Convert.ToDateTime(txteddate.Text);

            if (eddt.Date >= stdt.Date)
            {
            }
            else
            {
                txteddate.Text = "";
                txteddate.Focus();
            }
           
            }
            catch (Exception ex)
            {
       
            }
            finally
            {
            }
        }
    }
}