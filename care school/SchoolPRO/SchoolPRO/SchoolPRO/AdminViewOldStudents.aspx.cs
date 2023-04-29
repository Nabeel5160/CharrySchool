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
    public partial class AdminViewOldStudents : System.Web.UI.Page
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
            lblid.Text = gvr.Cells[0].Text;
            txtaddmissionnum.Text = gvr.Cells[3].Text;
            txtstn.Text = gvr.Cells[2].Text;
            txtfn.Text = gvr.Cells[5].Text;
            txtaddrs.Text = gvr.Cells[8].Text;
            txtdob.Text = gvr.Cells[6].Text;
            txtstartdate.Text = gvr.Cells[9].Text;
            txtenddate.Text = gvr.Cells[10].Text;
            ddcl.SelectedValue=gvr.Cells[4].Text;
            ddsex.SelectedValue = gvr.Cells[7].Text;
            mvsub.ActiveViewIndex = 1;
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
            Session["cid"] = gvr.Cells[0].Text;
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_OldStudents set bisDeleted='True',dtDeleteDate=CONVERT(VARCHAR(10), GETDATE(), 105 ) where nold_id='" + Session["cid"] + "'";
            cmd.ExecuteNonQuery();
            con.Close();
            
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
            Response.Redirect("AdminViewOldStudents.aspx");
        }

        protected void btnupdate_Click(object sender, EventArgs e)
        {
            try
            {
            con.Open();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;
            cmd.CommandText = "update tbl_OldStudents set strclass='"+ddcl.SelectedValue+"',strName='"+txtstn.Text+"',strFname='"+txtfn.Text+"',strDOB='"+txtdob.Text+"',strGender='"+ddsex.SelectedValue+"',strAddress='"+txtaddrs.Text+"',strAddmissionNum='"+txtaddmissionnum.Text+"',dtStart_Date='"+txtstartdate.Text+"',dtEnd_Date='"+txtenddate.Text+"' where nold_id='" + lblid.Text + "' and bisDeleted=0";
            
            cmd.ExecuteNonQuery();
            con.Close();
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
            Response.Redirect("AdminViewOldStudents.aspx");
            //txtcupdate.Text = "";
           // PopulateData();
        }

        protected void btngotoAdd_Click(object sender, EventArgs e)
        {
            mvsub.ActiveViewIndex = 0;
        }
    }
}